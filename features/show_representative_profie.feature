Feature: show representatives' profile

    As a citizen
    So that I can find representatives in my area
    I want to learn more detailed representative information including contact address (street, city, state, zip), political party, and a photo.


Scenario: access representative profile by clicking their names on search result page
  Given I move to the search page with address "626 Mission Bay Blvd N, San Friancisco, CA"
  Then I should see "Alex Padilla"
  And I should see "Dianne Feinstein"
  And I should see "Nancy Pelosi"
  And I should see "David Chiu"

