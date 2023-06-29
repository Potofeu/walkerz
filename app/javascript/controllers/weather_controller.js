import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="weather"
export default class extends Controller {
  connect() {
    console.log("hello from weather JS")
  }
}
