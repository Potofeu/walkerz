import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="update-poi-step"
export default class extends Controller {
  static targets = ["list", "id"]
  connect() {
    console.log("Hello fromn update controlller")
  }

  update() {
    const locations = this.listTarget.querySelectorAll("#id")
    locations.forEach(location => {
      const step = Array.from(locations).indexOf(location) + 1
      console.log(location.innerText)
      console.log(step)
    })
  }
}
