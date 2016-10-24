class ApplicationController < ActionController::API

  def current_user
    if @current_user.nil? && request.env["HTTP_X_CONSUMER_CUSTOM_ID"].present?
      @current_user = Cuenta::User.find(request.env["HTTP_X_CONSUMER_CUSTOM_ID"])
    end
    @current_user
  end
end
