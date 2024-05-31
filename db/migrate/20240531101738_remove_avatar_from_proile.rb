class RemoveAvatarFromProile < ActiveRecord::Migration[7.0]
  def change
    remove_column :profiles, :avatar, :string
  end
end
