class LandingController < ApplicationController
  def index
    if current_user? && current_district?
      redirect_to district_path
    end
  end

  def about
  end
end
