import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favorites"
export default class extends Controller {
  connect() {
    console.log("hello from fav controller");
  }
}
