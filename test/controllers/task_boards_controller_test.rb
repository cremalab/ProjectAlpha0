require 'test_helper'

class TaskBoardsControllerTest < ActionController::TestCase
  setup do
    @task_board = task_boards(:generic_board)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:task_boards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create task_board" do
    post :create, task_board: { active: true }

    assert_redirected_to task_board_path(assigns(:task_board))
  end

  test "should show task_board" do
    get :show, id: @task_board
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @task_board
    assert_response :success
  end

  test "should update task_board" do
    patch :update, id: @task_board, task_board: { active: true }
    assert_redirected_to task_board_path(assigns(:task_board))
  end

  test "should destroy task_board" do
    assert_difference('TaskBoard.count', -1) do
      delete :destroy, id: @task_board
    end

    assert_redirected_to task_boards_path
  end
end
