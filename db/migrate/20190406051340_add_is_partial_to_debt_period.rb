class AddIsPartialToDebtPeriod < ActiveRecord::Migration
  def change
    add_column :debt_periods, :is_partial, :boolean, default: false
  end
end
