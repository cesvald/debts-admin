class AddIsPartialToPayPeriod < ActiveRecord::Migration
  def change
    add_column :pay_periods, :is_partial, :boolean, default: false
  end
end
