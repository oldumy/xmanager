Feature: Manage projects
  In order to make a project
  As a project owner
  I want to create and manage projects

  Scenario: Projects list
    Given the following projects:
        | name | description |
        | XManager | XManager is a scrum management system |
        | XAmaze | XAmaze is a restaurant management system |
    And I am logged in as "product_owner" with password "123456"
    When I go to the projects page
    Then I should see "XManager"
    And I should see "XManager is a scrum management system"
    And I should see "XAmaze"
    And I should see "XAmaze is a restaurant management system"
  
  Scenario: Register new project
    Given I am logged in as "product_owner" with password "123456"
    And I am on the new project page
    When I fill in "project[name]" with "name 1"
    And I fill in "project[description]" with "description 1"
    And I press "project_submit"
    Then I should have 1 project named "name 1" 
    And I should be on the projects page

  Scenario: Edit a project
    Given I have a project named XManager
    And I am logged in as "product_owner" with password "123456"
    And I go to the edit project page
    When I fill in "project[name]" with "New XManager"
    And I fill in "project[description]" with "Description of New XManager"
    And I press "project_submit"
    Then I should have 1 project named "New XManager"
    And I should be on the projects page

  Scenario: Delete a project
    Given the following projects:
        | name | description |
        | XManager | XManager is a scrum management system |
        | XAmaze | XAmaze is a restaurant management system |
    And I am logged in as "product_owner" with password "123456"
    When I delete the project named XAmaze
    Then I should be on the projects page
    And I should see the following projects:
        | name | description |
        | XManager | XManager is a scrum management system |
    And I should not see "XAmaze"

  Scenario Outline: Show or hide the management links of project and new project link
    Given the following projects:
        | name | description |
        | XManager | XManager is a scrum management system |
        | XAmaze | XAmaze is a restaurant management system |
    And I am logged in as "<login>" with password "<password>"
    When I go to the projects page
    Then I should <action1>
    And I should <action2>

    Examples:
      | login | password | action1 | action2 |
      | product_owner | 123456 | see "Edit" and "Delete" | see "New" |
      | scrum_master | 123456 | not see "Edit" and "Delete" | not see "New" |
      | developer | 123456 | not see "Edit" and "Delete" | not see "New" |


