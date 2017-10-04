// === DEFAULT / CUSTOM STYLE ===
// WARNING! always comment out ONE of the two require() calls below.
// 1. use next line to activate CUSTOM STYLE (./src/themes)
// require(`./themes/app.${__THEME}.styl`)
// 2. or, use next line to activate DEFAULT QUASAR STYLE
require(`quasar/dist/quasar.${__THEME}.css`)
// ==============================

// Uncomment the following lines if you need IE11/Edge support
// require(`quasar/dist/quasar.ie`)
// require(`quasar/dist/quasar.ie.${__THEME}.css`)

import Vue from 'vue'
import VueResource from 'vue-resource'
import Quasar from 'quasar'
import router from './router'
import Factsfeed from './components/Factsfeed'
// import AuthService from './auth/AuthService'

// const auth = new AuthService()

Vue.config.productionTip = false
Vue.use(VueResource)
Vue.use(Quasar) // Install Quasar Framework
Vue.component('factsfeed', Factsfeed)

if (__THEME === 'mat') {
  require('quasar-extras/roboto-font')
}
import 'quasar-extras/material-icons'

// console.log('Before Vue.http.interceptors')
// Vue.http.interceptors.push({
//   request: (request) => {
//     console.log('Vue.http.interceptors get item')
//     const token = localStorage.getItem('access_token')
//     console.log('Vue.http.interceptors:' + token)
//     if (token !== null && token !== 'undefined') {
//       request.headers.set('Authorization', 'Bearer ' + token)
//     }
//
//     return request
//   },
//   response: (response) => {
//     if (response.status && response.status === 401) {
//       localStorage.removeItem('access_token')
//     }
//
//     if (response.data.success && response.data.result.token) {
//       localStorage.setItem('access_token', response.data.result.token)
//     }
//
//     // Refresh token
//     if (response.headers('Authorization')) {
//       localStorage.setItem('access_token', response.headers('Authorization'))
//     }
//
//     return response
//   }
// })
// console.log('After Vue.http.interceptors')
// Vue.http.options.xhr = { withCredentials: true }
// Vue.http.interceptors.push(function (request, next) {
//   // modify method
//   // modify headers
//   const token = localStorage.getItem('access_token')
//   request.headers.set('Access-Control-Allow-Headers', 'true')
//   request.headers.set('Authorization', 'Bearer ' + token)
//   console.log('access_token' + token)
//   // continue to next interceptor
//   next()
// })

Quasar.start(() => {
  /* eslint-disable no-new */
  new Vue({
    el: '#app',
    router,
    render: h => h(require('./App'))
  })
})
