import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String }

  static targets = ["address", "name", "wrapper"]

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address,poi"
    })
    this.geocoder.addTo(this.wrapperTarget)
    this.geocoder.on("result", event => this.#setInputValue(event))
    this.geocoder.on("clear", () => this.#clearInputValue())
  }

  #setInputValue(event) {
    const locationAdress = event.result["properties"]["address"]
    const locationZipcode = event.result["context"]["1"]["text"]
    const locationCity = event.result["context"]["3"]["text"]
    const locationCountry = event.result["context"]["4"]["text"]
    this.nameTarget.value = event.result["text"]
    this.addressTarget.value = `${locationAdress}, ${locationCity}, ${locationZipcode}, ${locationCountry}`
  }

  #clearInputValue() {
    this.addressTarget.value = ""
    this.nameTarget.value = ""
  }

  disconnect() {
    this.geocoder.onRemove()
  }
}
