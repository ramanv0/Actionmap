# frozen_string_literal: true

When /^(?:|I )move to the search page with address (.+)$/ do |address|
  visit("/search/address=#{address.gsub!(' ', '%20').gsub!('"', '')}")
end
