class User < Flexirest::Base
  base_url "http://11.11.11.12:4000"

  get :list, "/users/list?user_ids=:id"
end
