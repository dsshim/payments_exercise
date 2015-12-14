class AddTotalPaymentsAndOutstandingBalanceToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :total_payments, :decimal, default: 0
    add_column :loans, :outstanding_balance, :decimal, default: 0
  end
end
