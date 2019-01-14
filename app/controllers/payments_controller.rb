class PaymentsController < ApplicationController
  inherit_resources
  belongs_to :general_debt, :monthly_debt, :agreement_payment, polymorphic: true, optional: true
  
  before_action :set_parent
  skip_before_action :set_parent, only: :destroy
  
  def create
    create! { url_for session[:back_url] }
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
    destroy! { request.referer + params["tab"]}
  end
  
  private

    def set_parent
      @payable = parent
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:amount, :balance, :paid_at, :method, :comment, :payable_type, :payable_id, :agreement_payment_id, :headquarter_id)
    end
end
