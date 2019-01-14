class CreatePayPeriods < ActiveRecord::Migration
  def change
    create_table :pay_periods do |t|
      t.decimal :amount
      t.date :started_at
      t.date :paid_at
      t.references :debt_period, index: true, foreign_key: true
      t.references :monthly_debt, index: true, foreign_key: true
      t.integer :months

      t.timestamps null: false
    end
  end
end
