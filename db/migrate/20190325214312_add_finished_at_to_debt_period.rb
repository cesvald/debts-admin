class AddFinishedAtToDebtPeriod < ActiveRecord::Migration
  def up
    add_column :debt_periods, :finished_at, :date
    DebtPeriod.where.not(months: 0).each do |debt_period|
      debt_period.finished_at = debt_period.started_at + (debt_period.months).months
      debt_period.save!
    end
    change_column :debt_periods, :months, :integer, default: nil
  end
  
  def down
    DebtPeriod.where(months: nil).where(months: 0).each do |debt_period|
      debt_period.months = (debt_period.finished_at.year * 12 + debt_period.finished_at.month) - (debt_period.started_at.year * 12 + debt_period.started_at.month)
      debt_period.save!
    end
    remove_column :debt_periods, :finished_at, :date
  end
end
