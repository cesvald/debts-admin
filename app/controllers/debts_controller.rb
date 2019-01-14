class DebtsController < ApplicationController
  inherit_resources
  
  belongs_to :general_debt, :monthly_debt, :agreement_payment, polymorphic: true, optional: true
  
  before_action :set_parent
  
  def create
      create! { url_for session[:back_url] }
  end
  
  def new
    session[:back_url] = request.referer
    new! 
  end
  
  def edit
    session[:back_url] = request.referer
    edit! 
  end
  
  def update
    update! { url_for session[:back_url] }
  end
  
  def destroy
    destroy! { url_for session[:back_url] }
  end
  
  private
    def set_parent
      @parent = parent
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def debt_params
      params.require(:debt).permit(:amount, :balance, :registered_at, :expired_at, :comment, :grace_months, :is_billable, :item_id, :general_debt_id, :monthly_debt_id, :agreement_payment_id, :state)
    end

end
