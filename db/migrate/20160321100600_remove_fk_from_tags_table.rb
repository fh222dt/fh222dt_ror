class RemoveFkFromTagsTable < ActiveRecord::Migration
  def change
    remove_column :tags, :place_id, :int
  end
end
