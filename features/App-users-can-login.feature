Feature: New and existing app users can login
  As an app user
  I want to login with google oauth
  So that I can easily access my homepage

  Background:
    Given the following user:
      | id | email                | accessToken             | default_soundpack |
      | 1  | chad@gmail.com       | 1.2.3.4.5-thats-amazing | 1                 |
    And the following sound packs:
      | id | name      |
      | 1  | default   |


  Scenario: A new app user can login with google oauth
    Given the google email address for the user is purple@gmail.com
    When the user successfully completes an oauth request
    Then purple@gmail.com is saved as a user record
    And an accessToken should be saved for the user
    And the accessToken should be sent with every subsequent request
    And the user should see their homepage

  Scenario: An existing app user can login
    Given the google email address for the user is chad@gmail.com
    And the current accessToken for the user is 1.2.3.4.5-thats-amazing
    When the user successfully completes an oauth request
    Then a new accessToken should be saved to the user
    And the new accessToken should be returned
    And the accessToken should be sent with every subsequent request
    And the user should see their homepage

  Scenario: An unauthorized user tries to access their homepage
    Given the google email addres for the user is chad@gmail.com
    And the current accessToken for the user is 1.2.3.4.5-thats-amazing
    When the user visits '/' in the app
    Then the user is redirected to '/login'
