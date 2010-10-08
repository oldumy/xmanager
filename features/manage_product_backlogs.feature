Feature: Manage the product backlogs
  In order to create a product backlog
  As a product owner
  I want to manage the product backlogs

  Scenario Outline: List product backlogs
    Given a project with 2 team members "oldumy, tower"
    And 2 product backlogs named "create_product_backlogs, list_product_backlogs" of the project
    And I am logged in as "<login>" with password "<password>"
    When I go to the product backlogs page
    Then I should see a product backlog "Create product backlogs" with management links within the list of product backlogs
    And I should see a product backlog "List product backlogs" with management links within the list of product backlogs

    Examples:
      | login | password |
      | oldumy | 123456 |
      | tower | 123456 |

  Scenario Outline: Don't list the product backlogs added in a sprint
    Given a project with 2 team members "oldumy, tower"
    And a release of the project
    And a sprint of the release
    And a product backlog named "create_product_backlogs" and add it to the sprint
    And a product backlog named "list_product_backlogs" of the project
    And I am logged in as "<login>" with password "<password>"
    When I go to the product backlogs page
    Then I should not see "Create product backlogs" within the list of product backlogs
    And I should see a product backlog "List product backlogs" with management links within the list of product backlogs

    Examples:
      | login | password |
      | oldumy | 123456 |
      | tower | 123456 |

  Scenario Outline: Create a product backlog with valid parameters
    Given a project with 2 team members "oldumy, tower"
    And I am logged in as "<login>" with password "<password>"
    And I am on the new product backlog page
    When I fill in "Name" with "Create product backlogs" within the new product backlog form
    And I fill in "Priority" with "100" within the new product backlog form
    And I fill in "Estimated Story Points" with "3" within the new product backlog form
    And I fill in "Description" with "The description" within the new product backlog form
    And I fill in "Acceptance Criteria" with "The acceptance criteria" within the new product backlog form
    And I press "Save" within the new product backlog form
    Then I should be on the product backlogs page
    And I should see a product backlog "Create product backlogs" with management links within the list of product backlogs

    Examples:
      | login | password |
      | oldumy | 123456 |
      | tower | 123456 |

  Scenario Outline: Edit a product backlog
    Given a project with 2 team members "oldumy, tower"
    And a product backlog named "create_product_backlogs" of the project
    And I am logged in as "<login>" with password "<password>"
    And I am on the edit product backlog page
    When I fill in "Name" with "Create product backlogs(new)" within the edit product backlog form
    And I fill in "Priority" with "200" within the edit product backlog form
    And I fill in "Estimated Story Points" with "3" within the edit product backlog form
    And I fill in "Description" with "Description of creating product backlogs(new)" within the edit product backlog form
    And I fill in "Acceptance Criteria" with "Acceptance criteria of creating product backlogs(new)" within the edit product backlog form
    And I press "Save" within the edit product backlog form
    Then I should be on the product backlogs page
    And I should see a product backlog "Create product backlogs(new)" with management links within the list of product backlogs

    Examples:
      | login | password |
      | oldumy | 123456 |
      | tower | 123456 |

  Scenario Outline: Delete a product backlog
    Given a project with 2 team members "oldumy, tower"
    And 2 product backlogs named "create_product_backlogs, list_product_backlogs" of the project
    And I am logged in as "<login>" with password "<password>"
    And I am on the product backlogs page
    When I click "Delete" link of the product backlog named "Create product backlogs"
    Then I should not see "Create product backlogs" within the list of product backlogs
    And I should see a product backlog "List product backlogs" with management links within the list of product backlogs

    Examples:
      | login | password |
      | oldumy | 123456 |
      | tower | 123456 |

