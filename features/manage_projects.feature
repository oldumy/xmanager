Feature: Manage projects
  In order to make a product
  As a product owner
  I want to create a project for the product and manage the project created by myself.

  Scenario: List my projects
    Given the following projects:
      | name | description | creater |
      | XManager | XManager is a scrum management system. | oldumy |
      | XAmaze | XAmaze is a restaurant management system. | oldumy |
      | SCA | SCA is a source codes auditing system. | tower |
    And I am logged in as "oldumy" with password "123456"
    When I go to the projects page
    Then I should see the project "XManager" with management links within the list of projects
    And I should see the project "XAmaze" with management links within the list of projects
    And I should see a new project button within the bottom buttons
    And I should not see "SCA" within the list of projects

  Scenario: Can manage the project if I am a team member of the project
    Given the following projects:
      | name | description | creater |
      | XManager | XManager is a scrum management system. | oldumy |
      | XAmaze | XAmaze is a restaurant management system. | oldumy |
    And I am logged in as "tower" with password "123456"
    And I am a team member of "XManager"
    When I go to the projects page
    Then I should see the project "XManager" with management links within the list of projects
    And I should not see "XAmaze" within the list of projects
  
  Scenario: Create a project
    Given I am logged in as "oldumy" with password "123456"
    And I am on the new project page
    When I fill in "Name" with "XManager" within the new project form
    And I fill in "Description" with "XManager is a scrum management system." within the new project form
    And I press "Save" within the new project form
    Then I should be on the projects page
    And I should see the project "XManager" with management links within the list of projects

  Scenario: Edit a project
    Given I am logged in as "oldumy" with password "123456"
    And I have a project
    And I am on the edit project page
    When I fill in "Name" with "XManager(new)" within the edit project form
    And I fill in "Description" with "XManager is a scrum management system(new)." within the edit project form
    And I press "Save" within the edit project form
    Then I should be on the projects page
    And I should see the project "XManager(new)" with management links within the list of projects

  Scenario: Delete a project
    Given I am logged in as "oldumy" with password "123456"
    And the following projects:
      | name | description | creater |
      | XManager | XManager is a scrum management system. | oldumy |
      | XAmaze | XAmaze is a restaurant management system. | oldumy |
    And I am on the projects page
    When I click "Delete" within the project "XManager"
    Then I should be on the projects page
    And I should see the project "XAmaze" with management links within the list of projects
    And I should not see "XManager" within the list of projects

