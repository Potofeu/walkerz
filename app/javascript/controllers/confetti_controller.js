import { Controller } from "@hotwired/stimulus"
import confetti from "canvas-confetti"
require('canvas-confetti')

// Connects to data-controller="confetti"
export default class extends Controller {
  connect() {
    confetti()
  }
}
