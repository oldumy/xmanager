Feature: List the product backlogs
  In order to the unscheduled product backlogs
  As a team member, not a product owner
  I want to view the list of the unscheduled product backlogs

  Scenario Outline: List the product backlogs without the management links
    Given a project with 2 team members "venus, jessimine"
    And 2 product backlogs named "create_product_backlogs, list_product_backlogs" of the project
    And I am logged in as "<login>" with password "<password>"
    When I go to the product backlogs page of the project
    Then I should see a product backlog "Create product backlogs" without management links within the list of product backlogs
    And I should see a product backlog "List product backlogs" without management links within the list of product backlogs
    And I should not see "New" within the bottom buttons

    Examples:
      | login | password |
      | venus | 123456 |
      | jessimine | 123456 |
