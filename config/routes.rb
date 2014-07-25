Rails.application.routes.draw do
  get 'group_bar_dsg/index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :daily_stage_values

  resources :tasks

  resources :task_boards do
    resources :daily_stage_values
    resources :tasks
  end

end
