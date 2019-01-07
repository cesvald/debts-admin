class CreateDebtPeriods < ActiveRecord::Migration
  def change
    create_table :debt_periods do |t|
      t.decimal :amount
      t.date :started_at
      t.integer :months
      t.references :monthly_debt, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
