class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :place
      
      t.string "text", :null => false, :limit => 250
      t.timestamps null: false
    end
  end
end
