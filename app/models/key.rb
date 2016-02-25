class Key < ActiveRecord::Base
    
    belongs_to :user
    before_create :generateRandom
    
    validates :application_name,
                :presence => {:message => "Ange din applikations namn"}
                
    validates :url,             #TODO regex för www
                :presence => {:message => "Ange din applikations url"},
                uniqueness: true
                
    #generate random string for api key 
    def generateRandom
        self.key = SecureRandom.urlsafe_base64
    end
    
end
