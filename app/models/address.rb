# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :proponent

  validates :street, presence: true
  validates :number, presence: true
  validates :neighborhood, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
end
