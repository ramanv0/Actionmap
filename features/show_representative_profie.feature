Feature: show representatives' profile

    As a citizen
    So that I can find representatives in my area
    I want to learn more detailed representative information including contact address (street, city, state, zip), political party, and a photo.

Scenario: access representative profile from search result page
  Given I move to the search page with address "626 Mission Bay Blvd N, San Francisco, CA"
  Then I should see "Alex Padilla"
  And I should see "Dianne Feinstein"
  And I should see "Nancy Pelosi"
  And I should see "David Chiu"
  Then I follow "Joseph R. Biden"
  Then I should get to "Joseph R. Biden" profile page
  Then I should see "Joseph R. Biden"
  And I should see "1600 Pennsylvania Avenue NorthwestWashingtonDC20500"
  And I should see "Democratic"

Scenario: access representative profile from news list page
  Given I move to the search page with address "9450 Gilman Dr, La Jolla, CA"
  Then I should see "Alex Padilla"
  And I should see "Dianne Feinstein"
  And I should see "Mike Levin"
  And I move to the news page of "Dianne Feinstein"
  Then I click on "Dianne Feinstein"
  Then I should get to "Dianne Feinstein" profile page
  Then I should see "Dianne Feinstein"
  And I should see "331 Hart Senate Office Building Washington, DC 20510"
  And I should see "Democratic"