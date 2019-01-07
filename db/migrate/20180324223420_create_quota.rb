class CreateQuota < ActiveRecord::Migration
  def change
    create_table :quota do |t|
      t.references :agreement_payment, index: true, foreign_key: true
      t.decimal :amount
      t.date :expected_at
      t.timestamps null: false
    end
  end
end
