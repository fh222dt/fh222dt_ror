class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      
      t.references :user
      
      t.float "longitude"
      t.float "latitude"
      t.string "city", :null => false, :limit => 50
      t.string "description", :null => false, :limit =>150

      t.timestamps null: false
    end
  end
end
