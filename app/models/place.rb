class Place < ActiveRecord::Base
    include Rails.application.routes.url_helpers
    
    has_and_belongs_to_many :tags
    has_many :comments
    belongs_to :users
    
    def as_json(options={})
        super(options.merge(:except =>[:created_at],
        :include =>[:comments => {:except =>[:id, :user_id, :place_id, :updated_at]},:tags => {:except =>[:id, :created_at, :updated_at]} ],
        #:include =>[:tags => {:except =>[:id, :created_at, :updated_at]}],
        :methods => :links))
    end
    
    #TODO
    #tag
    #enskild
    #all från samma anv
    #i närheten??? geografiskt omr
    def links
        {:self =>place_path(self), :user =>user_path(self)}
    end
    
end
