class SessionsController < ApplicationController
  include SessionHelper

  def new
    cookies[:redirect_to_after_login] = request.env['HTTP_REFERER']
  end

  def create
    if request.env["omniauth.auth"].present?
      oauth = OAuthUser.new(request.env["omniauth.auth"], current_user)
      create_oauth_user(request.env["omniauth.auth"], current_user)
      oauth.login_or_create
      session[:user_id] = oauth.user.id
      session[:district_id] = oauth.user.district_id
    else
      user = RegularUser.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        session[:district_id] = user.district_id
      else
        @error = "Invalid Login"
        render action: 'new'
      end
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    redirect_to root_url
  end
end
