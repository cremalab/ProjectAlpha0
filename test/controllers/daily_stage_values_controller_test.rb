require 'test_helper'

class DailyStageValuesControllerTest < ActionController::TestCase
  setup do
    @daily_stage_value = daily_stage_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:daily_stage_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create daily_stage_value" do
    assert_difference('DailyStageValue.count') do
      post :create, daily_stage_value: {  }
    end

    assert_redirected_to daily_stage_value_path(assigns(:daily_stage_value))
  end

  test "should show daily_stage_value" do
    get :show, id: @daily_stage_value
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @daily_stage_value
    assert_response :success
  end

  test "should update daily_stage_value" do
    patch :update, id: @daily_stage_value, daily_stage_value: {  }
    assert_redirected_to daily_stage_value_path(assigns(:daily_stage_value))
  end

  test "should destroy daily_stage_value" do
    assert_difference('DailyStageValue.count', -1) do
      delete :destroy, id: @daily_stage_value
    end

    assert_redirected_to daily_stage_values_path
  end
end
