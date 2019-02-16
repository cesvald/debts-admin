class CreateBalances < ActiveRecord::Migration
  def change
    create_table :balances do |t|
      t.references :user, index: true, foreign_key: true
      t.references :headquarter, index: true, foreign_key: true
      t.integer :debt_type
      t.decimal :debt
      t.decimal :payment
      t.decimal :due
      t.date :generated_at

      t.timestamps null: false
    end
  end
end
