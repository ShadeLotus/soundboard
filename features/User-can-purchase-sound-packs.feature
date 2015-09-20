Feature: Users can purchase soundpacks
  As an App User
  I want to be able to purchase soundpacks
  So that I can have a greater diversity of sound selections

  Background:
    Given a fresh API
    And the following sound packs:
      | id | name      | video    |
      | 1  | default   | test.mp4 |
      | 2  | cats      | test.mp4 |
      | 3  | christmas | test.mp4 |
    And the following sounds:
      | id | filename        | loop  | pack_id |
      | 1  | bell1.mp3       | true  | 1       |
      | 2  | cats1.mp3       | true  | 2       |
      | 3  | christmas1.mp3  | true  | 3       |
    And the following user:
      | id | email           | accessToken | default_soundpack |
      | 1  | chad@gmail.com  | testToken1  | 1                 |
    And the following soundpack assignments
      | id | user_id | soundpack_id |
      | 1  | 1       | 1            |
      | 2  | 1       | 2            |
    And local session "user-email" is "chad@gmail.com"
    And local session "accessToken" is "testToken1"
    And I am on "/packages"

  Scenario: User sees complete list of soundpacks available on purchase page
    Then I should see 3 ".soundpack-list .soundpack-item" elements
    And I should see "Default" in the ".soundpack-default-1" element
    And I should see "Cats" in the ".soundpack-cats-2" element
    And I should see "Christmas" in the ".soundpack-christmas-3" element

  Scenario: Users are shown a video thumbnail by each package
    Then I should see the ".soundpack-item .video-thumbnail" element
    And I should see the ".video-thumbnail .play-overlay" element

  Scenario: Users can view video by clicking on the play button
    When I click on ".play-overlay"
    And I wait 1 second
    Then I should see the ".full-video" element
    And the ".full-video video" element should have property "currentTime" with value not "0"
    And the ".full-video video" element should have property "src" with value matching "test.mp4"

  Scenario: User can search list of soundpacks
    When I fill in "input[type='text'].soundpack-search" with "cats"
    Then I should see the ".soundpack-cats-2" element
    But I should not see the ".soundpack-default-1" element
    And I should not see the ".soundpack-christmas-3" element
    Then I fill in "input[type='text'].soundpack-search" with ""
    And I should see the ".soundpack-cats-2" element
    And I should see the ".soundpack-default-1" element
    And I should see the ".soundpack-christmas-3" element

  Scenario: User is unable to purchase the same soundpack twice
    Then I should see the ".soundpack-christmas-3 .purchase" element
    And I should not see the ".soundpack-default-1 .purchase" element
    And I should not see the ".soundpack-cats-2 .purchase" element

  Scenario: Purchase requires confirmation
    When I click on ".soundpack-christmas-3 .purchase"
    Then I should see "Yes, purchase Christmas?" in the ".purchase-confirmation-dialog" element
    And I should see "Yes" in the ".purchase-confirmation-dialog .confirm" element
    And I should see "Cancel" in the ".purchase-confirmation-dialog .cancel" element
    Then I click on ".purchase-confirmation-dialog .cancel"
    And I should not see the ".purchase-confirmation-dialog" element
    And I should see the ".soundpack-christmas-3 .purchase" element
    Then I click on ".soundpack-christmas-3 .purchase"
    And I should see "Yes" in the ".purchase-confirmation-dialog .confirm" element
    And I should see "Cancel" in the ".purchase-confirmation-dialog .cancel" element
    Then I click on ".purchase-confirmation-dialog .confirm"
    And the request for payment is approved
    And I should not see the ".purchase-confirmation-dialog" element
    Then I reload the page
    And I should not see the ".soundpack-christmas-3 .purchase" element

  Scenario: User receives confirmed purchase
    Given I am on the homepage
    Then I should see "Default" in the ".soundpack-typeahead" element
