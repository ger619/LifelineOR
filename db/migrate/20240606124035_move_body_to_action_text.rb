class MoveBodyToActionText < ActiveRecord::Migration[7.0]
  def change
    Profile.all.find_each do |profile|
      profile.update(content: profile.about_me)
    end
    remove_column :profiles, :about_me
  end
end
