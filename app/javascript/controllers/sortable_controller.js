import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

// Connects to data-controller="sortable"
export default class extends Controller {
  connect() {
    Sortable.create(this.element, {
      ghostClass: "ghost",
      animation: 150,
      onEnd: Array.from(this.element.children).forEach(div => {
        console.log(div.newIndex)
      })
    })
  }
}
