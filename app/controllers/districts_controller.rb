class DistrictsController < ApplicationController
  def index
  end

  def show
    puts "*" * 100
    puts "in the show controller! and id is set to: #{params[:id].inspect}"
    if current_district?
      @district = current_district
    else
      redirect_to root_path
    end
  end

  def find
    puts "in the new controller!"
  end

  def set
    if params[:zipcode]
      @district = Location.get_zipcode(params[:zipcode])
    elsif params[:address]
      @district = Location.get_coordinates(params[:address])
    elsif params[:latitude]
      @district = Location.set_district_by_coordinates(params[:latitude], params[:longitude])
    end

    if @district
      session[:district_id] = @district.id
      current_user.set_representative(@district.id) if current_user?
      redirect_to district_path(@district)
    else
      puts "in the else block!"
      redirect_to find_districts_path
    end
  end
end

