class AddUserToAgreementPayment < ActiveRecord::Migration
  def change
    add_reference :agreement_payments, :user, index: true, foreign_key: true
  end
end
