class AddLastAgreementDateToAgreementPayment < ActiveRecord::Migration
  def change
    add_column :agreement_payments, :last_agreement_date, :date
  end
end
