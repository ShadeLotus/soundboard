Feature: Creators can manage soundpacks
  As a creator
  I want full CRUD on soundpacks and sounds
  So that I can create and manage app content

  Background:
    Given the following creators:
      | id | username             | password         |
      | 1  | chad                 | sha256('12345')  |
    And the following sound packs:
      | id | name      |
      | 1  | default   |
      | 2  | cats      |
      | 3  | christmas |
    And the following sounds:
      | id | filename   | loop  | pack_id |
      | 1  | bell1.mp3  | true  | 1       |
      | 2  | bell2.mp3  | false | 1       |
      | 3  | bell3.mp3  | false | 2       |
      | 4  | bell4.mp3  | true  | 2       |
    And the following soundpack assignments
      | id | user_id | soundpack_id |
      | 1  | 1       | 1            |
      | 2  | 1       | 2            |
      | 3  | 2       | 1            |

  Scenario: Creators see soundpack management list
    Given the creator is logged in
    When the creator visits '/'
    Then the creator sees a list of all packages in the database
    And each package has a delete button
    And each package has an edit button
    And each package has a name
    And each package has a video

  Scenario: Creators can view list of sounds on an existing soundpack
    Given the creator is logged in
    When the creator visits '/'
    And the creator clicks the soundpack edit icon for 'cats'
    Then a list of sounds displays in a dialog
    And each sound has a name
    And the name is a human-readable version of the filename
    And each sound has a name edit icon
    And each sound has a "play me" link
    And each sound has a "loop" label and corresponding checkbox
    And each sound has a "delete" button

  Scenario: Creators can edit the name of sounds from an existing soundpack
    Given the creator is logged in
    When the creator visits '/'
    And the creator clicks the name edit icon for sound with id '1'
    And the creator types 'Candy' into the name edit field
    And the creator clicks save or presses enter
    Then the sound with id '1' should now have filename 'candy.mp3'
    And the sound with id '1' should be displayed with name 'Candy'

  Scenario: Creators can toggle the loop status of sounds from an existing soundpack
    Given the creator is logged in
    When the creator visits '/'
    And the creator clicks the loop status checkbox for sound with id '1'
    Then the sound with id '1' should have loop status '0'
    And the sound with id '1' should be displayed with loop status '0'

  Scenario: Creators can delete sounds from an existing soundpack
    Given the creator is logged in
    When the creator visits '/'
    And the creator clicks the delete icon for sound with id '1'
    And the user confirms they wish to delete the sound
    Then the sound with id '1' should be removed from the soundpack
    And the sound with id '1' should not be displayed on the soundlist for package 'default'

  Scenario: Creators can create soundpacks
    Given the creator is logged in
    When the creator visits '/'
    And the creator clicks the 'add' button for soundpacks
    And the creator enters a unique name for the soundpack
    And the creator successfully uploads a video
    And the creator adds atleast one sound
    And the creator clicks save or presses enter
    Then a new soundpack is created in the database with matching name and video filename
    And the new soundpack is assigned to all of the sounds
    And the new soundpack is displayed along with the existing soundpacks

  Scenario: Soundpacks require a name
    Given the creator is logged in
    When the creator visits '/'
    And the creator clicks the 'add' button for soundpacks
    And the creator successfully uploads a video
    And the creator adds atleast one sound
    Then the creator cannot save the soundpack

  Scenario: Soundpacks require a video
    Given the creator is logged in
    When the creator visits '/'
    And the creator clicks the 'add' button for soundpacks
    And the creator enters a unique name for the soundpack
    And the creator adds atleast one sound
    Then the creator cannot save the soundpack

  Scenario: Soundpacks require atleast one sound
    Given the creator is logged in
    When the creator visits '/'
    And the creator clicks the 'add' button for soundpacks
    And the creator successfully uploads a video
    And the creator enters a unique name for the soundpack
    And the creator adds atleast one sound
    Then the creator cannot save the soundpack

  Scenario: Creators can not delete the default soundpack
    Given the creator is logged in
    When the creator visits '/'
    Then the creator does not see a 'delete' button for the default soundpack

  Scenario: Creators can delete a soundpack
    Given the creator is logged in
    When the creator visits '/'
    And the creator clicks the 'delete' icon for soundpack with id 2
    And the creator confirms the delete
    Then the soundpack with id 2 no longer exists in the database
    And the soundpack with id 2 no longer displays

  Scenario: Creators can rename a soundpack
    Given the creator is logged in
    When the creator visits '/'
    And the creator clicks the 'edit' icon for soundpack with id '2'
    And the creator clicks in the edit field for soundpack with id '2'
    And the creator enters the text 'flowers' into the name field
    And the creator clicks save
    Then the soundpack with id 2 is updated in the database to have the name 'flowers'
    And the soundpack with id 2 displays the name 'flowers'

  Scenario: Creators can change the video for a soundpack
    Given the creator is logged in
    And the creator visits '/'
    When the creator clicks the thumbnail edit icon
    Then a video edit dialog displays
    And the dialog has an upload video button
    And the dialog displays the video embed
