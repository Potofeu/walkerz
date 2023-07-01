import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="weather"
export default class extends Controller {
  static targets = ["icon", "temperature"]

  static values = { apiKey: String }

  connect() {
    console.log(this.element.value);

  //   const city = this.element.value
  //   fetch(`https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${this.apiKey}&units=metric`)
  //     .then(response => response.json())
  //     .then(data => this.#updateCard(data))
  // }

  // #updateCard(data) {
  //   this.iconTarget.src = `https://openweathermap.org/img/w/${data.weather[0].icon}.png`
  //   this.temperatureTarget.innerText = `${Math.round(data.main.temp)} °C`
  // }
  }
}
