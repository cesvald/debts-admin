class PayPeriod < ActiveRecord::Base
  belongs_to :debt_period
  belongs_to :monthly_debt
  
  after_create :remove_months_debt_period
  before_destroy :add_months_debt_period
  
  scope :between_dates, -> (started_at, finished_at) { where("started_at > :started_at	AND started_at <= :finished_at", {started_at: started_at, finished_at: finished_at} ) }
  scope :paid_after, -> (started_at) { where("started_at > :started_at", {started_at: started_at}) }
  scope :paid_before_eq, -> (started_at) { where("started_at <= :started_at", {started_at: started_at}) }
    
  def finished_at
    started_at + (months - 1).months 
  end
  
  def total_amount
    months * amount
  end
  
  def remove_months_debt_period
    if debt_period.months == 0
      debt_period.update_attributes(started_at: debt_period.started_at + months.months)
    elsif debt_period.months != 0 and  (debt_period.months - months == 0)
      debt_period.destroy
    else
      debt_period.update_attributes(started_at: debt_period.started_at + months.months, months: debt_period.months - months)
    end
  end
  
  def add_months_debt_period
    if debt_period.nil?
      monthly_debt.debt_periods.create(started_at: started_at, months: months, amount: amount)
    else
      debt_period.update_attributes(started_at: debt_period.started_at - months.months, months: debt_period.months + months)
    end
  end
end
