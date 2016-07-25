Rails.application.routes.draw do
  resources :events, { format: 'json', except: [:index] } do
    collection do
      get :search
      get "", action: :search
    end
    member do
      put :public
      put :join
      resources :comments, only: [:create]
    end
  end
end
