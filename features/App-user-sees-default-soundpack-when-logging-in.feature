Feature: App user sees default soundpack when logging in
  As an app user
  I want see my default soundpack when I log in
  So that I can easily access my favorite sounds

  Background:
    Given a fresh API
    And the following sound packs:
      | id | name      | video    |
      | 1  | default   | test.mp4 |
      | 2  | christmas | test.mp4 |
    And the following sounds:
      | id | filename   | loop  | pack_id |
      | 1  | test-sound.mp3  | true  | 1       |
      | 2  | test-sound.mp3  | false | 1       |
      | 3  | test-sound.mp3  | false | 2       |
      | 4  | test-sound.mp3  | true  | 2       |
      | 5  | test-sound.mp3  | true  | 2       |
    And the following users:
      | id | email           | accessToken| default_soundpack_id |
      | 1  | chad@gmail.com  | testToken1 | 2                    |
      | 2  | lotus@gmail.com | testToken2 | 1                    |
    And the following soundpack assignments
      | id | user_id | soundpack_id |
      | 1  | 1       | 1            |
      | 2  | 1       | 2            |
      | 3  | 2       | 1            |
    And I am on the homepage

  Scenario Outline: User sees their default soundpack when logging in
    Given local session "user-email" is "<email>"
    And local session "accessToken" is "<token>"
    Then I should see <count> "button" elements
    And the "select[name='soundpack']" current option contain "<soundpack>"

    Examples:
      | email            | token      | count | soundpack |
      | chad@gmail.com   | testToken1 | 3     | christmas |
      | lotus@gmail.com  | testToken2 | 2     | default   |
