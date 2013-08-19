class LandingController < ApplicationController
  def index
    if current_user? && current_district?
      redirect_to district_path
    end
    @user = current_user
  end

  def about
  end
end
