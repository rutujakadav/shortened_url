# README

Implementation of Link shortener API. Accept URLs and return shorter URLs and which can redirect to the actual URL.

User Stories Covered:

* **As a user, I want to be able to create a new shortened link where I provide a url and it is shortened:**
  * API accepts user provided long URL (required) and alias for URL (optional).
  * Table `link_shorteners` is created to store user inputs.
  * Function `url_shortener` added to generate shortend url which will replace longs URL's domain with user provided short alias or it will auto generate alias.
  * API returns shortend URL.
  
  > *Request*:
  > curl --location --request POST 'http://localhost:3001/url_shortener?url=https%3A%2F%2Fgithub.com%2Fjwt%2Fruby-jwt&alias=jwt_gem' \
  --header 'Authorization: eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MywiZXhwIjoxNjg2NTA2MzMzfQ.532nYuKHcCuFxpMIm0urO1WLuIYeZ-G5z75crRTQtPg'
  > 
  > *Response*:
  > {"success":true,"shortend_url":"http://localhost:3001/jwt_gem"}
  `

* **As a user, when I click on a shortened link it will redirect me to the real url:**
  * Route added to redirect shortend url to its real url.
  * Route will call function `redirect_to_og_url` which will find real url to redirect to.

  > *Request*:
  > curl --location 'http://localhost:3001/jwt_gem'
  >
  > *Response*:
  > Page redirects to real URL

* **As a user, I can create, through the API, an account using username and password:**
  * Sign up and Sign in implemented using devise gem.
  * Reference https://rubydoc.info/github/heartcombo/devise.

* **As a user, I can login, through the API, to my account to retrieve an API token which will be used for other requests:**
  * Implemented using https://github.com/jwt/ruby-jwt/blob/main/README.md.
  * Devise session controller modified to generate JWT token.
  * Generated token will be shown to user after login. 
  * Token validation set for 24 hours.

* **As a user, using the API token, I want to be able to create a new shortened link where I provide a url and it is shortened:**
  * User can get API token after login in.
  * API token can be provided to header while making call to API `url_shortener`.
  * If token is valid, shortend url will be returned else it will return error.
