class Payment < ActiveRecord::Base
    belongs_to :payable, polymorphic: true
    belongs_to :headquarter
    
    after_create :sum_total_payment
    after_destroy :less_total_payment
    
    scope :between_dates, -> (started_at, finished_at) { where("paid_at > :started_at	AND paid_at <= :finished_at", {started_at: started_at, finished_at: finished_at} ) }
    scope :paid_after, -> (started_at) { where("paid_at > :started_at", {started_at: started_at}) }
    scope :paid_before_eq, -> (started_at) { where("paid_at <= :started_at", {started_at: started_at}) }
    
    def sum_total_payment
      payable.total_payment = payable.total_payment + amount
      payable.save!
    end
    
    def less_total_payment
        payable.total_payment = payable.total_payment - amount
        payable.save!
    end
end
