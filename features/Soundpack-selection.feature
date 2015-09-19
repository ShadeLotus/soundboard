Feature: User can pick from their soundpacks
  As an app user
  I want to select a soundpack from an autocomplete
  So that I can access limitless diversity in sounds

  Background:
    Given the following sound pack:
      | id | name      |
      | 1  | default   |
      | 2  | christmas |
    And the following sounds:
      | id | filename   | loop  | pack_id |
      | 1  | bell1.mp3  | true  | 1       |
      | 2  | bell2.mp3  | true  | 1       |
      | 3  | bell3.mp3  | true  | 1       |
      | 4  | bell4.mp3  | true  | 1       |
      | 5  | bell5.mp3  | false | 1       |
      | 6  | bell6.mp3  | false | 1       |
      | 7  | bell7.mp3  | false | 1       |
      | 8  | bell8.mp3  | false | 1       |
      | 9  | bell9.mp3  | false | 2       |
      | 10 | bell10.mp3 | false | 2       |
      | 11 | bell11.mp3 | false | 2       |
      | 12 | bell12.mp3 | false | 2       |
      | 13 | bell13.mp3 | true  | 2       |
      | 14 | bell14.mp3 | true  | 2       |
      | 15 | bell15.mp3 | true  | 2       |
      | 16 | bell16.mp3 | true  | 2       |
    And the following users:
      | id | email           | accessToken             | default_soundpack_id |
      | 1  | chad@gmail.com  | 1.2.3.4.5-thats-amazing | 2                    |
      | 2  | lotus@gmail.com | 1.2.3.4.5-luggage       | 1                    |
    And the following soundpack assignments
      | id | user_id | soundpack_id |
      | 1  | 1       | 1            |
      | 2  | 1       | 2            |
      | 3  | 2       | 1            |

  Scenario: User with 'default' default_soundpack_id logs in and sees the 'default' soundpack
    Given the user's email is lotus@gmail.com
    When the user visits '/'
    Then the user sees one button for each sound in the 'default' soundpack

  Scenario: User with 'christmas' default_soundpack_id logs in and sees the 'christmas' soundpack
    Given the user's email is chad@gmail.com
    When the user visits '/'
    Then the user sees one button for each sound in the 'christmas' soundpack

  Scenario: User is presented with a sound selection type-ahead on the homepage
    Given the user's email is chad@gmail.com
    When the user visits '/'
    Then the user should see a type-ahead

  Scenario: User with more than one soundpack can see each soundpack in the type-ahead list
    Given the user's email is chad@gmail.com
    When the user visits '/'
    And the user clicks on the type-ahead list
    Then the user sees a list of all of their soundpacks

  Scenario: User can search their soundpacks via the type-ahead text field
    Given the user's email is chad@gmail.com
    When the user visits '/'
    And the user clicks in the type-ahead text field
    And the user enters 'christmas' in the text field
    Then the user should only see 'christmas' in the type-ahead list

  Scenario: User with more than one soundpack can select between them
    Given the user's email is chad@gmail.com
    When the user visits '/'
    And the user clicks on the 'christmas' soundpack in the type-ahead list
    Then the user sees one button for each sound in the 'christmas' soundpack

  Scenario: User with only one soundpack is prompted to add more soundpacks when trying to change soundpacks
    Given the user's email is lotus@gmail.com
    When the user visits '/'
    And the user clicks on the type-ahead list
    Then the user is notified that they can add more soundpacks
    And the user is offered a link to '/packages'
