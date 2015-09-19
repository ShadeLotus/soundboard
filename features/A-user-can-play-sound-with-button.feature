Feature: User can play one of the sounds in their soundpack
  As an app user
  I want to click a button to play a sound
  So that I can enhance my life with sound clips

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
    And the user's email address is chad@gmail.com
    And the user is logged in

  Scenario: User visits their homepage
    When the user visits '/'
    Then the user should see one button for each sound in their default_soundpack

  Scenario: User starts a sound by pressing a sound button
    When the user visits '/'
    And the user clicks on the first button
    Then the audio element for the first button should start to play

  Scenario: User stops a sound by pressing a sound button
    Given the audio element for the first button is playing
    When the user clicks on the first button again to stop a sound
    Then the audio element for the first button should stop playing

  Scenario: A non-looping sound should stop by itself
    Given the audio element for the first button is playing
    When the user waits until the audio element for the first button has elapsed its duration
    Then the audio element for the first button should stop playing

  Scenario: A looping sound should not stop by itself
    Given the audio element for the first button is playing
    When the user waits until the audio element for the first button has elapsed its duration
    Then the audio element for the first button should stop playing
