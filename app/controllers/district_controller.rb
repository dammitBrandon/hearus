class DistrictController < ApplicationController
  def index
  end

  def new
  end

  def create
    if current_user
      @user = RegularUser.find(current_user.id)
    end
    @zipcode = params[:zipcode]
  end

end
