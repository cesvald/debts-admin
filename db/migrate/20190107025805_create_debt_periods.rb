class CreateDebtPeriods < ActiveRecord::Migration
  def change
    create_table :debt_periods do |t|
      t.decimal :amount, default: 0
      t.date :started_at
      t.references :monthly_debt, index: true, foreign_key: true
      t.integer :months, default: 0

      t.timestamps null: false
    end
  end
end
