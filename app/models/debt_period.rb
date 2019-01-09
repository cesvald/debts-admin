class DebtPeriod < ActiveRecord::Base
  belongs_to :monthly_debt
  
  after_create :set_months
  after_destroy :remove_months
  
  def set_months
    period_before = monthly_debt.debt_periods.where('started_at < ?', started_at).order(started_at: :asc).first
    period_after = monthly_debt.debt_periods.where('started_at > ?', started_at).order(started_at: :desc).first
    
    if not period_before.nil?
      period_before.update_attribute(months: monthly_debt.months_between_dates(self.started_at, period_before.started_at))
    end
    
    self.update_attribute(:months, monthly_debt.months_between_dates(period_after.started_at, self.started_at)) unless period_after.nil?
  
    
  end
  
  def remove_months
    period_before = monthly_debt.debt_periods.where('started_at < ?', started_at).order(started_at: :asc).first
    period_after = monthly_debt.debt_periods.where('started_at > ?', started_at).order(started_at: :desc).first
    if not period_before.nil? and period_after.nil?
      period_after = period_before
    end 
    
    period_before.update_attribute(:months, monthly_debt.months_between_dates(period_after.started_at, period_before.started_at)) unless period_before.nil?
  end
  
  def get_months
    months == 0 ? monthly_debt.months_between_dates(DateTime.now.to_date, self.started_at) + 1 : months
  end
  
  def total_amount
    get_months * amount
  end
end
