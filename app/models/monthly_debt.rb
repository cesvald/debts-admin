class MonthlyDebt < ActiveRecord::Base
    belongs_to :user
    has_many :agreement_payments, :foreign_key => "monthly_debts_id"
    has_many :debt_periods
    has_many :payments, as: :payable
    
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
        debt_periods.any? ? debt_periods.where.not(months: 0).sum("amount * months") + current_period.total_amount : 0
    end
    
    def total_discount
		agreement_payments.opened.first.nil? ? agreement_payments.completed.sum("amount_debt - amount") : agreement_payments.opened.first.amount_debt + agreement_payments.completed.sum("amount_debt - amount")
	end
	
	def due
	    total_debt - total_payment - total_discount
	end
end
