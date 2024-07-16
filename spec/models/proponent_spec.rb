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
end
