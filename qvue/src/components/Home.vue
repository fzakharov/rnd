<template>
  <div>
    <h4 v-if="authenticated">
        You are logged in!
    </h4>
    <h4 v-if="!authenticated">
      You are not logged in! Please <a @click="auth.login()">Log In</a> to continue.
    </h4>
    <q-btn @click="ping()" v-if="authenticated">public</q-btn>
    <q-btn @click="securedPing()" v-if="authenticated">private</q-btn>
    <h3>{{ message }}</h3>
  </div>
</template>

<script>
  import { QBtn } from 'quasar'
  import Vue from 'vue'
  export default {
    components: { QBtn, Vue },
    name: 'home',
    props: ['auth', 'authenticated'],
    data () {
      const headers = { 'Authorization': 'Bearer ' + localStorage.getItem('access_token') }
      return {
        message: '',
        ping () {
          Vue.http.get('http://lvh.me:3001/api/public')
            .then(response => {
              this.message = response.body
            }, error => {
              this.message = error.statusText
            })
        },
        securedPing () {
          Vue.http.get('http://lvh.me:3001/api/private', { headers: { 'Authorization': 'Bearer ' + localStorage.getItem('access_token') } })
            .then(response => {
              this.message = response.body // .message
            }, error => {
              this.message = error.statusText
            })
        },
        adminPing () {
          this.$http.get('http://lvh.me:3001/api/private/admin', { headers })
            .then(response => {
              this.message = response.body.message
            }, error => {
              this.message = error.statusText
            })
        }
      }
    }
  }
</script>

<style>
  a {
    cursor: pointer;
  }
</style>
