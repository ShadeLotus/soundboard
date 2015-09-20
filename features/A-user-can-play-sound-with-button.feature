Feature: User can play one of the sounds in their soundpack
  As an app user
  I want to click a button to play a sound
  So that I can enhance my life with sound clips

  Background:
    Given a fresh API
    And the following sound packs:
      | id | name      | video    |
      | 1  | default   | test.mp4 |
    And the following sounds:
      | id | filename   | loop  | pack_id |
      | 1  | test-sound.mp3  | false | 1       |
      | 2  | test-sound.mp3  | true  | 1       |
    And the following users:
      | id | email           | accessToken             | default_soundpack |
      | 1  | chad@gmail.com  | 1.2.3.4.5-thats-amazing | 1                 |
    And the following soundpack assignments
      | id | user_id | soundpack_id |
      | 1  | 1       | 1            |
    And local session "user-email" is "<email>"
    And local session "user-accessToken" is "testToken"
    And I am on the homepage

  Scenario: User visits their homepage
    Then I should see 2 ".sound-button" elements
    And I should see 2 ".sound-button audio" elements

  Scenario: User starts a sound by pressing a sound button
    When I click on "button.test-sound-1"
    Then I should see "Stop" in the "button.test-sound-1" element
    And the "button.test-sound-1 audio" element should have property "currentTime" with value not "0"

  Scenario: User stops a sound by pressing a sound button
    Given the "button.test-sound-1 audio" element should have property "currentTime" with value not "0"
    When I click on "button.test-sound-1"
    Then I should see "Play" in the "button.test-sound-1" element
    And the "button.test-sound-1 audio" element should have property "currentTime" with value "0"

  Scenario: A non-looping sound should stop by itself
    When I click on "button.test-sound-1"
    And I wait 3 seconds
    Then the "button.test-sound-1 audio" element should have property "currentTime" with value "0"

  Scenario: A looping sound should not stop by itself
    When I click on "button.test-sound-2"
    And I wait 3 seconds
    Then the "button.test-sound-2 audio" element should have property "currentTime" with value not "0"
