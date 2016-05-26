Rails.application.routes.draw do
  resources :events, { format: 'json' }
end
