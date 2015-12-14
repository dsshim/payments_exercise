require 'rails_helper'

RSpec.describe Payment, type: :model do
  before(:each) do
    Loan.create(funded_amount: 5000.25)
  end

  describe Payment, "#check_balance" do
    it "verifies outstanding balance is not greater than zero" do
      payment = new_payment(10000.50)
      payment.check_balance

      expect(payment.errors.full_messages.first).to eq("Payment amount must not exceed balance")
    end

    it "verifies outstanding balance is greater than zero" do
      payment = new_payment(1000.50)
      payment.check_balance
      payment.save

      expect(payment.payment_amount).to eq(1000.50)
    end
  end

  describe Payment, "#update_loan" do
    it "updates the loan balance and payment information" do
      payment = new_payment(500.25)
      payment.update_loan
      payment.save

      expect(payment.loan.total_payments).to eq(500.25)
      expect(payment.loan.outstanding_balance).to eq(4500.00)
    end
  end

  private

  def new_payment(payment_amount)
    Payment.new(payment_amount: payment_amount, loan_id: 1)
  end
end
