Feature: Manage the on air sprint
  In order to create tasks and assign tasks to team members
  As a product owner
  I want to manage the on air sprint

  Background:
    Given I am logged in as "oldumy" with password "123456"

  Scenario: No sprint is on air
    Given a project with a team member "oldumy"
    When I go to the on air sprint page of the project
    Then I should see "No record found."

  Scenario: Show the on air sprint
    Given a project with a team member "oldumy"
    And a release of the project
    And a started sprint of the release
    When I go to the on air sprint page of the project
    Then I should see "Sprint 1" within the head of sprint
    And I should see "2010-09-16..2010-09-30" within the head of sprint
    And I should see "Description of sprint 1" within the head of sprint
    And I should see "Close" within the management links of sprint

  Scenario: List the sprint backlogs of the on air sprint
    Given a project with a team member "oldumy"
    And a release of the project
    And a started sprint of the release
    And add the following 2 product backlogs to the sprint:
      | name |
      | create_product_backlogs |
      | list_product_backlogs |
    When I go to the on air sprint page of the project
    Then I should see the sprint backlog "Create product backlogs" with management links within the list of sprint backlogs
    Then I should see the sprint backlog "List product backlogs" with management links within the list of sprint backlogs

  Scenario: Show the properties and management links of tasks
    Given a project with a team member "oldumy"
    And a release of the project
    And a started sprint of the release
    And a task of the product backlog
    And I am logged in as "oldumy" with password "123456"
    When I go to the on air sprint page of the project
    Then I should see "Define the properties of the product backlog" within the task head
    And I should see "Online Dummy" within the task head
    And I should see "Estimated Hours(4)" within the task head
    And I should see "Remaining Hours(4)" within the task head
    And I should see "Logs(0)" within the task head
    And I should see "Log" within the task head
    And I should see "Edit" within the task head
    And I should see "Delete" within the task head


