# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proponent, type: :model do
  let(:address) do
    Address.new(street: 'Rua A', city: 'Cidade B', state: 'Estado C', zip_code: '12345-678', number: '123',
                neighborhood: 'Centro')
  end
  let(:valid_attributes) do
    {
      name: 'João Silva',
      cpf: '123.456.789-00',
      birth_date: '1980-01-01',
      salary: 2000.0,
      inss_discount: 200.0,
      personal_contact: '9999-9999',
      reference_contact: '8888-8888',
      address:
    }
  end

  it 'is valid with valid attributes' do
    proponent = Proponent.new(valid_attributes)
    expect(proponent).to be_valid
  end

  it 'is not valid without a name' do
    proponent = Proponent.new(valid_attributes.except(:name))
    expect(proponent).not_to be_valid
  end

  it 'is not valid without a cpf' do
    proponent = Proponent.new(valid_attributes.except(:cpf))
    expect(proponent).not_to be_valid
  end

  it 'is not valid without a birth_date' do
    proponent = Proponent.new(valid_attributes.except(:birth_date))
    expect(proponent).not_to be_valid
  end

  it 'is not valid without a salary' do
    proponent = Proponent.new(valid_attributes.except(:salary))
    expect(proponent).not_to be_valid
  end

  it 'is not valid without an inss_discount' do
    proponent = Proponent.new(valid_attributes.except(:inss_discount))
    expect(proponent).not_to be_valid
  end

  it 'is not valid without a personal_contact' do
    proponent = Proponent.new(valid_attributes.except(:personal_contact))
    expect(proponent).not_to be_valid
  end

  it 'is not valid without a reference_contact' do
    proponent = Proponent.new(valid_attributes.except(:reference_contact))
    expect(proponent).not_to be_valid
  end

  it 'is not valid without a unique cpf' do
    Proponent.create!(valid_attributes)
    proponent = Proponent.new(valid_attributes)
    expect(proponent).not_to be_valid
  end

  describe '.salary_ranges' do
    before do
      Proponent.create!(name: 'A', cpf: '111.111.111-11', birth_date: '1980-01-01', salary: 1000.0,
                        inss_discount: 100.0, personal_contact: '9999-9999', reference_contact: '8888-8888', address:)
      Proponent.create!(name: 'B', cpf: '222.222.222-22', birth_date: '1980-01-01', salary: 1500.0,
                        inss_discount: 150.0, personal_contact: '9999-9999', reference_contact: '8888-8888', address:)
      Proponent.create!(name: 'C', cpf: '333.333.333-33', birth_date: '1980-01-01', salary: 2500.0,
                        inss_discount: 250.0, personal_contact: '9999-9999', reference_contact: '8888-8888', address:)
      Proponent.create!(name: 'D', cpf: '444.444.444-44', birth_date: '1980-01-01', salary: 4000.0,
                        inss_discount: 400.0, personal_contact: '9999-9999', reference_contact: '8888-8888', address:)
      Proponent.create!(name: 'E', cpf: '555.555.555-55', birth_date: '1980-01-01', salary: 7000.0,
                        inss_discount: 700.0, personal_contact: '9999-9999', reference_contact: '8888-8888', address:)
    end

    it 'returns the correct salary ranges' do
      ranges = Proponent.salary_ranges
      expect(ranges['Até R$ 1.045,00'].count).to eq(1)
      expect(ranges['De R$ 1.045,01 a R$ 2.089,60'].count).to eq(1)
      expect(ranges['De R$ 2.089,61 até R$ 3.134,40'].count).to eq(1)
      expect(ranges['De R$ 3.134,41 até R$ 6.101,06'].count).to eq(1)
      expect(ranges['Acima de R$ 6.101,06'].count).to eq(1)
    end
  end
end
