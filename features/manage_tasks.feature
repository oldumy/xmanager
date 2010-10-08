Feature: Manage the tasks
  In order to create a task
  As a scrum master
  I want to create and manage the tasks

  Background:
    Given a project with a team member "venus"
    And a product backlog of the project
    And a started sprint with a sprint backlog
    And I am logged in as "venus" with password "123456"

  Scenario: Create a task
    Given I am on the new task page
    When I fill in "Name" with "Define the properties of the product model" within the new task form
    And I fill in "Description" with "Description of the task" within the new task form
    And I select "Venus" from "Assign To" within the new task form
    And I fill in "Estimated Hours" with "8" within the new task form
    And I press "Save" within the new task form
    Then I should be on the on air sprint page of the project
    And I should see "Define the properties of the product model"

  Scenario: Edit a task
    Given a task of the product backlog
    And I am on the edit task page
    When I fill in "Name" with "Define the properties of the product model(new)" within the edit task form
    And I fill in "Description" with "Description of the task(new)" within the edit task form
    And I select "Venus" from "Assign To" within the edit task form
    And I fill in "Estimated Hours" with "10" within the edit task form
    And I press "Save" within the edit task form
    Then I should be on the on air sprint page of the project
    And I should see "Define the properties of the product model(new)"

  Scenario: Delete a task
    Given a task of the product backlog
    And I am on the on air sprint page of the project
    When I follow "Delete" within the task head
    Then I should not have a task of the product backlog
    And I should be on the on air sprint page of the project
    And I should not see "Define the properties of the product model"

  Scenario: Reopen a task
    Given a done task of the sprint backlog
    And I am on the on air sprint page of the project
    When I follow "Reopen" within the task head
    Then I should be on the on air sprint page of the project
    And I should see "Close" within the task head
    And I should see "Edit" within the task head
    And I should see "Delete" within the task head
    And I should not see "Reopen" within the task head

