Feature: List the projects assigned
  In order to work for the project
  As a team member which role is scrum master or developer
  I want to list the projects assigned

  Background:
    Given the following projects:
      | name | description | creater |
      | XManager | XManager is a scrum management system. | oldumy |
      | XAmaze | XAmaze is a restaurant management system. | oldumy |

  Scenario Outline: List the projects assigned
    Given I am logged in as "<login>" with password "<password>"
    And I am a team member of "XManager"
    When I go to the projects page
    Then I should see the project "XManager" without management links within the list of projects
    And I should not see "XAmaze" within the list of projects
    And I should not see "New" within the bottom buttons

    Examples:
      | login | password |
      | venus | 123456 |
      | jessimine | 123456 |


