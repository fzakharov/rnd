import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from './components/Home'
import Welcome from './components/Welcome'
import Callback from './components/Callback'
import Error404 from './components/Error404'

Vue.use(VueRouter)

// function load (component) {
//   // '@' is aliased to src/components
//   return () => import(`@/${component}.vue`)
// }

export default new VueRouter({
  /*
   * NOTE! VueRouter "history" mode DOESN'T works for Cordova builds,
   * it is only to be used only for websites.
   *
   * If you decide to go with "history" mode, please also open /config/index.js
   * and set "build.publicPath" to something other than an empty string.
   * Example: '/' instead of current ''
   *
   * If switching back to default "hash" mode, don't forget to set the
   * build publicPath back to '' so Cordova builds work again.
   */

  routes: [
    {
      path: '/',
      name: 'Welcome',
      component: Welcome
    },
    {
      path: '/home',
      name: 'Home',
      component: Home
    },
    {
      path: '/callback',
      name: 'Callback',
      component: Callback
    },
    {
      path: '*',
      name: 'Error404',
      component: Error404
    }
  ]
})
