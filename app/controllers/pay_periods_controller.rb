class PayPeriodsController < ApplicationController
  
  inherit_resources
  belongs_to :monthly_debt, optional: true
  
  def create
    create! { url_for session[:back_url] + "#monthly-debt" }
  end
  
  def new
    @debt_period = parent.debt_periods.last
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

    def pay_period_params
      params.require(:pay_period).permit(:amount, :started_at, :paid_at, :debt_period_id, :monthly_debt_id, :months, :comment)
    end
end

