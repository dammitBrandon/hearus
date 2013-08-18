class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path
    else
      @errors = @user.errors.full_messages
      render "users/new"
    end
  end

  def show
    if current_user?
     @user = current_user
    else
      redirect_to "new"
    end
  end
end
