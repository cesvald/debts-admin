class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.date :paid_at
      t.decimal :amount
      t.string :method
      t.string :comment
      t.integer :payable_id
      t.string :payable_type
      t.references :headquarter, index: true, foreign_key: true
      
      t.timestamps null: false
    end
    add_index :payments, [:payable_type, :payable_id]
  end
end
