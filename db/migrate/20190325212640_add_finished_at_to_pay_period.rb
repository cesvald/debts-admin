class AddFinishedAtToPayPeriod < ActiveRecord::Migration
  def up
    add_column :pay_periods, :finished_at, :date
    PayPeriod.where.not(months: 0).each do |pay_period|
      pay_period.finished_at = pay_period.started_at + (pay_period.months).months
      pay_period.save!
    end
  end
  
  def down
    PayPeriod.where(months: nil).where.not(months: 0).each do |pay_period|
      pay_period.months = (pay_period.finished_at.year * 12 + pay_period.finished_at.month) - (pay_period.started_at.year * 12 + pay_period.started_at.month)
      pay_period.save!
    end
    remove_column :pay_periods, :finished_at, :date
  end
end
