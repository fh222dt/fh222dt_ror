class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      
      t.references :user
      
      t.string "key", :null => false  #TODO maxantal tecken
      t.string "application_name", :null => false
      t.string "url", :null => false
      
      t.timestamps null: false
    end
  end
end
