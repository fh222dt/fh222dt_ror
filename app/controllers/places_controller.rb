class PlacesController < ApplicationController
    before_action :offset_params, only: [:index, :nearby]
    respond_to :json
    
    def index
        places = Place.limit(@limit).offset(@offset)
        no = Place.distinct.count(:id);
        
        respond_with places, status: :ok, location: places_path, no_of_places: no
    end
    
    def show
        @place = Place.find_by_id(params[:id])
        
        respond_with @place
    end
end
