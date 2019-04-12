class PartialPayPeriodsController < ApplicationController
  
  inherit_resources
  defaults :resource_class => PayPeriod
  belongs_to :monthly_debt, optional: true
  
  def new
    @period = parent.debt_periods.last
    @period_picker = @period.started_at
    @currency = @period.monthly_debt.user.group.headquarter.currency
    @currency = 'USD' if  @currency.nil?
    @partial_pay_period = PayPeriod.new(started_at: @period.started_at, finished_at: @period.started_at)
    session[:back_url] = request.referer
  end
  
  def create
    @period = parent.debt_periods.last
    @period_picker = @period.started_at
    @currency = @period.monthly_debt.user.group.headquarter.currency
    @currency = 'USD' if  @currency.nil?
    PayPeriod.create!(pay_period_params)
  end
  
  def edit
    @partial_pay_period = resource
    debt_period = DebtPeriod.find_by_started_at(resource.started_at)
    @period_picker = resource.started_at
    if debt_period
      @period = debt_period
      @period.amount += resource.amount 
    else
      @period = resource
    end
    @currency = parent.user.group.headquarter.currency
    @currency = 'USD' if  @currency.nil?
    session[:back_url] = request.referer
  end
  
  def update
    if resource.amount < pay_period_params[:amount].to_f
      debt_period = DebtPeriod.find_by_started_at(resource.started_at)
    end
      
    
    debt_period = DebtPeriod.create(monthly_debt: parent, started_at: resource.started_at)
    redirect_to session[:back_url] + "#monthly-debt"
  end

  def destroy
    destroy! { request.referer + "#monthly-debt" }
  end
  
  private

    def pay_period_params
      params.require(:pay_period).permit(:amount, :started_at, :paid_at, :debt_period_id, :monthly_debt_id, :finished_at, :is_partial, :comment)
    end
end