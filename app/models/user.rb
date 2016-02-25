class User < ActiveRecord::Base
    has_many :keys 

    has_secure_password
    
    validates :email,
              :presence => {:message => "Ange en epost-adress"},
              uniqueness: true
              
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                        :presence => {:message => "Felaktig epost-adress"}
                        
    validates :password,
              :presence => {:message => "Ange ett lösenord"}
    
end
