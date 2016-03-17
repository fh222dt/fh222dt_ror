class PlacesController < ApplicationController
    
    respond_to :json
    
    def index
        @places = Place.all
        
        respond_with(@places, templete: "places/places")
        #render json: {:places =>@places}.to_json
    end
    
    def show
        @place = Place.find_by_id(params[:id])
        
        respond_with @place
    end
end
