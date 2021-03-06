import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import 'rxjs/add/operator/filter';
import * as auth0 from 'auth0-js';
import { environment } from '../environments/environment';

@Injectable()
export class AuthService {
  auth0:any;

  constructor(private router: Router) {
    var redirUrl = 'https://damp-garden-79192.herokuapp.com/callback';

    if (!environment.production) {
      redirUrl = 'http://127.0.0.1:8080/callback';
    }

    this.auth0 = new auth0.WebAuth({
      clientID: 'xHuQJZLw1YD1BVudRcJFsyVf23s5NEQE',
      domain: 'chronolog.eu.auth0.com',
      responseType: 'token id_token',
      audience: 'https://chronolog.eu.auth0.com/userinfo',
      redirectUri: redirUrl,
      scope: 'openid'
    });
  }

  public login(): void {
    this.auth0.authorize();
  }

  public handleAuthentication(): void {
    this.auth0.parseHash((err, authResult) => {
      if (authResult && authResult.accessToken && authResult.idToken) {
        window.location.hash = '';
        this.setSession(authResult);
        this.router.navigate(['/home']);
      } else if (err) {
        this.router.navigate(['/home']);
        console.log(err);
      }
    });
  }

  private setSession(authResult): void {
    // Set the time that the access token will expire at
    const expiresAt = JSON.stringify((authResult.expiresIn * 1000) + new Date().getTime());
    localStorage.setItem('access_token', authResult.accessToken);
    localStorage.setItem('id_token', authResult.idToken);
    localStorage.setItem('expires_at', expiresAt);
  }

  public logout(): void {
    // Remove tokens and expiry time from localStorage
    localStorage.removeItem('access_token');
    localStorage.removeItem('id_token');
    localStorage.removeItem('expires_at');
    // Go back to the home route
    this.router.navigate(['/']);
  }

  public isAuthenticated(): boolean {
    // Check whether the current time is past the
    // access token's expiry time
    const expiresAt = JSON.parse(localStorage.getItem('expires_at'));
    return new Date().getTime() < expiresAt;
  }
}
