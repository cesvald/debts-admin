class DebtPeriodsController < ApplicationController
  inherit_resources
  belongs_to :monthly_debt, optional: true
  
  def create
    create! { url_for "#{session[:back_url]}#monthly-debt" }
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
    update! { url_for session[:back_url] + "#monthly-debt" }
  end

  def destroy
    destroy! { request.referer + "#monthly-debt" }
  end
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def debt_period_params
      params.require(:debt_period).permit(:started_at, :amount)
    end
end
