class UsersController < ApplicationController
  before_filter :matched_user, only: [:edit, :destroy]
  # before_filter :authenticate_user!, only: [:edit, :update]

  def new
    @user = RegularUser.new
  end

  def create
    @user = RegularUser.new(params[:regular_user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render action: 'new'
    end
  end

  def show
    @user = RegularUser.find(current_user.id)
  end

  def index
    @user = RegularUser.find(current_user.id)
  end

  def edit
    @user = RegularUser.find(current_user.id)
  end

  def update
    @user = RegularUser.find(current_user.id)
    if @user.update_attributes(params[:regular_user])
      redirect_to root_path
    else
      render action: 'edit'
    end
  end

  private

    def matched_user
      redirect_to root_url unless current_user && params[:id] == current_user.id
    end

end
