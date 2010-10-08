Feature: View the information of the on air sprint
  In order to contribute to the project
  As a team member which role is scrum master or developer
  I want to view the information of the on air sprint

  Scenario Outline: No sprint is on air
    Given a project which factory name is "xmanager"
    And I am logged in as "<login>" with password "<password>"
    And I am a team member of the project
    When I go to the on air sprint page of the project
    Then I should see "No record found."

    Examples:
      | login | password |
      | venus | 123456 |
      | jessimine | 123456 |

  Scenario Outline: Show the information of the on air sprint without management links
    Given a project which factory name is "xmanager"
    And a release of the project
    And a started sprint of the release
    And I am logged in as "<login>" with password "<password>"
    And I am a team member of the project
    When I go to the on air sprint page of the project
    Then I should see "Sprint 1" within the sprint head
    And I should see "2010-09-16..2010-09-30" within the sprint head
    And I should see "Description of sprint 1" within the sprint head
    And I should not see "Add Product Backlog" within the sprint head
    And I should not see "Close" within the sprint head
    And I should not see "Edit" within the sprint head
    And I should not see "Delete" within the sprint head

    Examples:
      | login | password |
      | venus | 123456 |
      | jessimine | 123456 |

