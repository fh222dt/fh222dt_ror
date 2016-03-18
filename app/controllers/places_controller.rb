class PlacesController < ApplicationController
    before_action :offset_params, only: [:index]
    before_action :authenticate, only: [:create, :update]
    before_action :api_key
    
    
    
    #@current_user = 5
    
    
    
    

    respond_to :json
    
    def index
        places = Place.limit(@limit).offset(@offset)
        no = Place.distinct.count(:id);
        
        respond_with places, status: :ok, location: places_path, no_of_places: no
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
        place = Place.new(place_params)
        place.user_id = current_user.id             #TODO är detta säkert?
        
        #is there any tags to this picknick place?
        if place_params[:tags].present?
            tags = place_params[:tags]
            tags.each do |t|
                place.tags << Tag.where(tag).first_or_create
            end
        end
        
        if place.save
            respond_with place, status: :created
        else
            render json: { errors: place.errors.messages }, status: :bad_request
        end
    end
    
    def update
        if @place = Place.find_by_id(params[:id])
            if current_user.id == @place.user_id
                if @place.update(city: params["city"], description: params["description"]);     #TODO fyll på med fler
                     respond_with @place do |format|
                        format.json { render json: { action: "update", place: @place }, status: :ok }
                        end
                else
                    render json: { error: "Kunde inte uppdatera platsen, stämmer parametrarna?" }, status: :bad_request
                end
            else
                render json: { error: "Du har inte rättigheter att ändra denna plats, äger du den?" }, status: :bad_request
            end
        else
            render json: { error: "Kunde inte hitta platsen" }, status: :bad_request  
        end
        
    end
    
    def destroy
        if @place = Place.find_by_id(params["id"])
            if current_user = @place.user_id
            
            
            
            @place = Place.find_by_id_and_user_id(params["id"], @user.id) || nil
        if @place.nil?
            render json: { error: "Hittade inte platsen, stämmer id?" }, status: :not_found
        else
            if @place.destroy
                respond_with @place, status: :removed
            else
              render json: { error: "Du får inte ta bort den här platsen!" }, status: :unauthorized
            end
        end
        else
            render json: { error: "Kan inte hitta den efterfrågade platsen" }, status: :bad_request
        end
        # if @place = Place.find_by_id(params["id"])
        #     @place = Place.find_by_id_and_user_id(params["id"], @user.id) || nil
        # if @place.nil?
        #     render json: { error: "Hittade inte platsen, stämmer id?" }, status: :not_found
        # else
        #     if @place.destroy
        #         respond_with @place, status: :removed
        #     else
        #       render json: { error: "Du får inte ta bort den här platsen!" }, status: :unauthorized
        #     end
        # end
        # else
        #     render json: { error: "Kan inte hitta den efterfrågade platsen" }, status: :bad_request
        # end
    end
    
    
    
    
    def place_params    #TODO
        params.permit(:city, :description)
    end
end
