class UsersController < ApplicationController
  def index
    @user = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(params[:user])
    if @user.valid?
      redirect_to @user
    else
      @user.errors.delete(:password_digest) if @user.errors[:password_digest]
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
