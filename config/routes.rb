Rails.application.routes.draw do
  resources :events, { format: 'json', except: %i(index) } do
    collection do
      get :entries
      get :own
      get "", action: :search
      get :search
    end
    member do
      put :public
      put :entry
      delete :entry
      put :close
      resources :comments, only: %i(create)
    end
  end
end
