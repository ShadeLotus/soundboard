Feature: Creators can manage soundpacks
  As a creator
  I want full CRUD on soundpacks and sounds
  So that I can create and manage app content

  Background:
    Given the following creators:
      | id | username             | password         |
      | 1  | chad                 | sha256("12345")  |
    And the following sound packs:
      | id | name      |
      | 1  | default   |
      | 2  | cats      |
      | 3  | christmas |
    And the following sounds:
      | id | filename  | loop  | pack_id |
      | 1  | test.mp3  | true  | 1       |
      | 2  | test.mp3  | false | 1       |
      | 3  | test.mp3  | false | 2       |
      | 4  | test.mp3  | true  | 2       |
      | 5  | test.mp3  | false | 3       |
    And the following soundpack assignments
      | id | user_id | soundpack_id |
      | 1  | 1       | 1            |
      | 2  | 1       | 2            |
      | 3  | 2       | 1            |
    And local session "user-username" is "chad"
    And I am logged in as the creator "chad"
    And I am on the homepage

  Scenario: Creators see soundpack management list
    Then I should see the ".soundpacks" element
    And I should see ".soundpack-item" in the ".soundpacks" element
    And I should see 3 ".soundpack-item" elements
    And I should see 3 ".soundpack-item .delete" elements
    And I should see 3 ".soundpack-item .edit" elements
    And I should see 3 ".soundpack-item .name" elements
    And I should see 3 ".soundpack-item .video" elements
    And I should see "Default" in the ".soundpack-default-1" element
    And I should see "Cats" in the ".soundpack-cats-2" element
    And I should see "Christmas" in the ".soundpack-christmas-3" element

  Scenario: Creators can view list of sounds on an existing soundpack
    When I click on ".soundpack-cats-2 .sounds .edit"
    Then I should see the ".sound-edit-dialog" element
    And I should see 2 ".sound-item" elements
    And I should see 2 ".sound-item .name" elements
    And I should see 2 ".sound-item .name .edit" elements
    And I should see 2 ".sound-item .play" elements
    And I should see 2 ".sound-item input[type='checkbox'].loop" elements
    And I should see 2 ".sound-item .delete" elements
    And I should see "1" in the ".sound-item-1 .id" element
    And I should see "Test" in the ".sound-item-1 .name" element
    And I should see "2" in the ".sound-item-2 .id" element
    And I should see "Test" in the ".sound-item-2 .name" element

  Scenario: Creators can edit the name of sounds from an existing soundpack
    When I click on ".soundpack-cats-2 .sounds .edit"
    And I click on ".sound-item-1 .name .edit"
    Then I should see ".sound-item-1 input[type='text'].name-edit"
    And I should see ".sound-item-1 .name-save"
    When I fill in ".name-edit" with "Candy"
    And I click on ".name-save"
    Then I should see "Candy" in the ".sound-item-1 .name" element
    When I reload the page
    Then I should see "Candy" in the ".sound-item-1 .name" element

  Scenario: Creators can toggle the loop status of sounds from an existing soundpack
    When I click on ".soundpack-cats-2 .sounds .edit"
    And I click on ".sound-item-1 input[type='checkbox'].loop"
    And I reload the page
    And I click on ".soundpack-cats-2 .sounds .edit"
    Then the ".sound-item-1 input[type='checkbox'].loop" checkbox should be checked
    When I click on ".sound-item-1 input[type='checkbox'].loop"
    And I reload the page
    And I click on ".soundpack-cats-2 .sounds .edit"
    Then the ".sound-item-1 input[type='checkbox'].loop" checkbox should be unchecked

  Scenario: Creators can delete sounds from an existing soundpack
    When I click on ".soundpack-cats-2 .sounds .edit"
    And I click on ".sound-item-1 .delete"
    Then I should see the ".sound-delete-confirmation-dialog" element
    And I should see "Really delete Test sound from Cats soundpack?" in the ".sound-delete-confirmation-dialog"
    And I should see "Yes" in the ".sound-delete-confirmation-dialog .confirm" element
    And I should see "Cancel" in the ".purchase-confirmation-dialog .cancel" element
    And I click on ".sound-delete-confirmation-dialog .cancel"
    And I should see the ".sound-item-1" element
    When I click on ".sound-item-1 .delete"
    Then I should see the ".sound-delete-confirmation-dialog" element
    When I click on ".sound-delete-confirmation-dialog .confirm"
    Then I should not see the ".sound-item-1" element
    When I reload the page
    Then I should not see the ".sound-item-1" element

  Scenario: Creators can create soundpacks
    When I click on ".soundpacks .add"
    Then I should see the ".soundpack-add-dialog" element
    And the creator successfully uploads a video
    And the creator adds atleast one sound
    And the creator clicks save or presses enter
    Then a new soundpack is created in the database with matching name and video filename
    And the new soundpack is assigned to all of the sounds
    And the new soundpack is displayed along with the existing soundpacks

  Scenario: Soundpacks require a name
    Given the creator is logged in
    When the creator visits "/"
    And the creator clicks the "add" button for soundpacks
    And the creator successfully uploads a video
    And the creator adds atleast one sound
    Then the creator cannot save the soundpack

  Scenario: Soundpacks require a video
    Given the creator is logged in
    When the creator visits "/"
    And the creator clicks the "add" button for soundpacks
    And the creator enters a unique name for the soundpack
    And the creator adds atleast one sound
    Then the creator cannot save the soundpack

  Scenario: Soundpacks require atleast one sound
    Given the creator is logged in
    When the creator visits "/"
    And the creator clicks the "add" button for soundpacks
    And the creator successfully uploads a video
    And the creator enters a unique name for the soundpack
    And the creator adds atleast one sound
    Then the creator cannot save the soundpack

  Scenario: Creators can not delete the default soundpack
    Given the creator is logged in
    When the creator visits "/"
    Then the creator does not see a "delete" button for the default soundpack

  Scenario: Creators can delete a soundpack
    Given the creator is logged in
    When the creator visits "/"
    And the creator clicks the "delete" icon for soundpack with id 2
    And the creator confirms the delete
    Then the soundpack with id 2 no longer exists in the database
    And the soundpack with id 2 no longer displays

  Scenario: Creators can rename a soundpack
    Given the creator is logged in
    When the creator visits "/"
    And the creator clicks the "edit" icon for soundpack with id "2"
    And the creator clicks in the edit field for soundpack with id "2"
    And the creator enters the text "flowers" into the name field
    And the creator clicks save
    Then the soundpack with id 2 is updated in the database to have the name "flowers"
    And the soundpack with id 2 displays the name "flowers"

  Scenario: Creators can change the video for a soundpack
    Given the creator is logged in
    And the creator visits "/"
    When the creator clicks the thumbnail edit icon
    Then a video edit dialog displays
    And the dialog has an upload video button
    And the dialog displays the video embed
