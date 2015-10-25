Feature: User can pick from their soundpacks
  As an app user
  I want to select a soundpack from an autocomplete
  So that I can access limitless diversity in sounds

  Background:
    Given a fresh API
    And the following sound packs:
      | id | name      | video    |
      | 1  | default   | test.mp4 |
      | 2  | christmas | test.mp4 |
      | 3  | not-used  | test.mp4 |
    And the following sounds:
      | id | filename   | loop  | pack_id |
      | 1  | test-sound.mp3  | true  | 1       |
      | 2  | test-sound.mp3  | false | 1       |
      | 3  | test-sound.mp3  | false | 2       |
      | 4  | test-sound.mp3  | true  | 2       |
      | 5  | test-sound.mp3  | true  | 2       |
      | 6  | test-sound.mp3  | false | 3       |
      | 7  | test-sound.mp3  | true  | 3       |
    And the following users:
      | id | email           | accessToken| default_soundpack_id |
      | 1  | chad@gmail.com  | testToken1 | 2                    |
      | 2  | lotus@gmail.com | testToken2 | 1                    |
    And the following soundpack assignments
      | id | user_id | soundpack_id |
      | 1  | 1       | 1            |
      | 2  | 1       | 2            |
      | 3  | 2       | 1            |
    And local session "user-email" is "chad@gmail.com"
    And local session "accessToken" is "testToken1"
    And I am on the homepage

  Scenario: User is presented with a sound selection type-ahead on the homepage
    Then I should see the ".soundpack-typeahead" element
    And I should see "Default" in the ".soundpack-typeahead" element

  Scenario: User with more than one soundpack can see each of their assigned soundpacks in the list
    When I click on ".soundpack-typeahead"
    Then I should see 2 ".soundpack-option" elements

  Scenario Outline: User can search their soundpacks via the type-ahead text field
    When I click on ".soundpack-typeahead"
    And I type "<soundpack>" into the field
    Then I should see the ".soundpack-typeahead .<soundpack>-option" element
    But I should not see the ".soundpack-typeahead .<excluded>-option" element

    Examples:
      | soundpack | excluded  |
      | default   | christmas |
      | christmas | default   |

  Scenario Outline: User with more than one soundpack can select between them
    When I click on ".soundpack-option.soundpack-<soundpack>"
    Then I should see <count> ".sound-button" elements

    Examples:
      | soundpack | count  |
      | christmas | 3      |
      | default   | 2      |

  Scenario: User with only one soundpack is prompted to add more soundpacks when trying to change soundpacks
    Given local session "user-email" is "lotus@gmail.com"
    And local session "accessToken" is "testToken2"
    When I click on ".soundpack-typeahead"
    Then I should see the ".more-soundpacks-dialog" element
    And I should see the text matching "Click here for more soundpacks!"
    And I should see the element "a[href='/packages']"
