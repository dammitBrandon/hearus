class SessionsController < ApplicationController
  def new
    cookies[:redirect_to_after_login] = request.env['HTTP_REFERER']
  end

  def create
    if request.env["omniauth.auth"].present?

      oauth = OAuthUser.new(request.env["omniauth.auth"], current_user)
      oauth.login_or_create
      session[:user_id] = oauth.user.id
      session[:district_id] = oauth.user.district_id
      redirect_to cookies[:redirect_to_after_login] || root_path
    else
      user = RegularUser.find_by_email(params[:user][:email])
      if user && user.authenticate(params[:user][:password])
        session[:user_id]    = user.id
        session[:district_id] = user.district.id
        redirect_to cookies[:redirect_to_after_login] || root_path
      else
        @error = "Invalid Login"
        render action: 'new'
      end
    end
  end

  def destroy
    session.clear
    redirect_to root_url
  end
end
