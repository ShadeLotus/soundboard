Feature: User can play one of the 8 sounds
  As an app user
  I want to click a button to play a sound
  So that I can enhance my life sound clips

  Background:
    Given the following sound pack:
      | id | name      |
      | 1  | default   |
      | 2  | christmas |
    And the following sounds:
      | id | filename | loop  | pack_id |
      | 1  | bell.mp3 | true  | 1       |
      | 2  | bell.mp3 | true  | 1       |
      | 3  | bell.mp3 | true  | 1       |
      | 4  | bell.mp3 | true  | 1       |
      | 5  | bell.mp3 | false | 1       |
      | 6  | bell.mp3 | false | 1       |
      | 7  | bell.mp3 | false | 1       |
      | 8  | bell.mp3 | false | 1       |
      | 9  | bell.mp3 | true  | 2       |
      | 10 | bell.mp3 | true  | 2       |
      | 11 | bell.mp3 | true  | 2       |
      | 12 | bell.mp3 | true  | 2       |
      | 13 | bell.mp3 | false | 2       |
      | 14 | bell.mp3 | false | 2       |
      | 15 | bell.mp3 | false | 2       |
      | 16 | bell.mp3 | false | 2       |
    And the following users:
      | id | email                | accessToken             | default_soundpack |
      | 1  | chad@chadfurman.com  | 1.2.3.4.5-thats-amazing | 1                 |
      | 2  | lotus@chadfurman.com | 1.2.3.4.5-thats-amazing | 2                 |
    And the following soundpack assignments
      | id | user_id | soundpack_id |
      | 1  | 1       | 1            |
      | 2  | 1       | 2            |
      | 3  | 2       | 1            |

  Scenario: A new app user can login with google oauth
    Given the google email address for the user does not exist
    When the user successfully completes an oauth request
    Then an accessToken should be saved for the user
    And the accessToken should be sent with every subsequent request

  Scenario

