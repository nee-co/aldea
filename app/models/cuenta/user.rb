module Cuenta
  class UserProxy < Flexirest::ProxyBase
    get "/internal/users/list" do
      get_params[:user_ids] = Array.wrap(get_params[:user_ids]).join(' ')
      passthrough
    end
  end

  class User < Flexirest::Base
    include User::ApiClient

    proxy UserProxy

    get :list, "/internal/users/list", params_encoder: :flat
  end
end
