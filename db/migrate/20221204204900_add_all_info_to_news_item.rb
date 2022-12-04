class AddAllInfoToNewsItem < ActiveRecord::Migration[5.2]
  def change
    add_column :news_items, :all_info, :text, array: true, default: nil
  end
end
