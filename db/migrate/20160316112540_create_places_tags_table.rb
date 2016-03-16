class CreatePlacesTagsTable < ActiveRecord::Migration
  def change
    create_table :places_tags do |t|
      t.belongs_to :place, index: true, foreign_key: true
      t.belongs_to :tag, index: true, foreign_key: true
      
    end
  end
end
