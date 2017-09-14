<template>
  <div>
    <q-toolbar>
      <q-btn @click="$router.push('/home')" v-if="authenticated">
        <q-icon name="home"></q-icon>
      </q-btn>
      <q-toolbar-title>
        Chronolog
      </q-toolbar-title>
      <q-btn @click="login()" v-if="!authenticated">
        <q-icon name="exit to app"></q-icon>
      </q-btn>
      <q-btn @click="logout()" v-if="authenticated">
        Logout
      </q-btn>
    </q-toolbar>
    <div class="container">
      <router-view
        :auth="auth"
        :authenticated="authenticated">
      </router-view>
    </div>
  </div>
</template>

<script>

import AuthService from './auth/AuthService'
import {
  QToolbar,
  QToolbarTitle,
  QBtn,
  QIcon
} from 'quasar'

const auth = new AuthService()
const { login, logout, authenticated, authNotifier } = auth
export default {
  components: {
    QToolbar,
    QToolbarTitle,
    QBtn,
    QIcon
  },
  name: 'app',
  data () {
    authNotifier.on('authChange', authState => {
      this.authenticated = authState.authenticated
    })
    return {
      auth,
      authenticated
    }
  },
  methods: {
    login,
    logout
  }
}
</script>
