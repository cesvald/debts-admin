class CreateMonthlyDebts < ActiveRecord::Migration
  def change
    create_table :monthly_debts do |t|
      t.decimal :total_payment
      t.decimal :deposit, default: 0
      t.belongs_to :user, index: true, foreign_key: true
    
      t.timestamps null: false
    end
  end
end
