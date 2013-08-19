class UsersController < ApplicationController
  before_filter :matched_user, only: [:edit, :destroy]
  before_filter :find_user, :except => [:new, :create]

  def new
    @user = RegularUser.new
  end

  def create
    @user = RegularUser.new(params[:regular_user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @errors = @user.errors.full_messages
      render "users/new"
    end
  end

  def show
    @user
  end

  def index
    @user
  end

  def edit
    @user
  end

  def update
    if @user.update_attributes(params[:regular_user])
      redirect_to root_path
    else
      render action: 'edit'
    end
  end

  private

  def find_user
    @user = RegularUser.find(current_user.id)
  end

  def matched_user
    redirect_to root_url unless current_user && params[:id] == current_user.id
  end

end
