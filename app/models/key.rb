class Key < ActiveRecord::Base
    
    belongs_to :user
    before_create :generateRandom
    
    validates :application_name,
                :presence => {:message => "Ange din applikations namn"},
                :length => {:maximum => 50, :too_long => "Namnet får inte vara mer än %{count} tecken långt"}
                
    validates :url,
                :presence => {:message => "Ange din applikations url"},
                :uniqueness => true,
                :length => {:maximum => 100, :too_long => "Namnet får inte vara mer än %{count} tecken långt"}
                
    #generate random string for api key 
    def generateRandom
        self.key = SecureRandom.urlsafe_base64
    end
    
end
