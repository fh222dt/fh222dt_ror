class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      
      t.belongs_to :place
      
      t.string "name", :null => false, :limit => 50

      t.timestamps null: false
    end
  end
end
