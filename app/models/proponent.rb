# frozen_string_literal: true

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

  def self.salary_ranges
    {
      'Até R$ 1.045,00' => Proponent.where('salary <= ?', 1045),
      'De R$ 1.045,01 a R$ 2.089,60' => Proponent.where('salary > ? AND salary <= ?', 1045, 2089.60),
      'De R$ 2.089,61 até R$ 3.134,40' => Proponent.where('salary > ? AND salary <= ?', 2089.60, 3134.40),
      'De R$ 3.134,41 até R$ 6.101,06' => Proponent.where('salary > ? AND salary <= ?', 3134.40, 6101.06),
      'Acima de R$ 6.101,06' => Proponent.where('salary > ?', 6101.06)
    }
  end
end
