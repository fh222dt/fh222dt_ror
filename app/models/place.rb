class Place < ActiveRecord::Base
    include Rails.application.routes.url_helpers
    
    has_and_belongs_to_many :tags
    has_many :comments
    belongs_to :user
    
    geocoded_by :address
    after_validation :geocode, :if => :address_changed?
    
    reverse_geocoded_by :latitude, :longitude
    after_validation :reverse_geocode
    
    validates :address, presence: true,
                     length: {maximum: 50}
                     
    validates :description, presence: true,
                     length: {maximum: 150}
    
    
    def serializable_hash (options={})
        options= {
            :except => [:created_at],
            :include => [tags: {:only =>[:name]} ],
            :methods => :place_links
        }
        super(options)
    end
    
    
    def place_links
        links ={
            self: place_path(self), 
            user: user_path(self.user_id), 
        }
        return links
    end
    
end
