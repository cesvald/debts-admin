class CreateGeneralDebts < ActiveRecord::Migration
  def change
    create_table :general_debts do |t|
      t.decimal :total_debt, default: 0
      t.decimal :total_payment, default: 0
      t.decimal :deposit, default: 0
      t.belongs_to :user, index: true, foreign_key: true
      
      t.timestamps null: false
    end
  end
end