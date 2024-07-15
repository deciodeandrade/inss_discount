require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :proponents do
    collection do
      get :calculate_inss
      get :report
      get :salary_report
    end

    member do
      post :update_salary
    end
  end
end
