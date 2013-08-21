class SessionsController < ApplicationController
  include SessionHelper

  def new
    cookies[:redirect_to_after_login] = request.env['HTTP_REFERER']
  end

  def create
    if request.env["omniauth.auth"].present?
      create_oauth_user(request.env["omniauth.auth"], current_user)
    else
      create_regular_user(params[:user][:email])
    end
  end

  def destroy
    session.clear
    redirect_to root_url
  end
end
