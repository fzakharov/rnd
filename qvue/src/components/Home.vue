<template>
  <div>
    <h4 v-if="authenticated">
        You are logged in!
    </h4>
    <h4 v-if="!authenticated">
      You are not logged in! Please <a @click="auth.login()">Log In</a> to continue.
    </h4>
    <q-btn @click="ping()">public</q-btn>
    <q-btn @click="securedPing()" v-if="authenticated">private</q-btn>
    <h5>{{ message }}</h5>
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
      return {
        message: '',
        ping () {
          Vue.http.get('http://lvh.me:3001/api/public', { headers: {'Content-Type': 'application/json'} })
            .then(response => {
              this.message = response.body.message
            }, error => {
              this.message = error.statusText
            })
        },
        securedPing () {
          var token = localStorage.getItem('access_token')
          Vue.http.get('http://lvh.me:3001/api/private', {
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ' + token
            }
          })
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
