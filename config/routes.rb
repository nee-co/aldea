Rails.application.routes.draw do
  resources :events, { format: 'json' } do
    collection do
      get :search
    end
    member do
      put :public
      put :join
      post :comment
    end
  end
end
