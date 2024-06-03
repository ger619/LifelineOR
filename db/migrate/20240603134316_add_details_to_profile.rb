class AddDetailsToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :date_of_birth, :date
    add_column :profiles, :language, :string
    add_column :profiles, :home_town, :string
    add_column :profiles, :city, :string
    add_column :profiles, :about_me, :string
    add_column :profiles, :health_insurance, :string
    add_column :profiles, :nhif_number, :string
    add_column :profiles, :nationality, :string
    add_column :profiles, :religion, :string
    add_column :profiles, :blood_group, :string
    add_column :profiles, :hospital_to_attend, :string
    add_column :profiles, :country, :string
  end
end
