import Vue from 'vue'

export default class FactsfeedService {
  loadFacts (f) {
    var token = localStorage.getItem('access_token')
    Vue.http.get('http://lvh.me:3001/api/private', {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token
      }
    })
      .then(response => {
        f.facts = response.body.facts
        f.message = 'ok'
      }, error => {
        f.message = error.statusText
      })
  }
}
