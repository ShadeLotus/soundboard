Feature: Creators can login
  As a creator
  I want to login to the CMS
  So that I can add, edit, and remove soundpacks

  Background:
    Given the following creators:
      | id | username             | password         |
      | 1  | chad                 | sha256('12345')  |

  Scenario: Unauthorized requests are redirected
    Given the creator does not have an active session
    When the creator visits '/'
    Then the creator is redirected to '/login'

  Scenario: Creator can login
    When the creator visits '/'
    And the creator clicks in the 'username' field
    And the creator types 'chad'
    And the creator clicks in the password field
    And the creator types '12345'
    And the creator presses enter
    Then the creator is redirected to their prior page
    And if no prior page then redirect to '/'
