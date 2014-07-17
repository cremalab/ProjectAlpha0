json.array!(@task_boards) do |task_board|
  json.extract! task_board, :id
  json.url task_board_url(task_board, format: :json)
end
