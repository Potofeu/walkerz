import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-location"
export default class extends Controller {
  static targets = ["btn", "items"]
  connect() {
    console.log("Hello from new-location controller")
    console.log(this.btnTarget)
    console.log(this.itemsTarget)
  }

  send(event) {
    event.preventDefault();
  }
}
