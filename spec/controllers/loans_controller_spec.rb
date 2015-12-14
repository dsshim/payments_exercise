require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  describe 'GET #index' do
    it 'responds with a 200' do
      get :index

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    it 'responds with a 200' do
      get :show, id: loan.id

      expect(response).to have_http_status(:ok)
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        get :show, id: 10000

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    it 'creates a new loan' do
      loan_params = {funded_amount: 2000.50}

      expect { post :create, loan: loan_params, format: :json }
        .to change(Loan, :count).by(1)
      expect(response).to have_http_status(:ok)
    end

    it 'does not create a new loan with a negative balance' do
      loan_params = {funded_amount: -20000.50}

      expect { post :create, loan: loan_params, format: :json }
        .to change(Loan, :count).by(0)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
