import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-hikes"
export default class extends Controller {
  static targets = ["form", "list", 'input']
  connect() {
    // console.log("hello du controller")
    // console.log(this.formTarget)
    // console.log(this.listTarget)
    // console.log(this.inputTarget)
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
    console.log(event)
    // const query = event.currentTarget.value;
    // const url = `${this.formTarget.action}?query=${query}`;

    // fetch(url,{
    //   method: "GET"
    //   headers: {
    //     'Accept': 'application/json'
    //   }
    // })
    // .then(response => response.json())
    // .then((data) => {
    //   // console.log(data)
    //   // console.log(data.listes)
    //   this.listTarget.outerHTML = data.listes;
    // })
  }
}
