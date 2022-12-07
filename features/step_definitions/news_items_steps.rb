# frozen_string_literal: true

When /^(?:|I )select an article$/ do
  find('input[name="news_item[all_info]"]', match: :first).set(true)
end
