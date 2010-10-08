Feature: Manage sprint backlogs
  In order to start a sprint
  As an product owner
  I want to add/remove product backlogs

  Background:
    Given a project with a team member "oldumy"
    And a release of the project
    And a started sprint of the release
    And I am logged in as "oldumy" with password "123456"

  Scenario: Add product backlogs to sprint
    Given a product backlog named "list_product_backlogs" of the project
    Given I am on the new sprint backlog page
    When I check "List product backlogs" within the add product backlogs form
    And I press "Save" within the add product backlogs form
    Then I should be on the project plannings page of the project
    And I should see "List product backlogs"

  Scenario: Remove a product backlog from sprint
    Given I am on the project plannings page of the project
    When I follow "Delete" within the sprint backlog head
    Then I should not have a backlog in the sprint
    And I should have 1 unscheduled product backlog in the project
    And I should be on the project plannings page of the project

  Scenario: Close a closable sprint backlog
    Given a done task of the sprint backlog
    And I am on the on air sprint page of the project
    When I follow "Close" within the sprint backlog head
    Then I should be on the on air sprint page of the project
    And I should not see "New Task" within the sprint backlog head
    And I should not see "Close" within the sprint backlog head
    And I should see "Reopen" within the sprint backlog head

  Scenario: Close a unclosable sprint backlog
    Given a task of the sprint backlog
    And I am on the on air sprint page of the project
    When I follow "Close" within the sprint backlog head
    Then I should be on the on air sprint page of the project
    And I should see "No task found or a task is still open." within the notices

  Scenario: Reopen a sprint backlog
    Given a closed sprint backlog of the sprint
    And I am on the on air sprint page of the project
    When I follow "Reopen" within the sprint backlog head
    Then I should see "New Task" within the sprint backlog head
    And I should see "Close" within the sprint backlog head
    And I should not see "Reopen" within the sprint backlog head
