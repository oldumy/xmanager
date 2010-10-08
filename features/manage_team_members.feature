Feature: Manage team members of a project
  In order to create the product
  As a product owner
  I want to manage the team members of the project

  Background:
    Given I am logged in as "oldumy" with password "123456"
    And I have a project which factory name is "xmanager"
    And I have a list of people

  Scenario: List team members
    Given I am on the team members page of the project
    Then I should not see any team member
    And I should see a list of candidates

  Scenario: Add team members
    Given I am on the team members page of the project
    When I check "Tower He" in the candidates
    And I check "Venus" in the candidates
    And I press "Add"
    Then I should see tower, venus in team members
    And I should not see tower, venus in candidates

  Scenario: Remove team members
    Given I have 2 team members tower, venus
    Given I am on the team members page of the project
    When I click "Tower He" in the team members
    Then I should not see tower in team members
    And I should see venus in team members
    And I should see tower in candidates
    And I should not see venus in candidates


