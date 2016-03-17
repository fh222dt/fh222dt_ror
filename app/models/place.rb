class Place < ActiveRecord::Base
    include Rails.application.routes.url_helpers
    
    has_and_belongs_to_many :tags
    has_many :comments
    belongs_to :users
    
    
    #todo add tags!
    def as_json(options={})
        super(options.merge(:except =>[:created_at],
        :include =>[:comments => {:excpet =>[:id, :user_id, :place_id, :updated_at]}],
        :methods => :links))
    end
    
    def links
        {:self =>place_path(self), :comments =>place_comments_path(self)}
    end
    
end
