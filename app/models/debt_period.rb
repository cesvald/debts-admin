class DebtPeriod < ActiveRecord::Base
  belongs_to :monthly_debt
  has_many :pay_periods, dependent: :nullify
  
  before_create :set_first_day_of_month
  
  validates :started_at, :amount, presence: true
  validate :valid_dates
  validate :available
  
  scope :between_dates, -> (started_at, finished_at) { where("started_at > :started_at	AND started_at <= :finished_at", {started_at: started_at, finished_at: finished_at} ) }
  scope :started_after, -> (started_at) { where("started_at > :started_at", {started_at: started_at}) }
  scope :started_before_eq, -> (started_at) { where("started_at <= :started_at", {started_at: started_at}) }
  scope :along_dates, ->(started_at, finished_at) { where('(started_at >= :started_at AND started_at <= :finished_at) OR (finished_at >= :started_at AND finished_at <= :finished_at) OR (started_at < :started_at AND finished_at > :finished_at)', {started_at: started_at, finished_at: finished_at}) }
  
  
  def set_first_day_of_month
    self.started_at = self.started_at.beginning_of_month
    self.finished_at =  self.finished_at.beginning_of_month
    self.finished_at = nil if self.finished_at == DateTime.now.to_date.beginning_of_month
  end
  
  def months
    (current_finished_at.year * 12 + current_finished_at.month) - (started_at.year * 12 + started_at.month) + 1
  end
  
  def total_amount
    months * amount
  end
  
  def available
    if not is_partial
  		debt_period = monthly_debt.debt_periods.where.not(id: id).along_dates(started_at, finished_at).first
  		if debt_period
  		  errors.add(:debt_period_exists, "El período se cruza con un periodo de deuda ya existente: #{I18n.l(debt_period.started_at, format: :month_year).camelize} hasta  #{I18n.l(debt_period.current_finished_at, format: :month_year).camelize}")
  		else
  		  pay_period = monthly_debt.pay_periods.along_dates(started_at, finished_at).first
  		  if pay_period
  		    errors.add(:pay_period_exists, "El período se cruza con un periodo de pago ya existente: #{I18n.l(pay_period.started_at, format: :month_year).camelize} hasta  #{I18n.l(pay_period.finished_at, format: :month_year).camelize}")
  		  end
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
    finished_at.nil? ? DateTime.now.to_date.beginning_of_month : finished_at
  end
  
  def current?
    finished_at.nil?
  end
  
  def months_to_s
    if finished_at.nil?
      "#{I18n.l DateTime.now.beginning_of_month, format: :month_year}"
    elsif started_at == finished_at
      "desde #{I18n.l(started_at, format: :month_year).camelize} hasta #{@debt_period.finished_at.nil? ? nil : I18n.l(@debt_period.finished_at, format: :month_year).camelize}"
    else
      "#{I18n.l(started_at, format: :month_year).camelize}"
    end
  end
end
