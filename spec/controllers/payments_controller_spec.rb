require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do

  before(:each) do
    @loan = Loan.create!(funded_amount: 10000.50)
  end

  describe 'GET #index' do
    it 'responds with a 200' do

      get :index, loan_id: @loan.id
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    it 'creates payment with amount less than outstanding balance' do
      payment_params = {payment_amount: 2000.50, loan_id: @loan.id}

      expect { post :create, payment: payment_params, format: :json }
        .to change(Payment, :count).by(1)
      expect(response).to have_http_status(:ok)
    end

    it 'does not create payment with amount greater than outstanding balance' do
      payment_params = {payment_amount: 20000.50, loan_id: @loan.id}

      expect { post :create, payment: payment_params, format: :json }
        .to change(Payment, :count).by(0)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET #show' do
    let(:payment) { Payment.create!(payment_amount: 1000.0, loan_id: @loan.id) }

    it 'responds with a 200' do
      get :show, id: payment.id
      expect(response).to have_http_status(:ok)
    end

    context 'if the payment is not found' do
      it 'responds with a 404' do
        get :show, id: 000
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
