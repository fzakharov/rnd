import Vue from 'vue'
import Router from 'vue-router'
import Home from './components/Home'
import Welcome from './components/Welcome'
import Callback from './components/Callback'
import Error404 from './components/Error404'

Vue.use(Router)

// function load (component) {
//   // '@' is aliased to src/components
//   return () => import(`@/${component}.vue`)
// }

const router = new Router({
  mode: 'history',
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

export default router
