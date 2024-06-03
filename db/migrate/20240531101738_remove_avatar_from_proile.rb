class RemoveAvatarFromProile < ActiveRecord::Migration[7.0]
  def change
    remove_column :profiles, :avatar, :string
    remove_column :profiles, :home_address, :string
    remove_column :profiles, :location, :string

  end
end
