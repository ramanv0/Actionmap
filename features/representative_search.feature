Feature: search for representatives by address

    As a citizen
    So that I can find representatives in my area
    I want to search for represenatives by address


Scenario: search for representatives
    When I move to the search page with address "110 Sproul Hall, Berkeley, CA"
    Then I should see "Gavin Newsom"
    Then I should see "Eleni Kounalakis"
    Then I should see "Shirley N. Weber"
    Then I should see "Rob Bonta"
    Then I should see "Phong La"

