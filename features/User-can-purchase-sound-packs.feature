Feature: Users can purchase soundpacks
  As an App User
  I want to be able to purchase soundpacks
  So that I can have a greater diversity of sound selections

  Background:
    Given the following sound packs:
      | id | name      |
      | 1  | default   |
      | 2  | cats      |
      | 3  | christmas |
    And the following sounds:
      | id | filename        | loop  | pack_id |
      | 1  | bell1.mp3       | true  | 1       |
      | 2  | cats1.mp3       | true  | 2       |
      | 3  | christmas1.mp3  | true  | 3       |
    And the following user:
      | id | email           | accessToken             | default_soundpack |
      | 1  | chad@gmail.com  | 1.2.3.4.5-thats-amazing | 1                 |
    And the following soundpack assignments
      | id | user_id | soundpack_id |
      | 1  | 1       | 1            |
      | 2  | 1       | 2            |
    And the user's email address is chad@gmail.com
    And the user is logged in
    And the user visits '/packages'

  Scenario: User sees complete list of soundpacks available on purchase page
    Then the user sees each package in the database

  Scenario: Users are shown a video thumbnail by each package
    Then the user sees a video thumbnail by each package in the list
    And the user sees a play button on the thumbnail

  Scenario: Users can view video by clicking on thumbnail
    When the user clicks the video thumbnail on a sound package
    Then the user sees a youtube embed

  Scenario: Users can view video by long-pressing anywhere on a package
    When the user long-presses anywhere on the package
    Then the user sees a youtube embed

  Scenario: User can search list of soundpacks
    When the user clicks in the search box
    And the user types 'cats'
    Then the user sees only the 'cats' package

  Scenario: Clearing out a search refreshes the package list
    When the user clicks in the search box
    And the user types 'cats'
    And the user sees only the 'cats' package
    And the user deletes 'cats' form the search box
    Then the user sees each package in the database

  Scenario: User is unable to purchase the same soundpack twice
    Then the 'cats' package is displayed in the list
    And the 'cats' package does not have a purchase button

  Scenario: User is prompted to confirm purchase
    When the user clicks on the purchase button for the 'christmas' package
    Then the user is prompted as follows
    """
      Yes, purchase Christmas?
    """
    And the prompt has a 'Yes' button
    And the prompt has a 'No' button

  Scenario: User receives confirmed purchase
    When the user has confirmed purchase of 'christmas' package
    And the request for payment has been approved
    And the user 'chad@gmail.com' has default_package_id 1
    Then the 'christmas' package should now be assigned to the user 'chad@gmail.com'
    And the user 'chad@gmail.com' has default_package_id 1
