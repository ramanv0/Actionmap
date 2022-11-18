# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''
      address_temp = ''
      party_temp = ''
      photo_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id

        end

      end
      official.address&.each do |address|
        address_temp = address
      end
      #Get part and pphotoURL just by declaring, just if they are null, then pass as empty string
      official.party = party_temp
      official.photo_url = photo_temp
      # create_table "representatives", force: :cascade do |t|
      #   t.string "name"
      #   t.datetime "created_at", null: false
      #   t.datetime "updated_at", null: false
      #   t.string "ocdid"
      #   t.string "title"
      #   t.string "party"
      #   t.string "photo_url"
      #   t.string "address"
      # end
      #Check is representative exists, if it does then use update method
      if Representative.where(name).exists() != nil
        rep = Representative.update!({ name: official.name, ocdid: ocdid_temp, title: title_temp, party: party_temp, photo_url: photo_temp, address: address_temp})
      else
        rep = Representative.create!({ name: official.name, ocdid: ocdid_temp, title: title_temp, party: party_temp, photo_url: photo_temp, address: address_temp})
      end
      reps.push(rep)
    end

    reps
  end
end