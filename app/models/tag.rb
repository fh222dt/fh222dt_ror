class Tag < ActiveRecord::Base
    include Rails.application.routes.url_helpers
    
    has_and_belongs_to_many :places
    
    def as_json(options={})
        super(options.merge(:except =>[:created_at, :updated_at],
        :methods => :tags_links))
    end
    
    def tags_links
        links ={
            self: tag_path(self)
        }
        return links
    end
end
