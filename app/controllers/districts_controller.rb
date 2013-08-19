class DistrictsController < ApplicationController
  def index
  end

  def show
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
      @district = get_zipcode(params[:zipcode])  if params[:zipcode]
      @district = get_coordinates("#{params[:address]}, #{params[:city]}, #{params[:state]}") if params[:address]
      @district = set_district_by_coordinates(params[:latitude], params[:longitude]) if params[:latitude] && params[:longitude]

    if @district
      session[:district_id] = @district.id
      current_user.set_representative(@district.id) if current_user?
      redirect_to district_path(@district)
    else
      redirect_to find_districts_path
    end
  end
end

