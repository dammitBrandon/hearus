class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:district_id] = user.district.id
      if session[:district_id]
        redirect_to district_path
      else
        redirect_to root_path
      end
    else
      render "new"
    end

    if request.env["omniauth.auth"].present?

      oauth = OAuthUser.new(request.env["omniauth.auth"], current_user)
      oauth.login_or_create
      session[:user_id] = oauth.user.id
      redirect_to root_path

    else
      user = RegularUser.find_by_email(params[:user][:email])
      if user && user.authenticate(params[:user][:password])
        session[:user_id]    = user.id
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
