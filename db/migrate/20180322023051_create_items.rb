class CreateItems < ActiveRecord::Migration
  def change
    drop_table :items
    create_table :items do |t|
      t.string :name
      t.references :headquarter, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
