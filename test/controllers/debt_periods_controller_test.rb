require 'test_helper'

class DebtPeriodsControllerTest < ActionController::TestCase
  setup do
    @debt_period = debt_periods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:debt_periods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create debt_period" do
    assert_difference('DebtPeriod.count') do
      post :create, debt_period: { amount: @debt_period.amount, monthly_debt_id: @debt_period.monthly_debt_id, months: @debt_period.months, started_at: @debt_period.started_at }
    end

    assert_redirected_to debt_period_path(assigns(:debt_period))
  end

  test "should show debt_period" do
    get :show, id: @debt_period
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @debt_period
    assert_response :success
  end

  test "should update debt_period" do
    patch :update, id: @debt_period, debt_period: { amount: @debt_period.amount, monthly_debt_id: @debt_period.monthly_debt_id, months: @debt_period.months, started_at: @debt_period.started_at }
    assert_redirected_to debt_period_path(assigns(:debt_period))
  end

  test "should destroy debt_period" do
    assert_difference('DebtPeriod.count', -1) do
      delete :destroy, id: @debt_period
    end

    assert_redirected_to debt_periods_path
  end
end
