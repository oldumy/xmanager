Feature: Manage projects
  In order to make a project
  As a project owner
  I want to create and manage projects
  
  Scenario: Register new project
    Given a product owner is logged in as "product_owner" with password "123456"
    Given I am on the new project page
    When I fill in "project[name]" with "name 1"
    And I fill in "project[description]" with "description 1"
    And I press "project_submit"
    Then I should have 1 project(s) named "name 1" 
    
