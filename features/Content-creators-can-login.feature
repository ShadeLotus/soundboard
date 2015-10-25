Feature: Creators can login
  As a creator
  I want to login to the CMS
  So that I can add, edit, and remove soundpacks

  Background:
    Given the following creators:
      | id | username             | password         |
      | 1  | chad                 | sha256("12345")  |

  Scenario Outline: Unauthorized requests are redirected
    Given local session "accessToken" is "<token>" creator does not have an active session
    When I am on the homepage
    And I wait 2 seconds
    Then I should be on "/login"

    Examples:
      | token     |
      | undefined |
      | null      |
      | invalid   |
      |           |

  Scenario Outline: Creator can login
    When I am on "/login"
    And I fill in "input[type='text'].username" with "<user>"
    And I fill in "input[type='password'].password" with "<pass>"
    And I click on ".login"
    And I wait 2 seconds
    Then I should be on "<result-page>"
    And I should see "<result-content>"

    Examples:
      | user | pass  | result-page | result-content |
      | chad | 12345 | /           | Soundpacks     |
      | chad | 123   | /login      | Oops!          |
      | chud | 12345 | /login      | Oops!          |
      |      | 12345 | /login      | Oops!          |
      |      |       | /login      | Oops!          |
      | chad |       | /login      | Oops!          |
