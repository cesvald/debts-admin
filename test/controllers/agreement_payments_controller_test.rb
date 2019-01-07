require 'test_helper'

class AgreementPaymentsControllerTest < ActionController::TestCase
  setup do
    @agreement_payment = agreement_payments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:agreement_payments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create agreement_payment" do
    assert_difference('AgreementPayment.count') do
      post :create, agreement_payment: { canceled: @agreement_payment.canceled, comment: @agreement_payment.comment, expired_at: @agreement_payment.expired_at, number_quotas: @agreement_payment.number_quotas, started_at: @agreement_payment.started_at, value: @agreement_payment.value, value_debt: @agreement_payment.value_debt }
    end

    assert_redirected_to agreement_payment_path(assigns(:agreement_payment))
  end

  test "should show agreement_payment" do
    get :show, id: @agreement_payment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @agreement_payment
    assert_response :success
  end

  test "should update agreement_payment" do
    patch :update, id: @agreement_payment, agreement_payment: { canceled: @agreement_payment.canceled, comment: @agreement_payment.comment, expired_at: @agreement_payment.expired_at, number_quotas: @agreement_payment.number_quotas, started_at: @agreement_payment.started_at, value: @agreement_payment.value, value_debt: @agreement_payment.value_debt }
    assert_redirected_to agreement_payment_path(assigns(:agreement_payment))
  end

  test "should destroy agreement_payment" do
    assert_difference('AgreementPayment.count', -1) do
      delete :destroy, id: @agreement_payment
    end

    assert_redirected_to agreement_payments_path
  end
end
