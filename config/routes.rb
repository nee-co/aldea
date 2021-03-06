Rails.application.routes.draw do
  resources :events, { format: 'json', except: %i(index) } do
    collection do
      get :entries, controller: :tray
      get :own, controller: :tray
      get :search
    end
    member do
      put :public
      put :private
      put :entry
      delete :entry, action: :leave
      resources :comments, only: %i(create)
    end
  end
end
