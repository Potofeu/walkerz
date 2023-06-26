import { Controller } from "@hotwired/stimulus"
import {v4 as uuidv4} from 'uuid';

// Connects to data-controller="search-location"
export default class extends Controller {
  static targets = ["form", "input", "list", "card"]

  drawResponseList(data) {
    this.listTarget.innerHTML = '';
    data.suggestions.forEach(suggestion => {
        this.listTarget.insertAdjacentHTML('beforeend', `<button name="button" type="button" class="new-location-button" data-new-location-target="btn" data-action="click -> new-location#send">
                                                          <p><strong>${suggestion.name}</strong></p>
                                                          <p>${suggestion.full_address}</p>
                                                          </button>`
                                          )
    })
  }

  update(event) {
    event.preventDefault();
    const myuuid = uuidv4();
    const url = `https://api.mapbox.com/search/searchbox/v1/suggest?q=${this.inputTarget.value}&language=fr&limit=5&session_token=myuuid&country=FR&access_token=pk.eyJ1IjoiaHVnb2ZsYW0yMyIsImEiOiJjbGlkYnVuNDcwMng3M3Rxa3ViYWF1ajFkIn0.RUTw_f53bTCap1Q_acs2Eg`
    fetch(url)
	    .then(response => response.json())
	    .then ( data => {
        this.drawResponseList(data)
	    })
  }
}
