import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="update-poi-step"
export default class extends Controller {
  static targets = ["list", "id", "input", "form", "long", "lat", "hike"]

  update() {
    this.fillSteps()
    this.fetchAction()
  }

  fillSteps() {
    this.inputTargets.forEach(target => {
      target.value = this.inputTargets.indexOf(target) + 1
    })
  }

  fetchAction() {
    this.formTargets.forEach(form => {
      const url = form.action
      console.log(`${url} /// ${Math.random()}`)
      fetch(url, {
        method: "PATCH",
        headers: { "Accept": "text/plain" },
        body: new FormData(form)
      })
      .then(response => response.text())
      .then((data) => {
        // this.cardTarget.outerHTML = data;
        console.log(`${data} /// ${Math.random()}`)
      })
    })
  }
}
