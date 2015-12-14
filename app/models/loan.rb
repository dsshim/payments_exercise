class Loan < ActiveRecord::Base
  has_many      :payments
  validates     :funded_amount, numericality: { greater_than: 0 }
  after_create  :set_outstanding_balance

  def set_outstanding_balance
    update(outstanding_balance: funded_amount)
  end

  def check_outstanding_balance(payment_amount)
    outstanding_balance - payment_amount < 0 ? true : false
  end

  def update_loan_after_payment
    update(outstanding_balance: funded_amount - sum_payments,
                total_payments: sum_payments)
  end

  private

  def sum_payments
    payments.sum(:payment_amount)
  end
end
