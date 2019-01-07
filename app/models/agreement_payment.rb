class AgreementPayment < ActiveRecord::Base
	include AASM
	
	has_many :quotas, dependent: :destroy
	has_many :debts, as: :debable
	has_many :payments, as: :payable
	belongs_to :headquarter
	belongs_to :general_debt, :foreign_key => "general_debts_id"
	belongs_to :monthly_debt
	
	scope :state, -> (state) { where(state: state) }
	
	accepts_nested_attributes_for :quotas, :allow_destroy => true
	
	enum state: {
		opened: 0,
		completed: 1,
		canceled: 2
	}
	
	aasm :column => :state, :enum => true do
		state :opened, :initial => true
		state :completed, :canceled
		
		event :close do
			after do
				general_debt.payments.create(paid_at: DateTime.now.to_date, amount: self.amount, method: "Acuerdo de Pago") unless general_debt.nil?
				monthly_debt.payments.create(paid_at: DateTime.now.to_date, amount: self.amount, method: "Acuerdo de Pago") unless monthly_debt.nil?
			end
			transitions :from => :opened, :to => :completed
		end
		
		event :cancel do
			transitions :from => :opened, :to => :canceled 
		end
	end
	
	def due
			amount - total_payment
	end
	
	def total_quotas
			quotas.count
	end
	
	def expired?
		DateTime.now.to_date > expired_at
	end
	
end