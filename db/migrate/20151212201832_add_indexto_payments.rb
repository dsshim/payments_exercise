class AddIndextoPayments < ActiveRecord::Migration
  def change
    add_index  :payments, :loan_id
  end
end
