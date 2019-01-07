class AgreementPaymentsController < ApplicationController
  inherit_resources
  belongs_to :general_debt, :monthly_debt, polymorphic: true
  
  before_action :set_parent
  skip_before_action :set_parent, only: [:close, :cancel]
  
  def create
    create! do |success, failure|
      success.html {
        redirect_to debts_user_path(@parent.user)
      }
    end
  end
  
  def update
    update! { debts_user_path(@parent.user) }
  end
  
  def destroy
    destroy! { debts_user_path(@parent.user) }
  end
  
  def close
    AgreementPayment.find(params[:id]).close!
    redirect_to request.referer
  end
  
  def cancel
    AgreementPayment.find(params[:id]).cancel!
    redirect_to request.referer
  end
  
  private
  
    def set_parent
      @parent = parent
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def agreement_payment_params
      params.require(:agreement_payment).permit(:started_at, :number_quotas, :canceled, :amount_debt, :comment, :expired_at, :amount, :general_debt_id, :monthly_debt_id, :headquarter_id,  quotas_attributes: [:id, :expected_at, :amount, :_destroy])
    end
  
end
