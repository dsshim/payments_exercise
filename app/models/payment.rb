class Payment < ActiveRecord::Base
  belongs_to    :loan
  validate      :check_balance
  after_create  :update_loan

  def check_balance
    find_loan.check_outstanding_balance(payment_amount) ?
      errors.add(:payment_amount, "must not exceed balance") : false
  end

  def update_loan
    find_loan.update_loan_after_payment
  end

  private

  def find_loan
    Loan.find(loan_id)
  end
end
