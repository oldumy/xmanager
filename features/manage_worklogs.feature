Feature: Manage the worklogs
  In order to create a worklog
  As a team member
  I want to manage the worklogs

  Background:
    Given a project with a team member "oldumy"
    And a product backlog of the project
    And a started sprint with a sprint backlog
    And a task of the product backlog
    And I am logged in as "oldumy" with password "123456"

  Scenario: List worklogs
    Given the following worklogs of the task:
        | remaining_hours | description |
        | 2 | description 1 |
        | 4 | description 2 |
    When I go to the worklogs page
    Then I should see the information of the task within the task panel
    And I should see the two worklogs within the worklog list

  Scenario: Create a worklog
    Given I am on the new worklog page of the task
    When I fill in "Remaining Hours" with "2" within the new worklog form
    And I fill in "Description" with "Description of the worklog" within the new worklog form
    And I press "Save" within the new worklog form
    Then I should be on the on air sprint page of the project

  Scenario: Edit a worklog
    Given a worklog of the task
    And I am on the edit worklog page
    When I fill in "Remaining Hours" with "1" within the edit worklog form
    And I fill in "Description" with "Description of the worklog(new)" within the edit worklog form
    And I press "Save" within the edit worklog form
    Then I should be on the worklogs page of the task
    And I should see "Remaining Hours(1)"


