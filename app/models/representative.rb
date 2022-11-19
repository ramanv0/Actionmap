# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      dict = set_up_attrs

      rep_info.offices.each do |office|
        next unless office.official_indices.include? index

        update_dict(dict, office.name, office.division_id, official.party, official.photo_url)
        dict['address_temp'] = build_address(official.address[0]) unless official.address.nil?
        rep = Representative.find_or_create_by!({ name: official.name, ocdid: dict['ocdid_temp'],
title: dict['title_temp'], party: dict['party_temp'], photo_url: dict['photo_temp'], address: dict['address_temp'] })
        reps.push(rep)
      end
    end
    reps
  end

  def self.set_up_attrs
    %w[ocdid_temp title_temp add_temp party_temp photo_temp].each_with_object('').to_h
  end

  def self.update_dict(dict, name, division_id, party, photo_url)
    dict['title_temp'] = name
    dict['ocdid_temp'] = division_id
    dict['party_temp'] = party
    dict['photo_temp'] = photo_url
  end

  def self.build_address(first_address)
    street_name = check_address_lines(first_address.line1, false)
    street_name += check_address_lines(first_address.line2, true)
    street_name += check_address_lines(first_address.line3, true)
    "#{street_name}, #{first_address.city}, #{first_address.state}, #{first_address.zip}"
  end

  def self.check_address_lines(line, comma)
    street_name = ''
    if line.present?
      street_name += ', ' if comma
      street_name += line
    end
    street_name
  end
end
