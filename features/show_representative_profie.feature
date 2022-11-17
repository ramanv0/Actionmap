Feature: show representatives' profile

    As a citizen
    So that I can find representatives in my area
    I want to learn more detailed representative information including contact address (street, city, state, zip), political party, and a photo.

Scenario: access representative profile from search result page
  Given I move to the search page with address "626 Mission Bay Blvd N, San Friancisco, CA"
  Then I should see "Alex Padilla"
  And I should see "Dianne Feinstein"
  And I should see "Nancy Pelosi"
  And I should see "David Chiu"
  Then I follow "Alex Padilla"
  Then I should get to "Alex Padilla" profile page
  Then I should see "Alex Padilla"
  And I should see "112 Hart Senate Office Building Washington, DC 20510"
  And I should see "Democratic"

Scenario: access representative profile from news list page
  Given I move to the search page with address "9450 Gilman Dr, La Jolla, CA"
  Then I should see "Alex Padilla"
  And I should see "Dianne Feinstein"
  And I should see "Mike Levin"
  And I move to the news page of "Dianne Feinstein"
  Then I follow "Dianne Feinstein"
  Then I should get to "Dianne Feinstein" profile page
  Then I should see "Dianne Feinstein"
  And I should see "331 Hart Senate Office Building Washington, DC 20510"
  And I should see "Democratic"