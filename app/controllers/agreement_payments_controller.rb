class AgreementPaymentsController < ApplicationController
  inherit_resources
  belongs_to :user
  before_action :set_parent
  skip_before_action :set_parent, only: [:close, :cancel]
  
  def create
    create! do |success, failure|
      success.html {
        redirect_to url_for session[:back_url]
      }
    end
  end
  
  def new
    session[:back_url] = "#{request.referer}#{params[:tab] if params[:tab]}"
    new!
  end
  
  def edit
    session[:back_url] = "#{request.referer}#{params[:tab] if params[:tab]}"
    edit!
  end
  
  def update
    update! { url_for session[:back_url] }
  end

  def destroy
    if resource.payments.any?
      flash[:failure] = 'No se puede eliminar porque hay pagos realizados a este acuerdo de pago. Elimine los pagos y vuelva a intentarlo'
      redirect_to request.referer + params["tab"]
    else
      destroy! { request.referer + params["tab"]}
    end
  end
  
  def close
    agreement_payment = AgreementPayment.find(params[:id])
    if agreement_payment.may_close?
      agreement_payment.close!
    else
      flash[:failure] = 'No se puede cerrar el acuerdo de pago porque no ha pagado toda la deuda'
    end
    redirect_to request.referer
  end
  
  def cancel
    agreement_payment = AgreementPayment.find(params[:id])
    if agreement_payment.may_cancel?
      agreement_payment.cancel!
    else
      flash.now[:failure] = 'No se puede eliminar porque hay pagos realizados a este acuerdo de pago. Elimine los pagos y vuelva a intentarlo'
    end
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
