Feature: Progress bar on sound buttons
  As an app user
  I want to see a progress bar while I'm playing a song
  So that I feel more in control of my sound experience

  Background:
    Given a fresh API
    And the following sound packs:
      | id | name      | video    |
      | 1  | default   | test.mp4 |
    And the following sounds:
      | id | filename        | loop  | pack_id |
      | 1  | test-sound.mp3  | false | 1       |
      | 2  | test-sound.mp3  | true  | 1       |
    And the following user:
      | id | email           | accessToken             | default_soundpack |
      | 1  | chad@gmail.com  | 1.2.3.4.5-thats-amazing | 1                 |
    And the following soundpack assignments
      | id | user_id | soundpack_id |
      | 1  | 1       | 1            |
    Given local session "user-email" is "chad@gmail.com"
    And I am on the homepage

  Scenario: Progress bar is not visible by default
    Then I should see 2 "button" elements
    And I should see 2 "button audio" elements
    And the "button .progress-bar" element exists
    And I should not see a "button .progress-bar"

  Scenario: A progress indicator visually track currentTime against duration
    When I click on "button.test-sound-1"
    And I wait 1 seconds
    Then I should see a "button .progress-bar"
    And the "button.test-sound-1 .progress-bar" element should have property "width" with value not "0"

  Scenario: Progress bar goes away
    When I click on "button.test-sound-1"
    And I wait 3 seconds
    Then the "button.test-sound-1 .progress-bar" element should exist
    And the "button.test-sound-1 .progress-bar" element should have property "width" with value not "0"
    And I should not see a "button .progress-bar" element

