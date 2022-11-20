Feature: user login/logout

    As a citizen
    So that I can find representatives in my area and add news articles
    I want to login to my account

Scenario: login with Google
    When I move to the user login page
    Then I should see "Sign In"
    And I should see "Sign in with Google"
    And I should see "Sign in with GitHub"
    Then I press "Sign in with Google"
    Then I should be on the root page

Scenario: login with GitHub
    When I move to the user login page
    Then I should see "Sign In"
    And I should see "Sign in with Google"
    And I should see "Sign in with GitHub"
    Then I press "Sign in with GitHub"
    Then I should be on the root page

Scenario: login with GitHub
    When I logout
    Then I should be on the root page
    And I should see "You have successfully logged out."

Scenario: access user profile
    Given I move to the user login page
    Then I should see "Sign In"
    And I should see "Sign in with Google"
    And I should see "Sign in with GitHub"
    Then I press "Sign in with Google"
    Then I should be on the root page
    Then I access the user profile page
    Then I should see "Your Profile"
    And I should see "Google Test Developer"