class PayPeriod < ActiveRecord::Base
  belongs_to :debt_period
  belongs_to :monthly_debt
  
  after_create :remove_months_last_debt_period
  after_update :remove_months_defined_debt_period
  after_destroy :add_months_debt_period
  
  validates :started_at, :finished_at, :amount, presence: true
  validate :valid_dates
  
  scope :between_dates, -> (started_at, finished_at) { where("started_at > :started_at	AND started_at <= :finished_at", {started_at: started_at, finished_at: finished_at} ) }
  scope :paid_after, -> (started_at) { where("started_at > :started_at", {started_at: started_at}) }
  scope :paid_before_eq, -> (started_at) { where("started_at <= :started_at", {started_at: started_at}) }
  scope :along_dates, ->(started_at, finished_at) { where('(started_at >= :started_at AND started_at <= :finished_at) OR (finished_at >= :started_at AND finished_at <= :finished_at) OR (started_at < :started_at AND finished_at > :finished_at)', {started_at: started_at, finished_at: finished_at}) }
  
  def remove_months_last_debt_period
    debt_period = monthly_debt.debt_periods.last
    if is_partial
      if debt_period.months == 1
        debt_period.amount = debt_period.amount - amount
        if debt_period.amount == 0
          debt_period.destroy!
        else
          debt_period.is_partial = true
          debt_period.save!
        end
      else
        debt_period.started_at = debt_period.started_at + (months).months
        debt_period.save!
        if not debt_period.amount - amount == 0
          monthly_debt.debt_periods.create!(started_at: started_at, finished_at: finished_at, amount: debt_period.amount - amount, is_partial: true)
        end
      end
    else  
      if started_at == debt_period.started_at and finished_at == debt_period.current_finished_at
        debt_period.destroy!
      else
        debt_period.started_at = debt_period.started_at + (months).months
        debt_period.save!
      end
    end
  end
  
  def remove_months_defined_debt_period
    if is_partial
      debt_period = DebtPeriod.find_by_started_at(started_at)
      if debt_period
        debt_period.amount -= amount - amount_was
        if debt_period.amount == 0
          debt_period.destroy!
        else
          debt_period.save!
        end
      end
    end
  end
  
  def add_months_debt_period
    if is_partial
      debt_period = monthly_debt.debt_periods.where(started_at: started_at).first
      debt_period =monthly_debt.debt_periods.new(amount: 0, started_at: started_at, finished_at: finished_at) if debt_period.nil?
      debt_period.amount = debt_period.amount + amount
      another_pay_period = monthly_debt.pay_periods.where.not(id: id).where(started_at: started_at).first
      another_pay_period ? debt_period.is_partial = true : debt_period.is_partial = false
      debt_period.save!
    else
      debt_period = monthly_debt.debt_periods.where(started_at: finished_at + 1.month, amount: amount).first
      if debt_period
        debt_period.started_at = debt_period.started_at - (months).months
        debt_period.save!
      else
        monthly_debt.debt_periods.create(started_at: started_at, finished_at: finished_at, amount: amount)
      end
    end
  end
  
  def valid_dates
    if self.started_at && self.finished_at
      if self.finished_at < self.started_at
        errors.add(:invalid_dates, "La fecha final debe ser mayor a la fecha inicial")
      end
    end
  end
  
  def current_finished_at
    finished_at
  end
  
  def all_amount
    if is_partial
      monthly_debt.pay_periods.where(started_at: started_at).sum(:amount)
    else
      amount
    end
  end
  
  def total_amount
    months * amount
  end
  
end

