import { Controller } from "@hotwired/stimulus"
import map_controller from "./map_controller";

// Connects to data-controller="toggle-map"
export default class extends Controller {
  static targets = ['fullScreenMap', 'midScreenMap', 'btnNavigate', 'btnLocate'];

  static values = {
    apiKey: String,
    markers: Array
  }

  fullScreen(){
    this.fullScreenMapTarget.classList.remove("d-none");
    this.midScreenMapTarget.classList.add("d-none");

    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.fullScreenMapTarget,
      style: "mapbox://styles/mapbox/streets-v10"
    });

    this.#addMarkersToMap();
    this.#fitMapToMarkers();
    this.#traceRoute();

  }

  midScreen(){
    this.fullScreenMapTarget.classList.add("d-none");
    this.midScreenMapTarget.classList.remove("d-none");
  }

   // Activer la géolocalisation
   locate(event) {
    event.preventDefault();

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(this.handlePosition.bind(this));
    } else {
      console.log("La géolocalisation n'est pas prise en charge par votre navigateur.");
    }
  }

  handlePosition(position) {
    const latitude = position.coords.latitude;
    const longitude = position.coords.longitude;

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
        // directions.setDestination(this.markersValue[this.markersValue.length-1].lng, this.markersValue[this.markersValue.length-1].lat);

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

}
