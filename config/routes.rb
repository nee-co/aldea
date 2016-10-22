Rails.application.routes.draw do
  resources :events, { format: 'json', except: %i(index) } do
    collection do
      get :search
      get "", action: :search
    end
    member do
      put :public
      put :join
      resources :comments, only: %i(create)
    end
  end
end
