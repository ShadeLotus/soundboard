Feature: New and existing app users can login
  As an app user
  I want to login with google oauth
  So that I can easily access my homepage

  Background:
    Given a fresh API
    And the following users:
      | id | email                | accessToken             | default_soundpack |
      | 1  | chad@gmail.com       | 1.2.3.4.5-thats-amazing | 1                 |
    And the following sound packs:
      | id | name      | video    |
      | 1  | default   | test.mp4 |
    And the following sounds:
      | id | filename   | loop  | pack_id |
      | 1  | bell1.mp3  | false | 1       |
      | 2  | bell1.mp3  | true  | 1       |
    And the following soundpack assignments
      | id | user_id | soundpack_id |
      | 1  | 1       | 1            |


  Scenario: App user can login with google oauth
    Given local session "user-email" is "<email>"
    When I click 'button.login'
    And I wait for 5 seconds
    Then I should be on the homepage
    And local session "user-accessToken" is "testToken"

    Examples:
      | email          |
      | chad@gmail.com |
      | nada@gmail.com |

  Scenario: An authorized user is not redirected
    Given local session "user-accessToken" is "testToken"
    When I am on the homepage
    And I wait for 5 seconds
    Then I should be on the homepage

    Examples:
      | value     |
      | undefined |
      | null      |
      | false     |
      | invalid   |

  Scenario Outline: An unauthorized user tries to access their homepage
    Given local session "user-accessToken" is "<accessTokenValue>"
    When I am on the homepage
    And I wait for 5 seconds
    Then I should be on '/login'

    Examples:
      | value     |
      | undefined |
      | null      |
      | false     |
      | invalid   |
