import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favorites"
export default class extends Controller {
  static targets = ["buttons", "link"]

  connect() {
    // console.log(this.element)
    // console.log(this.buttonsTarget)
    // console.log(this.formTarget)
  }

  send(event) {
    event.preventDefault()

    //console.log("TODO: send request in AJAX")

    const url = this.linkTarget.action
    // console.log(url)
    const options = {
       method: "POST",
       headers: { "Accept": "application/json" },
       body: new FormData(this.linkTarget)
     }
    fetch(url, options)
       .then(response => response.json())
       .then((data) => {
        // console.log(data)
        // console.log(this.buttonsTarget)
        this.buttonsTarget.outerHTML = data.icon
       })
  }

  delete(event) {
    event.preventDefault()

    //console.log("TODO: send request in AJAX")

    const url = this.linkTarget.action
    // console.log(url)
    const options = {
       method: "DELETE",
       headers: { "Accept": "application/json" },
     }
    fetch(url, options)
       .then(response => response.json())
       .then((data) => {
        console.log(data)
        console.log(this.buttonsTarget)
        this.buttonsTarget.outerHTML = data.icon
       })
  }
}
