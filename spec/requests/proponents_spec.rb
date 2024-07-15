# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Proponents', type: :request do
  let(:address) do
    Address.create(street: 'Rua A', city: 'Cidade B', state: 'Estado C', zip_code: '12345-678', number: '123',
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
      address_attributes: {
        street: 'Rua A',
        number: '123',
        neighborhood: 'Centro',
        city: 'Cidade B',
        state: 'Estado C',
        zip_code: '12345-678'
      }
    }
  end
  let(:invalid_attributes) { valid_attributes.except(:name) }

  describe 'GET /index' do
    it 'returns a successful response' do
      get proponents_path
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'returns a successful response' do
      proponent = Proponent.create! valid_attributes
      get proponent_path(proponent)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'returns a successful response' do
      get new_proponent_path
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'returns a successful response' do
      proponent = Proponent.create! valid_attributes
      get edit_proponent_path(proponent)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Proponent' do
        expect do
          post proponents_path, params: { proponent: valid_attributes }
        end.to change(Proponent, :count).by(1)
      end

      it 'redirects to the created proponent' do
        post proponents_path, params: { proponent: valid_attributes }
        expect(response).to redirect_to(proponent_url(Proponent.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Proponent' do
        expect do
          post proponents_path, params: { proponent: invalid_attributes }
        end.to change(Proponent, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post proponents_path, params: { proponent: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          name: 'José Silva'
        }
      end

      it 'updates the requested proponent' do
        proponent = Proponent.create! valid_attributes
        patch proponent_path(proponent), params: { proponent: new_attributes }
        proponent.reload
        expect(proponent.name).to eq('José Silva')
      end

      it 'redirects to the proponent' do
        proponent = Proponent.create! valid_attributes
        patch proponent_path(proponent), params: { proponent: new_attributes }
        proponent.reload
        expect(response).to redirect_to(proponent_url(proponent))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested proponent' do
      proponent = Proponent.create! valid_attributes
      expect do
        delete proponent_path(proponent)
      end.to change(Proponent, :count).by(-1)
    end

    it 'redirects to the proponents list' do
      proponent = Proponent.create! valid_attributes
      delete proponent_path(proponent)
      expect(response).to redirect_to(proponents_url)
    end
  end

  describe 'POST /update_salary' do
    it 'queues the job and redirects to the proponents index' do
      proponent = Proponent.create! valid_attributes
      post update_salary_proponent_path(proponent), params: { salary: 2500.0 }
      expect(UpdateSalaryJob).to have_been_enqueued.with(proponent.id, '2500.0')
      expect(response).to redirect_to(proponents_path)
    end
  end
end
