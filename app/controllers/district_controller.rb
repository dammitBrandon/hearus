class DistrictController < ApplicationController
  def index
  end

  def create
    @user = RegularUser.find(current_user.id)
    @zipcode = params[:zipcode]
  end

end
