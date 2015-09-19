Feature: Progress bar on sound buttons
  As an app user
  I want to see a progress bar while I'm playing a song
  So that I feel more in control of my sound experience

  Background:
    Given the following sound packs:
      | id | name      |
      | 1  | default   |
    And the following sounds:
      | id | filename   | loop  | pack_id |
      | 1  | bell1.mp3  | true  | 1       |
      | 2  | bell2.mp3  | true  | 1       |
    And the following user:
      | id | email           | accessToken             | default_soundpack |
      | 1  | chad@gmail.com  | 1.2.3.4.5-thats-amazing | 1                 |
    And the following soundpack assignments
      | id | user_id | soundpack_id |
      | 1  | 1       | 1            |
    And user chad@gmail.com is logged in

  Scenario: A progress indicator visually track currentTime against duration
    When the user visits '/'
    And the user clicks on the first button
    And the user waits for half of the sound's duration
    Then a progress bar should display on the button indicating 50% completion

  Scenario: Progress bar is not visible by default
    When the user visits '/'
    Then a progress bar should not be display on any buttons
