class LandingController < ApplicationController
  def index
    if current_user? && current_district?
      redirect_to district_path
    end
    puts "*"*100
    p current_user
    @user = current_user
  end

  def about
  end
end
