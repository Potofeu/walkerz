import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-hikes"
export default class extends Controller {
  static targets = ["form", "list", 'input', 'category']
  connect() {
    // console.log("hello du controller")
    // console.log(this.formTarget)
    // console.log(this.listTarget)
    // console.log(this.categoryTarget)
  }

  update(event){
    event.preventDefault();
    const query = event.currentTarget.value;
    const url = `${this.formTarget.action}?query=${query}`;

    fetch(url,{
      method: "GET",
      headers: {
        'Accept': 'application/json'
      }
    })
    .then(response => response.json())
    .then((data) => {
      // console.log(data)
      // console.log(data.listes)
      this.listTarget.outerHTML = data.listes;
    })
  }
  update_with_category(event){
    event.preventDefault();
    console.log("lien:",event.currentTarget.href);
    // On a donc plusieurs liens potentiels.
    // Il faut donc préciser qu'il s'agit de la target de l'évènement qui a été cliqué
    // pour ça, on dit : event.target.href ou event.currentTarget.href
    const url = `${event.target.href}`;
    // const url = `${event.currentTarget.href}`;

    // console.log("cont url", url);

    fetch(url,{
      method: "GET",
      headers: {
        'Accept': 'application/json'
      }
    })
    .then(response => response.json())
    .then((data) => {
      // console.log(data)
      // console.log(data.listes)
      this.listTarget.outerHTML = data.listes;
    })
  }
}
