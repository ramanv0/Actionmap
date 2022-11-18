# frozen_string_literal: true

When /^(?:|I )move to the search page with address (.+)$/ do |address|
  visit("/search/address=#{address.gsub!(' ', '%20').gsub!('"', '')}")
end

When /^(?:|I )move to the profile page of (.+)$/ do |rep_name|
  rep = Representative.find_by(name: rep_name)
  visit(representative_path(id: rep.id))
end

Then /^(?:|I )should get to "(.*)" profile page$/ do |rep_name|
  current_path = URI.parse(current_url).path
  rep = Representative.find_by(name: rep_name)
  if current_path.respond_to? :should
    current_path.should == representative_path(id: rep.id)
  else
    assert_equal representative_path(id: rep.id), current_path
  end
end

When /^(?:|I )click on "([^"]*)"$/ do |link|
  within(".text-center.unique") do
    click_on(link)
  end
end

Given /^(?:|I )move to the news page of "(.*)"$/ do |rep_name|
  rep = Representative.find_by(name: rep_name)
  visit(representative_news_items_path(representative_id: rep.id))
end