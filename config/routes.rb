Rails.application.routes.draw do
  resources :proponents do
    collection do
      get :calculate_inss
    end
  end
end
