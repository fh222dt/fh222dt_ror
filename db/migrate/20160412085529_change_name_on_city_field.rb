class ChangeNameOnCityField < ActiveRecord::Migration
  def change
    rename_column :places, :city, :address
  end
  

end
