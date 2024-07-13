Rails.application.routes.draw do
  resources :proponents do
    collection do
      get :calculate_inss
      get :report
      get :salary_report
    end
  end
end
