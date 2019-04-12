class MonthlyDebt < ActiveRecord::Base
    belongs_to :user
    has_many :debt_periods, -> {order(started_at: :desc)}
    has_many :pay_periods, -> {order(started_at: :desc)}
    
    def partial_pay_periods
        pay_periods.where(is_partial: true)
    end
    
    def opened_agreement?
		agreement_payments.opened.exists?
	end
	
    def months_between_dates date1, date2
        (date1.year * 12 + date1.month) - (date2.year * 12 + date2.month)
    end
    
    def current_period
        debt_periods.where(finished_at: nil).first
    end
    
    def partial_opened?
    	pay_period = pay_periods.where(partial: true, completed: false)
    	pay_period.nil?
    end 
    
    def total_debt
        new_debt_periods.any? ? new_debt_periods.where.not(finished_at: nil).sum("((DATE_PART('year', finished_at) - DATE_PART('year', started_at)) * 12 + (DATE_PART('month', finished_at) - DATE_PART('month', started_at)) + 1) * amount") + (current_period.nil? ? 0 : current_period.total_amount) : 0
    end
    
    def total_payment
        new_pay_periods.any? ? new_pay_periods.sum("((DATE_PART('year', finished_at) - DATE_PART('year', started_at)) * 12 + (DATE_PART('month', finished_at) - DATE_PART('month', started_at)) + 1) * amount") : 0
    end
    
    def total_months_amount
        total_debt + total_payment
    end
	
	def due
	    total_debt - (deposit.nil? ? 0 : deposit)
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
