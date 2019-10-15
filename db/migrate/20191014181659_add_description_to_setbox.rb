class AddDescriptionToSetbox < ActiveRecord::Migration[5.2]
  def change
    add_column :setboxes, :description, :string
  end
end
