class SessionsController < ApplicationController
  def new
  end

  def create
    if request.env["omniauth.auth"].present?

      oauth = OAuthUser.new(request.env["omniauth.auth"], current_user)
      oauth.login_or_create
      session[:user_id] = oauth.user.id
      redirect_to root_path

    else
      user = RegularUser.find_by_email(params[:user][:email])
      if user && user.authenticate(params[:user][:password])
        session[:user_id]    = user.id
        session[:district_id] = user.district.id
        redirect_to district_path if session[:district_id]
        redirect_to root_path
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
