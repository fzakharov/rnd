import auth0 from 'auth0-js'

export default class AuthService {
  constructor () {
    this.login = this.login.bind(this)
  }

  auth0 = new auth0.WebAuth({
    domain: 'chronolog.eu.auth0.com',
    clientID: 'xHuQJZLw1YD1BVudRcJFsyVf23s5NEQE',
    redirectUri: 'http://localhost:8080/callback',
    audience: 'https://chronolog.eu.auth0.com/userinfo',
    responseType: 'token id_token',
    scope: 'openid'
  })

  login () {
    this.auth0.authorize()
  }
}
