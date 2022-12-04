Feature: my news items

    As a citizen
    So that I can find representatives in my area
    I want to add news articles about representatives

Background: I am logged in with Google
  When I move to the user login page
  Then I should see "Sign In"
  And I should see "Sign in with Google"
  And I should see "Sign in with GitHub"
  Then I press "Sign in with Google"
  Then I should be on the root page

Scenario: add news articles by filtering using issues
  Given I move to the search page with address "627 Arlington Avenue, Berkeley, CA"
  Then I should see "Alex Padilla"
  And I should see "Dianne Feinstein"
  And I should see "Barbara Lee"
  Then I move to the news page of "Barbara Lee"
  Then I follow "Add News Article"
  Then I should see "Edit News Item"
  And I should see "Representative"
  And I should see "Issue"
  Then I select "Gavin Newsom" from "Representative"
  And I select "Equal Pay" from "Issue"
  Then I press "Search"
  Then I should see "Select an article:"
  And I should see "Rating"
  Then I choose "news_item_all_info_the_united_states_of_political_violence_httpstimecom6227754political-violence-us-states-midterms-2022_to_better_understand_how_the_threat_of_violence_against_public_officials_is_transforming_america_time_collected_50_case_studiesone_from_each_statesince_the_attack_on_the_us_capitol_on_jan_6_2021"
  And I select "10" from "Rating"
  Then I press "Save"
  Then I should be on the user_articles page
  Then I should see "Article successfully rated!"
  And I should see "The United States of Political Violence"
  And I should see "10"