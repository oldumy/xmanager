Feature: Manage releases of a project
  In order to create a release
  As a product owner
  I want to manage releases

  Scenario: List releases
    Given a project with a team member "oldumy"
    And the following releases of the project:
      | name | estimated_released_on | description |
      | 0.1.0 | 2010-09-30 | Description of 0.1.0 |
      | 0.2.0 | 2010-10-31 | Description of 0.2.0 |
    And I am logged in as "oldumy" with password "123456"
    When I go to the project plannings page of the project
    Then I should see the release "0.1.0" with management links within the list of releases 
    And I should see the release "0.2.0" with management links within the list of releases 

  Scenario: Create a release
    Given a project with a team member "oldumy" 
    And I am logged in as "oldumy" with password "123456"
    And I am on the new release page
    When I fill in "Name" with "0.2.0" within the new release form
    And I fill in "Description" with "Second release" within the new release form
    And I fill in "Estimated Released On" with "2010-09-30" within the new release form 
    And I press "Save" within the new release form
    Then I should be on the project plannings page of the project
    And I should see the release "0.2.0" with management links within the list of releases 

  Scenario: Edit a release
    Given a project with a team member "oldumy" 
    And a release of the project
    And I am logged in as "oldumy" with password "123456"
    And I am on the edit release page
    When I fill in "Name" with "0.3" within the edit release form
    And I fill in "Description" with "Third release" within the edit release form
    And I fill in "Estimated Released On" with "2010-10-31" within the edit release form
    And I press "Save" within the edit release form
    Then I should be on the project plannings page of the project
    And I should see the release "0.3" with management links within the list of releases 

  Scenario: Delete a release
    Given a project with a team member "oldumy"
    And the following releases of the project:
      | name | estimated_released_on | description |
      | 0.1.0 | 2010-09-30 | Description of 0.1.0 |
      | 0.2.0 | 2010-10-31 | Description of 0.2.0 |
    And I am logged in as "oldumy" with password "123456"
    And I am on the project plannings page of the project
    When I click "Delete" within the release "0.1.0"
    Then I should be on the project plannings page of the project
    And I should not see "0.1.0" within the list of releases 
    And I should see the release "0.2.0" with management links within the list of releases 

  Scenario: List released releases
    Given a project with a team member "oldumy"
    And the following released releases of the project:
      | name | estimated_released_on | description |
      | 0.1.0 | 2010-09-30 | Description of 0.1.0 |
      | 0.2.0 | 2010-10-31 | Description of 0.2.0 |
    And I am logged in as "oldumy" with password "123456"
    When I go to the project plannings page of the project
    Then I should see the released release "0.1.0" with management links within the list of released releases 
    And I should see the released release "0.2.0" with management links within the list of released releases 

  Scenario: Release a release
    Given a project with a team member "oldumy"
    And the following releases of the project:
      | name | estimated_released_on | description |
      | 0.1.0 | 2010-09-30 | Description of 0.1.0 |
      | 0.2.0 | 2010-10-31 | Description of 0.2.0 |
    And I am logged in as "oldumy" with password "123456"
    And I am on the project plannings page of the project
    When I click "Release" within the release "0.1.0"
    Then I should be on the project plannings page of the project
    And I should see the release "0.2.0" with management links within the list of releases 
    And I should see the released release "0.1.0" with management links within the list of released releases 

  Scenario: Release a release with a sprint not closed
    Given a project with a team member "oldumy"
    And a release "Version 1.0" of the project
    And a not closed sprint of the release
    And I am logged in as "oldumy" with password "123456"
    And I am on the project plannings page of the project
    When I click "Release" within the release "Version 1.0"
    Then I should be on the project plannings page of the project
    And I should see the release "Version 1.0" with management links within the list of releases 
    And I should see "No sprint exists, or some sprints are not closed." within the notices

  Scenario: Turn back a release
    Given a project with a team member "oldumy"
    And the following released releases of the project:
      | name | estimated_released_on | description |
      | 0.1.0 | 2010-09-30 | Description of 0.1.0 |
      | 0.2.0 | 2010-10-31 | Description of 0.2.0 |
    And I am logged in as "oldumy" with password "123456"
    And I am on the project plannings page of the project
    When I click "Turn Back" within the release "0.2.0" 
    Then I should be on the project plannings page of the project
    And I should see the release "0.2.0" with management links within the list of releases 
    And I should see the released release "0.1.0" with management links within the list of released releases 

