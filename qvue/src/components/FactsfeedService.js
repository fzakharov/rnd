import Vue from 'vue'

export default class FactsfeedService {
  loadFacts (f) {
    Vue.http.get('http://lvh.me:3001/api/public', { headers: {'Content-Type': 'application/json'} })
      .then(response => {
        f.facts = response.body.facts
      }, error => {
        this.message = error.statusText
      })
  }
}
