class DebtPeriodsController < ApplicationController
  inherit_resources
  belongs_to :monthly_debt, optional: true
  
  def create
    create! { url_for "#{session[:back_url]}#monthly-debt" }
  end
  
  def new
    session[:back_url] = request.referer
    pay_period = parent.pay_periods.where(finished_at: DateTime.now.to_date.beginning_of_month()).first
    if pay_period.nil?
      gon.finished_at =  l Date.today.beginning_of_month() + 1.month, format: :js_date
      gon.started_at = nil
    else
      gon.finished_at = nil
      gon.started_at = l Date.today + 1.month, format: :js_date
    end
    
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
      params.require(:debt_period).permit(:started_at, :amount, :finished_at)
    end
end
