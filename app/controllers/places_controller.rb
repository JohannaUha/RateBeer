class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    session[:last_city] = params["city"]
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
    @place = BeermappingApi.place_where_id(params["id"], session[:last_city])
    render :show
  end

  def place_params
    params.require(:place).permit( :id, :name, :status, :street, :city, :zip, :country, :overall )
  end
end
