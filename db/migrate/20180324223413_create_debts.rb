class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.decimal :amount
      t.string :comment
      t.boolean :covered, default: false
      t.date :registered_at
      t.integer :debable_id
      t.string :debable_type
      t.references :item, index: true, foreign_key: true
      
      t.timestamps null: false
    end
    add_index :debts, [:debable_type, :debable_id]
  end
end
