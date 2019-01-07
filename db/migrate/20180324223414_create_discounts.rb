class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.decimal :amount
      t.string :comment
      t.date :registered_at
      t.integer :discountable_id
      t.string :discountable_type
      t.references :headquarter, index: true, foreign_key: true
      
      t.timestamps null: false
    end
    add_index :discounts, [:discountable_type, :discountable_id]
  end
end
