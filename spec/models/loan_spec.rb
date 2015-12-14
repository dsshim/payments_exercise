require 'rails_helper'

RSpec.describe Loan, type: :model do
  before(:each) do
    @loan = Loan.create(funded_amount: 10000.25)
  end

  describe Loan, "#set_outstanding_balance" do
    it "sets_the_oustanding_balance" do
      expect(@loan.outstanding_balance).to eq(10000.25)
    end
  end

  describe Loan, "#check_outstanding_balance" do
    it "checks_the_outstanding_balance_is_greater_than_payment" do
      expect(@loan.check_outstanding_balance(5000)).to eq(false)
    end

    it "checks_the_outstanding_balance_is_less_than_payment" do
      expect(@loan.check_outstanding_balance(50000)).to eq(true)
    end
  end

  describe Loan, "#update_loan_after_payment" do
    it "updates the outstanding loan balance on payment" do
      create_payment(500.25)
      @loan.update_loan_after_payment

      expect(@loan.outstanding_balance).to eq(9500.00)

      create_payment(1000.00)
      @loan.update_loan_after_payment

      expect(@loan.outstanding_balance).to eq(8500.00)
    end

    it "updates the total payments" do
      create_payment(3000.00)

      @loan.update_loan_after_payment

      expect(@loan.total_payments).to eq(3000.00)

      create_payment(1000.25)
      @loan.update_loan_after_payment

      expect(@loan.total_payments).to eq(4000.25)
    end
  end

  private

  def create_payment(amount)
    Payment.create(payment_amount: amount, loan_id: 1)
  end
end
