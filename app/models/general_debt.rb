class GeneralDebt < ActiveRecord::Base
  belongs_to :user
  has_many :debts, as: :debable
  has_many :payments, as: :payable
	
	def total_discount
		user.agreement_payments.opened.first.nil? ? user.agreement_payments.completed.sum("amount_debt - amount") : user.agreement_payments.opened.first.amount_debt + user.agreement_payments.completed.sum("amount_debt - amount")
	end
	
	def due
		total_debt - total_payment
	end
	
	def total_due
		due + (user.agreement_payments.opened.first.nil? ? 0 : user.agreement_payments.opened.first.due)	
	end
	
	def new_payments
		agreement_payment = user.agreement_payments.not_canceled.first
		if agreement_payment
			payments.paid_after(agreement_payment.started_at)
		else
			payments
		end
	end
	
	def new_debts
		agreement_payment = user.agreement_payments.not_canceled.first
		if agreement_payment
			debts.registered_after(agreement_payment.started_at)
		else
			debts
		end
	end
end 
	