import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

export default class extends Controller {
  static targets = ['btnNavigate', 'btnLocate']
  static values = {
    apiKey: String,
    markers: Array
  }
  connect() {
    // console.log("Hello from map controller");
    // console.log("APIKEY", this.apiKeyValue);
    // console.log("markers", this.markersValue)
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    });

    this.#addMarkersToMap();
    this.#fitMapToMarkers();
    this.#traceRoute();
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.marker_html);
      // Create a HTML element for your custom marker
      const customMarker = document.createElement("div");
      customMarker.innerHTML = marker.marker_html;
      new mapboxgl.Marker(customMarker)
      .setLngLat([ marker.lng, marker.lat ])
      // .setPopup(popup)
      .addTo(this.map)
    })
  }

  #fitMapToMarkers() {

    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]));
    // ajustement de la quantité d'espace nécessaire autour des itinéraires
    const padding = { top: 50, bottom: 50, left: 50, right: 50 };
    // On limite le niveau de zoom maximal
    // et on supprime l'animation d'ajustement de la carte avec duration 0
    const options = { padding, maxZoom: 15, duration: 0 };

    this.map.fitBounds(bounds, options);
  }

  #traceRoute() {

    const coordinates = this.markersValue.map(marker => [marker.lng, marker.lat]);


    const directionsRequest = `https://api.mapbox.com/directions/v5/mapbox/walking/${coordinates.join(';')}?steps=true&geometries=geojson&access_token=${mapboxgl.accessToken}&language=fr`;

    fetch(directionsRequest)
      .then(response => response.json())
      .then(data => {
        const routeCoordinates = data.routes[0].geometry.coordinates;
        // Partie ajout des instructions de guidage
        const steps = data.routes[0].legs[0].steps; // On extrait les étapes de direction de l'API

        // console.log(steps);

        // console.log(steps.length);
        // console.log("first",steps[0].geometry.coordinates[0]);
        // console.log("first",steps[steps.length-1].geometry.coordinates[0]);

        // Pour afficher les élements de direction, de navigation sur la carte
        const directions = new MapboxDirections({
          accessToken: mapboxgl.accessToken,
          unit: 'metric',
          profile: 'mapbox/walking',
          alternatives: false,
          geometries: 'geojson',
          language: "fr",
          steps: true,
          controls: { instructions: true },
          flyTo: false
        });

        // Ajout de la navigation guidée dans la carte
        this.map.addControl(directions, 'top-left');
        // On fixe le point de départ
        directions.setOrigin(steps[0].geometry.coordinates[0]);
        // Le point de destination : directions.setDestination([data["longitude"], data["latitude"]]);
        directions.setDestination(steps[steps.length-1].geometry.coordinates[0]);

        this.map.on("load", () => {
          this.map.addSource("route", {
            type: "geojson",
            data: {
              type: "Feature",
              properties: {},
              geometry: {
                type: "LineString",
                coordinates: routeCoordinates
              }
            }
          });

          this.map.addLayer({
            id: "route",
            type: "line",
            source: "route",
            layout: {
              "line-join": "round",
              "line-cap": "round"
            },
            paint: {
              "line-color": "#E57C23",
              "line-width": 5
            }
          });
        });
      });
  }

  navigate(event){
    event.preventDefault();
    console.log("lien:", this.btnLocateTarget);
    console.log("navigate");
    // On récupère la map
    const mapContainer = this.element;
    console.log(mapContainer);
    // Vérifie si la classe fullscreen est déjà présente sur la carte
    const isFullscreen = mapContainer.classList.contains('fullscreen');

    // Si la carte est déjà en plein écran, on supprime la classe
    if (isFullscreen) {
      mapContainer.classList.remove('fullscreen');
      const directionsControl = document.querySelector('.directions-control.directions-control');
      directionsControl.style.maxWidth = '100%';
      this.btnNavigateTarget.style.left = '289px';

    } else {
      // Sinon, on ajoute la classe pour mettre la carte en plein écran
      mapContainer.classList.add('fullscreen');
      this.btnNavigateTarget.style.left = '303px';
    }
  }

}
