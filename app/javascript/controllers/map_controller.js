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
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html);
      // Create a HTML element for your custom marker
      const customMarker = document.createElement("div");
      customMarker.className = "customMarker"; // Utilise la classe customMarker
      // customMarker.innerHTML = marker.marker_html;
      new mapboxgl.Marker({ element: customMarker })
      .setLngLat([ marker.lng, marker.lat ])
      .setPopup(popup)
      .addTo(this.map)
    })
  }
  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 20, duration: 0 })
  }

  #traceRoute() {
    const coordinates = this.markersValue.map(marker => [marker.lng, marker.lat]);

    const directionsRequest = `https://api.mapbox.com/directions/v5/mapbox/walking/${coordinates.join(';')}?steps=true&geometries=geojson&access_token=${mapboxgl.accessToken}`;

    fetch(directionsRequest)
      .then(response => response.json())
      .then(data => {
        const routeCoordinates = data.routes[0].geometry.coordinates;

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
