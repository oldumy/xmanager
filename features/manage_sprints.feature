Feature: Manage the sprints
  In order to create a sprint
  As a product owner
  I want to create and mange the sprints

  Scenario: List the sprints of a release
    Given a project with a team member "oldumy"
    And a release of the project
    And the following sprints of the release:
      | name | estimated_started_on | estimated_closed_on | description | on_air | closed | has_sprint_backlog | closable |
      | Sprint 1 | 2010-09-16 | 2010-09-30 | Description of sprint 1 | false | true | true | true |
      | Sprint 2 | 2010-10-01 | 2010-10-15 | Description of sprint 2 | false | true | true | true |
      | Sprint 3 | 2010-10-16 | 2010-10-31 | Description of sprint 3 | true | false | true | true |
      | Sprint 4 | 2010-11-01 | 2010-11-15 | Description of sprint 4 | false | false | true | true |
      | Sprint 5 | 2010-11-16 | 2010-11-30 | Description of sprint 5 | false | false | true | true |
    And I am logged in as "oldumy" with password "123456"
    When I go to the project plannings page of the project
    Then I should see the sprint "Sprint 1" within the sprint list of the release
    And I should not see "Add Product Backlog" within the management links of "Sprint 1"
    And I should not see "Edit" within the management links of "Sprint 1"
    And I should not see "Delete" within the management links of "Sprint 1"
    And I should see the sprint "Sprint 2" within the sprint list of the release
    And I should not see "Add Product Backlog" within the management links of "Sprint 2"
    And I should not see "Edit" within the management links of "Sprint 2"
    And I should not see "Delete" within the management links of "Sprint 2"
    And I should see "Sprint 3" within the sprint list of the release
    And I should see "Add Product Backlog" within the management links of "Sprint 3"
    And I should see "Edit" within the management links of "Sprint 3"
    And I should see "Delete" within the management links of "Sprint 3"
    And I should see the sprint "Sprint 4" within the sprint list of the release
    And I should not see "Reopen" within the management links of "Sprint 4"
    And I should see "Add Product Backlog" within the management links of "Sprint 4"
    And I should see "Edit" within the management links of "Sprint 4"
    And I should see "Delete" within the management links of "Sprint 4"

  Scenario: Create a sprint
    Given a project with a team member "oldumy"
    And a release of the project
    And I am logged in as "oldumy" with password "123456"
    And I am on the new sprint page of the project
    When I fill in "Name" with "Sprint 1" within the new sprint form
    And I fill in "Description" with "Description of sprint 1" within the new sprint form
    And I fill in "Estimated Started On" with "2010-09-16" within the new sprint form
    And I fill in "Estimated Closed On" with "2010-09-30" within the new sprint form
    And I press "Save" within the new sprint form
    Then I should be on the project plannings page of the project
    And I should see the sprint "Sprint 1" within the sprint list of the release
    And I should see "Add Product Backlog" within the management links of "Sprint 1"
    And I should see "Start" within the management links of "Sprint 1"
    And I should see "Edit" within the management links of "Sprint 1"
    And I should see "Delete" within the management links of "Sprint 1"
    And I should not see "Reopen" within the management links of "Sprint 1"

  Scenario: Edit a sprint
    Given a project with a team member "oldumy"
    And a release of the project
    And a sprint of the release
    And I am logged in as "oldumy" with password "123456"
    And I am on the edit sprint page of the project
    When I fill in "Name" with "Sprint 1(new)" within the edit sprint form
    And I fill in "Description" with "Description of sprint 1(new)" within the edit sprint form
    And I fill in "Estimated Started On" with "2010-09-14" within the edit sprint form
    And I fill in "Estimated Closed On" with "2010-09-29" within the edit sprint form
    And I press "Save" within the edit sprint form
    Then I should be on the project plannings page of the project
    And I should see the sprint "Sprint 1(new)" within the sprint list of the release
    And I should see "Add Product Backlog" within the management links of "Sprint 1(new)"
    And I should see "Start" within the management links of "Sprint 1(new)"
    And I should see "Edit" within the management links of "Sprint 1(new)"
    And I should see "Delete" within the management links of "Sprint 1(new)"
    And I should not see "Reopen" within the management links of "Sprint 1(new)"

  Scenario: Delete a sprint
    Given a project with a team member "oldumy" 
    And a release of the project
    And the following sprints of the release:
      | name | estimated_started_on | estimated_closed_on | description | on_air | closed | has_sprint_backlog |
      | Sprint 1 | 2010-09-16 | 2010-09-30 | Description of sprint 1 | false | false | true |
      | Sprint 2 | 2010-10-01 | 2010-10-15 | Description of sprint 2 | false | false | true |
    And I am logged in as "oldumy" with password "123456"
    And I am on the project plannings page of the project
    When I click "Delete" within the management links of "Sprint 1"
    Then I should be on the project plannings page of the project
    And I should not see "Sprint 1" within the sprint list of the release
    And I should see the sprint "Sprint 2" within the sprint list of the release

  Scenario: Can not start a sprint without any sprint backlogs
    Given a project with a team member "oldumy"
    And a release of the project
    And the following sprints of the release:
      | name | estimated_started_on | estimated_closed_on | description | on_air | closed | has_sprint_backlog |
      | Sprint 1 | 2010-09-16 | 2010-09-30 | Description of sprint 1 | false | false | false |
    And I am logged in as "oldumy" with password "123456"
    And I am on the project plannings page of the project
    When I click "Start" within the management links of "Sprint 1"
    Then I should be on the project plannings page of the project
    And I should see "No sprint backlog found." within the notices

  Scenario: Start a sprint
    Given a project with a team member "oldumy"
    And a release of the project
    And the following sprints of the release:
      | name | estimated_started_on | estimated_closed_on | description | on_air | closed | has_sprint_backlog |
      | Sprint 1 | 2010-09-16 | 2010-09-30 | Description of sprint 1 | false | false | true |
      | Sprint 2 | 2010-10-01 | 2010-10-15 | Description of sprint 2 | false | false | true |
    And I am logged in as "oldumy" with password "123456"
    And I am on the project plannings page of the project
    When I click "Start" within the management links of "Sprint 1"
    And I should be on the on air sprint page of the project

  Scenario: Close a completed sprint 
    Given a project with a team member "oldumy"
    And a release of the project
    And the following sprints of the release:
      | name | estimated_started_on | estimated_closed_on | description | on_air | closed | has_sprint_backlog |closable |
      | Sprint 1 | 2010-09-16 | 2010-09-30 | Description of sprint 1 | true | false | true | true |
    And I am logged in as "oldumy" with password "123456"
    And I am on the on air sprint page
    When I click "Close" within the sprint "Sprint 1"
    Then I should be on the on air sprint page of the project
    And I should be noticed no record found

  Scenario: Close a uncompleted sprint 
    Given a project with a team member "oldumy"
    And a release of the project
    And the following sprints of the release:
      | name | estimated_started_on | estimated_closed_on | description | on_air | closed | has_sprint_backlog |closable |
      | Sprint 1 | 2010-09-16 | 2010-09-30 | Description of sprint 1 | true | false | true | false |
    And I am logged in as "oldumy" with password "123456"
    And I am on the on air sprint page
    When I click "Close" within the sprint "Sprint 1"
    Then I should be on the on air sprint page of the project
    And I should see "A sprint backlog is still open." within the notices

  Scenario: Reopen the sprint
    Given a project with a team member "oldumy"
    And a release of the project
    And the following sprints of the release:
      | name | estimated_started_on | estimated_closed_on | description | on_air | closed | has_sprint_backlog | closable |
      | Sprint 1 | 2010-09-16 | 2010-09-30 | Description of sprint 1 | false | true | true | true |
      | Sprint 2 | 2010-10-01 | 2010-10-15 | Description of sprint 2 | false | true | true | true |
    And I am logged in as "oldumy" with password "123456"
    And I am on the project plannings page of the project
    When I click "Reopen" within the management links of "Sprint 1"
    Then I should be on the on air sprint page of the project
