class Place < ActiveRecord::Base
    has_and_belongs_to_many :tags
    has_many :comments
    belongs_to :users
end
