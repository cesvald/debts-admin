class MonthlyDebt < ActiveRecord::Base
    belongs_to :user
    has_many :debt_periods, -> {order(started_at: :desc)}
    has_many :pay_periods, -> {order(started_at: :desc)}
    
    def opened_agreement?
		agreement_payments.opened.exists?
	end
	
    def months_between_dates date1, date2
        (date1.year * 12 + date1.month) - (date2.year * 12 + date2.month)
    end
    
    def current_period
        debt_periods.where(months: 0).first
    end
     
    def total_debt
        new_debt_periods.any? ? new_debt_periods.where.not(months: 0).sum("amount * months") + current_period.total_amount : 0
    end
    
    def total_payment
        new_pay_periods.any? ? new_pay_periods.sum("amount * months") : 0
    end
    
    def total_months_amount
        total_debt + total_payment
    end
	
	def due
	    total_debt
	end
	
	def new_pay_periods
		agreement_payment = user.agreement_payments.not_canceled.first
		if agreement_payment
			pay_periods.paid_after(agreement_payment.started_at)
		else
			pay_periods
		end
	end
	
	def new_debt_periods
		agreement_payment = user.agreement_payments.not_canceled.first
		if agreement_payment
			debt_periods.started_after(agreement_payment.started_at)
		else
			debt_periods
		end
	end
	
end
