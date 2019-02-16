class Balance < ActiveRecord::Base
  belongs_to :user
  belongs_to :headquarter
  
  enum debt_type: [ :general_debt, :monthly_debt, :agreement_payment ]
  
  def monthly_balance
    User.all.each do |user|
      user.group.headquarter
      
      user.general_debt.total_debt_main_headquarter
      user.general_debt.total_debt_current_headquarter
      user.general_debt.total_payment_main_headquarter
      user.general_debt.total_due_main_headquarter
      Balance.create()
      
      #user.general_debt.debts.by_headquarter_id()
      
    end
  end
end
