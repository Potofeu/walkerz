import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

export default class extends Controller {
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
    })

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
        const instructionsContainer = document.getElementById('directions-instructions');
        // Efface le contenu précédent des instructions
        instructionsContainer.innerHTML = '';
        // Parcourt les étapes de direction et les ajoute à l'élément HTML des instructions
        steps.forEach(step => {
          const instruction = document.createElement('p');
          const durationMinutes = Math.round(step.duration / 60); // Temps de trajet en minutes
          instruction.textContent = `${step.maneuver.instruction} (${durationMinutes} minutes)`;
          instructionsContainer.appendChild(instruction);
        });
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
