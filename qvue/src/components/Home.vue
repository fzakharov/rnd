<template>
  <div>
    <h4 v-if="authenticated">
        You are logged in!
    </h4>
    <h4 v-if="!authenticated">
      You are not logged in! Please <a @click="auth.login()">Log In</a> to continue.
    </h4>
    <button
      class="btn btn-primary"
      @click="ping()">
        Call Public
    </button>

    <button
      class="btn btn-primary"
      @click="securedPing()"
      >
        Call Private
    </button>
    <h2>{{ message }}</h2>
  </div>
</template>

<script>
  export default {
    name: 'home',
    props: ['auth', 'authenticated'],
    data () {
      const accessToken = localStorage.getItem('access_token') || null
      const headers = { Authorization: `Bearer ${accessToken}` }
      return {
        message: '',
        ping () {
          this.$http.get('http://localhost:3001/api/public')
            .then(response => {
              this.message = response.body.message
            }, error => {
              this.message = error.statusText
            })
        },
        securedPing () {
          this.$http.get('http://localhost:3001/api/private', { headers })
            .then(response => {
              this.message = response.body.message
            }, error => {
              this.message = error.statusText
            })
        },
        adminPing () {
          this.$http.get('http://localhost:3001/api/private/admin', { headers })
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
