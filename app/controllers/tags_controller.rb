class TagsController < ApplicationController
    before_action :offset_params, only: [:index]
    #before_action :authenticate, only: [:create, :update]
    before_action :api_key
    
    respond_to :json
    
    def index
        @tags = Tag.limit(@limit).offset(@offset)
        no = Tag.distinct.count(:id);
        
        respond_with @tags, status: :ok, location: tags_path, no_of_tags: no
    end
    
    def show
        @tag = Tag.find_by_id(params[:id])
        
        if @tag.present?
            respond_with @tag, location: tags_path(@tag), 
            :include =>[:places => {:except => [:created_at] },  ]
        else
            render json: { error: "Taggen hittades inte. Har du skrivit rätt id?"}, status: :not_found
        end
    end
end
