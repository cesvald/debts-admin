require 'test_helper'

class ItemHeadquartersControllerTest < ActionController::TestCase
  setup do
    @item_headquarter = item_headquarters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_headquarters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_headquarter" do
    assert_difference('ItemHeadquarter.count') do
      post :create, item_headquarter: { headquarter_id: @item_headquarter.headquarter_id, is_billable: @item_headquarter.is_billable, item_id: @item_headquarter.item_id, registered_at: @item_headquarter.registered_at, value: @item_headquarter.value }
    end

    assert_redirected_to item_headquarter_path(assigns(:item_headquarter))
  end

  test "should show item_headquarter" do
    get :show, id: @item_headquarter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item_headquarter
    assert_response :success
  end

  test "should update item_headquarter" do
    patch :update, id: @item_headquarter, item_headquarter: { headquarter_id: @item_headquarter.headquarter_id, is_billable: @item_headquarter.is_billable, item_id: @item_headquarter.item_id, registered_at: @item_headquarter.registered_at, value: @item_headquarter.value }
    assert_redirected_to item_headquarter_path(assigns(:item_headquarter))
  end

  test "should destroy item_headquarter" do
    assert_difference('ItemHeadquarter.count', -1) do
      delete :destroy, id: @item_headquarter
    end

    assert_redirected_to item_headquarters_path
  end
end
