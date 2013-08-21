class LandingController < ApplicationController

  def show
    if current_user && current_district
      redirect_to district_path(current_district)
    end
    @user = current_user
  end

  def about
  end
end
