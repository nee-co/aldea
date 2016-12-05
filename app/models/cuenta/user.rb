module Cuenta
  class UserProxy < Flexirest::ProxyBase
    get '/internal/users/list' do
      get_params[:user_ids] = Array.wrap(get_params[:user_ids]).join(' ')
      passthrough
    end
  end

  class User < Flexirest::Base
    include Cuenta::ApiClient

    proxy UserProxy

    get :find, '/internal/users/:id'
    get :list, '/internal/users/list', params_encoder: :flat

    def entry_events
      Event.entries_by_user(id)
    end

    def owned_events
      Event.where(owner_id: id)
    end
  end
end
