class CreateAgreementPayments < ActiveRecord::Migration
  def change
    create_table :agreement_payments do |t|
      t.integer :state, default: 0
      t.string :comment
      t.decimal :amount
      t.date :started_at
      t.date :expired_at
      t.decimal :amount_debt
      t.decimal :total_debt, default: 0
      t.decimal :total_payment, default: 0
      t.references :headquarter, index: true, foreign_key: true
      t.belongs_to :general_debts
      t.belongs_to :monthly_debts
      
      t.timestamps null: false
    end
  end
end
