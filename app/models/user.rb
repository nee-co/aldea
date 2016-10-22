class User < Flexirest::Base
  base_url Settings.cuenta_url

  get :list, "/users/list?user_ids=:id"
end
