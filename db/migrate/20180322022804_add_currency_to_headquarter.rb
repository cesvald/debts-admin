class AddCurrencyToHeadquarter < ActiveRecord::Migration
  def change
    add_column :headquarters, :currency, :string, limit: 3
  end
end
