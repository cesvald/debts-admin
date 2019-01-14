class AgreementPayment < ActiveRecord::Base
	include AASM
	
	has_many :quotas, dependent: :destroy
	has_many :payments, as: :payable
	belongs_to :headquarter
	belongs_to :user
	
	scope :not_canceled, -> {where.not(state: 2)}
	
	before_destroy :rollback
	before_create :set_last_agreement_date
	after_create :reset_general_debt, :new_debt_period
	
	accepts_nested_attributes_for :quotas, :allow_destroy => true
	
	enum state: {
		opened: 0,
		completed: 1,
		canceled: 2
	}
	
	aasm :column => :state, :enum => true do
		state :opened, :initial => true
		state :completed, :canceled
		
		event :close, guard: :total_payments? do
			transitions :from => :opened, :to => :completed
		end
		
		event :cancel, after: :rollback, guard: :payments_empty? do
			transitions :from => :opened, :to => :canceled
		end
	end
	
	def payments_empty?
		payments.empty?	
	end
	
	def total_payments?
		amount - total_payment <= 0
	end
	
	def due
			amount - total_payment
	end
	
	def discount
		amount_debt - amount
	end
	
	def total_quotas
			quotas.count
	end
	
	def payments_related
		if last_agreement_date
			user.general_debt.payments.between_dates(last_agreement_date, started_at)
		else
			user.general_debt.payments.paid_before_eq(started_at)
		end
	end
	
	def debts_related
		if last_agreement_date
			user.general_debt.debts.between_dates(last_agreement_date, started_at)
		else
			user.general_debt.debts.registered_before_eq(started_at)
		end
	end
	
	def pay_periods_related
		if last_agreement_date
			user.monthly_debt.pay_periods.between_dates(last_agreement_date, started_at)
		else
			user.monthly_debt.pay_periods.paid_before_eq(started_at)
		end
	end
	
	def debt_periods_related
		if last_agreement_date
			user.monthly_debt.debt_periods.between_dates(last_agreement_date, started_at)
		else
			user.monthly_debt.debt_periods.started_before_eq(started_at)
		end
	end

	def payments_related_total
		payments_related.sum(:amount)
	end
	
	def debts_related_total
		debts_related.sum(:amount)
	end
	
	def due_general_debts_related_total
		debts_related_total - payments_related_total
	end
	
	def due_related_total
		due_general_debts_related_total + due_monthly_debt_related_total
	end
	
	def debt_periods_related_total
		debt_periods_related.sum("amount * months")
	end
	
	def pay_periods_related_total
		pay_periods_related.sum("amount * months")
	end
	
	def total_months_amount_related
		debt_periods_related_total + pay_periods_related_total
	end
	
	def due_monthly_debt_related_total
		debt_periods_related_total
	end
	
	def expired?
		DateTime.now.to_date > expired_at
	end
	
	def set_last_agreement_date
		last_agreement = user.agreement_payments.not_canceled.first
		self.update_attribute :last_agreement_date, last_agreement.started_at if last_agreement
	end
	
	def rollback
		user.general_debt.update_attributes(:total_debt => user.general_debt.total_debt + debts_related_total, :total_payment => user.general_debt.total_payment + payments_related_total)
	end
	
	def reset_general_debt
		user.general_debt.update_attributes(total_debt: 0, total_payment: 0)
	end
	
	def new_debt_period
		user.monthly_debt.debt_periods.create(started_at: started_at + 1.month, amount: user.monthly_debt.debt_periods.first.amount)
	end
end