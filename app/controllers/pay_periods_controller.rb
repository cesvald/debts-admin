class PayPeriodsController < ApplicationController
  
  inherit_resources
  belongs_to :monthly_debt, optional: true
  
  def create
    @debt_period = parent.debt_periods.last
    @debt_period_picker = @debt_period.started_at
    @currency = @debt_period.monthly_debt.user.group.headquarter.currency
    @currency = 'USD' if  @currency.nil?
    create! { url_for session[:back_url] + "#monthly-debt" }
  end
  
  def new
    @period = parent.debt_periods.last
    @period_picker = @period.started_at
    @currency = parent.user.group.headquarter.currency
    @currency = 'USD' if  @currency.nil?
    session[:back_url] = request.referer
    new!
  end
  
  def edit
    @period = resource
    @period_picker = resource.started_at
    @currency = resource.monthly_debt.user.group.headquarter.currency
    @currency = 'USD' if  @currency.nil?
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
      params.require(:pay_period).permit(:amount, :started_at, :paid_at, :debt_period_id, :monthly_debt_id, :finished_at, :comment, :is_partial)
    end
end

