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
        next unless office.official_indices.include? index

        title_temp = office.name
        ocdid_temp = office.division_id
        party_temp = official.party
        photo_temp = official.photo_url

        official.address&.each do |address|
          street_name = ''
          if address.line1 != nil
            street_name = street_name + address.line1
          elsif address.line2 != nil
            street_name = street_name + address.line2
          elsif address.line3 != nil
            street_name = street_name + address.line3
          end
          address_temp = street_name + address.city + address.state + address.zip
        end
        rep = Representative.find_or_create_by!({ name: official.name, ocdid: ocdid_temp, title: title_temp, party: party_temp, photo_url: photo_temp, address: address_temp})
        reps.push(rep)
      end
    end
    reps
  end
end