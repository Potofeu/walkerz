import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

// Connects to data-controller="typed-js"
export default class extends Controller {
  connect() {
    new Typed(this.element, {
      strings: ["Discover places like never before!"],
      typeSpeed: 50,
      loop: true
    })
  }
}
