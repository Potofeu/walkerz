import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="weather"
export default class extends Controller {
  static targets = ["icon"]

  connect() {
    console.log("hello from weather JS")
  }
}
