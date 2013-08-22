class UsersController < ApplicationController
  include SessionHelper

  before_filter :matched_user, only: [:edit, :destroy]
  before_filter :find_user, :except => [:new, :create]

  def new
    cookies[:redirect_to_after_login] = request.env['HTTP_REFERER']
    @errors = []
    @user = RegularUser.new
  end

  def create
    @user = RegularUser.new(params[:regular_user])
    if @user.save
      set_session(@user)
      redirect_to cookies[:redirect_to_after_login] || root_path
    else
      @errors = @user.errors.full_messages || []
      render "users/new"
    end
  end

  def show
    redirect_to root_path
    current_user
  end

  def edit
    current_user
  end

  def update
    if @user.update_attributes(params[:regular_user])
      redirect_to root_path
    else
      @errors = @user.errors.full_messages || []
      render action: 'edit'
    end
  end

  def destroy
    current_user.destroy
    redirect_to root_path
  end

  private

  def find_user
    @user = RegularUser.find(current_user.id)
  end

  def matched_user
    redirect_to root_url unless current_user && params[:id] == current_user.id
  end

end
