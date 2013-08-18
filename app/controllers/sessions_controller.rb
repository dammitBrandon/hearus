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
  end


  def destroy
  end
end
