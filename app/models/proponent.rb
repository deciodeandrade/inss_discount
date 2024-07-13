class Proponent < ApplicationRecord
  has_one :address, dependent: :destroy

  accepts_nested_attributes_for :address

  validates :name, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates :birth_date, presence: true
  validates :salary, presence: true
  validates :inss_discount, presence: true
  validates :personal_contact, presence: true
  validates :reference_contact, presence: true
end
