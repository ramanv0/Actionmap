Feature: interactive map

    As a citizen
    So that I can find representatives in my area
    I want to navigate to my area by clicking on an interactive map

Background: states in database

  Given the following states exist:
  | name        | symbol | fips_code | is_territory | lat_min     | lat_max     | long_min   | long_max     |
  | California  | CA     | 06        | 0            | -124.409591 | -114.131211 | 32.534156  | -114.131211  |

Scenario: navigate to state map from national map
  Given I am on the root page
  When I navigate to state "CA"
  Then I should see "California"
  And I should see "Counties in California"
