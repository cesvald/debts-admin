class RemoveGeneralDebtAndMonthlyDebtFromAgreementPayment < ActiveRecord::Migration
  def change
    remove_reference :agreement_payments, :general_debts
    remove_reference :agreement_payments, :monthly_debts
  end
end
