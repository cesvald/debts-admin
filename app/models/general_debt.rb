class GeneralDebt < ActiveRecord::Base
  belongs_to :user
  has_many :debts, as: :debable
  has_many :payments, as: :payable
  has_many :discounts, as: :discountable
  has_many :agreement_payments, foreign_key: :general_debts_id
  has_many :payments_of_agreements, through: :agreement_payments, source: "payments"
  has_many :debts_of_agreements, through: :agreement_payments, source: "debts"
  
	def opened_agreement?
		agreement_payments.opened.exists?
	end
	
	def total_discount
		agreement_payments.opened.first.nil? ? agreement_payments.completed.sum("amount_debt - amount") : agreement_payments.opened.first.amount_debt + agreement_payments.completed.sum("amount_debt - amount")
	end
	
	def due
		total_debt - total_payment - total_discount
	end
end
