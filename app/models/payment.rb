class Payment < ActiveRecord::Base
    belongs_to :payable, polymorphic: true
    
    after_create :sum_total_payment
    after_destroy :less_total_payment
    
    def sum_total_payment
      payable.total_payment = payable.total_payment + amount
      payable.save!
    end
    
    def less_total_payment
        payable.total_payment = payable.total_payment - amount
        payable.save!
    end
end
