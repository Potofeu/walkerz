import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    console.log("Hello from map controller");
    console.log("APIKEY", this.apiKeyValue);
    console.log("markers", this.markersValue)

  //   mapboxgl.accessToken = this.apiKeyValue

  //   this.map = new mapboxgl.Map({
  //     container: this.element,
  //     style: "mapbox://styles/mapbox/streets-v10"
  //   })
  // }
}
