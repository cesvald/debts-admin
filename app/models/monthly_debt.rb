class MonthlyDebt < ActiveRecord::Base
    belongs_to :user
    has_many :agreement_payments
    has_many :debt_periods
    
    
    def months_between_dates date1, date2
        (date1.year * 12 + date1.month) - (date2.year * 12 + date2.month)
    end
end
