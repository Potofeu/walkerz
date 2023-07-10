import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="weather"
export default class extends Controller {
  static values = { apiKey: String }

  static targets = ["icon", "temperature", "city"]

  connect() {
    // console.log(this.cityTarget.attributes.city.value);
    // console.log(this.cityTarget.attributes.api.value);
    // console.log(this.temperatureTarget);

    const city = this.cityTarget.attributes.city.value
    const apikey = this.cityTarget.attributes.api.value
    fetch(`https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apikey}&units=metric`)
      .then(response => response.json())
      .then(data => this.#updateCard(data))
  }

  #updateCard(data) {
    this.iconTarget.src = `https://openweathermap.org/img/w/${data.weather[0].icon}.png`
    this.temperatureTarget.innerText = `${Math.round(data.main.temp)} °C`
  }
}
