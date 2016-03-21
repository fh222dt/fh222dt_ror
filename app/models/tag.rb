class Tag < ActiveRecord::Base
    include Rails.application.routes.url_helpers
    
    has_and_belongs_to_many :places
    
    def as_json(options={})
        super(options.merge(:except =>[:created_at, :updated_at],
        :methods => :tags_links))
    end
    #TODO
    def tags_links
        #{:self =>tag_path(self)}
    end
end
