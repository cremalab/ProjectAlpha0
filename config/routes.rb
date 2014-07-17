Rails.application.routes.draw do
  resources :daily_stage_values

  resources :tasks

  resources :task_boards do
    resources :daily_stage_values
    resources :tasks
  end

end
