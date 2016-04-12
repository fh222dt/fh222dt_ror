class PlacesController < ApplicationController
    before_action :offset_params, only: [:index]
    before_action :authenticate, only: [:create, :update, :destroy]
    before_action :api_key
    
    respond_to :json
    
    def index       #TODO offset & limit links?????
        places = Place.order(updated_at: :desc).limit(@limit).offset(@offset)
        no = Place.distinct.count(:id);
        
        respond_with places, status: :ok, no_of_places: no, offset: @offset, limit: @limit
    end
    
    def show
        place = Place.find_by_id(params[:id])
        
        if place.present?
            respond_with place, location: places_path(place)
        else
            render json: { error: "Picknickplats hittades inte. Har du skrivit rätt id?"}, status: :not_found
        end
    end
    
    def create
        place = Place.new(place_params.except(:tags, :latitude, :longitude))
        place.user_id = current_user.id
        if params[:tags].present?
             tags = params[:tags]
             tags.each do |tag|
                if Tag.find_by(name: tag)
                  place.tags << Tag.find_by(name: tag)
                else
                  place.tags << Tag.create(name: tag)
                end
            end
        end
        
        if params[:latitude].present? && params[:longitude].present?
          lat = params[:latitude]
          long = params[:longitude]
          
          place.latitude = lat
          place.longitude = long
        end
        
        if place.save
            respond_with place, status: :created
        else
            render json: { error: "Kunde inte lägga till platsen, stämmer parametrarna?" }, status: :bad_request
        end
    end
    
    def update
        if place = Place.find_by_id(params[:id])
            if current_user.id == place.user_id
                update_params = place_params
                place.address = params[:address] if update_params[:address].present?
                place.description = params[:description] if update_params[:description].present?
                place.latitude = params[:latitude] if update_params[:latitude].present?
                place.longitude = params[:longitude] if update_params[:longitude].present?
                
                if params[:tags].present?
                  place.tags.delete_all
                  tags = params[:tags]
                  tags.each do |tag|
                    if Tag.find_by(name: tag)
                      place.tags << Tag.find_by(name: tag)
                    else
                      place.tags << Tag.create(name: tag)
                    end
                  end
                end
                
                if place.save
                    render json: { action: "update", message: "Picknickplats uppdaterad" }, status: :ok
                else
                    render json: { error: "Kunde inte uppdatera platsen, stämmer parametrarna?" }, status: :bad_request
                end
            else
                render json: { error: "Du har inte rättigheter att ändra denna plats, äger du den?" }, status: :unauthorized
            end
        else
            render json: { error: "Kunde inte hitta platsen" }, status: :bad_request  
        end
    end
    
    def destroy
        if place = Place.find_by_id(params["id"])
            if current_user.id == place.user_id
                place.destroy
                render json: { action: "destroy", message: "Picknickplats borttagen" }, status: :ok
            else
                render json: { error: "Du får inte ta bort en annan användares picknickplats" }, status: :unauthorized
            end
        else
            render json: { error: "Hittar inte picknickplatsen" }, status: :bad_request
        end
    end
    
    def nearby
        if params[:long].present? && params[:lat].present?
            p = Place.near([params[:lat], params[:long]], 10, units: :km)
            unless p.empty?
                respond_with p, status: :ok
            else
                render json: { message: "Det finns inga picknickplatser i valt område ännu" }, status: :ok
            end
        else
            render json: { error: "Hittar inga picknickplatser, stämmer parametrarna?" }, status: :bad_request
        end
    end
    
    def place_params
        parameters = ActionController::Parameters.new(
          place:
          {
            address: params[:address],
            description: params[:description],
            latitude: params[:latitude],
            longitude: params[:longitude],
            tags: params[tags: []]
          }
        )
        parameters.require(:place).permit(:address, :description, :latitude, :longitude, :tags)
    end
end
