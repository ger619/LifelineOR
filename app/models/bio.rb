class Bio < ApplicationRecord
  belongs_to :user

  # To show the age of a person
  def age
    return unless date_of_birth.present?

    now = Time.now.utc.to_date
    now.year - date_of_birth.year - (date_of_birth.to_date.change(year: now.year) > now ? 1 : 0)
  end

  validates :date_of_birth, :language, :home_town, :city, :country, :about_me, :health_insurance, :nhif_number,
            :nationality, :religion, :blood_group, :hospital_to_attend, presence: true
  # #private

  # #def date_of_birth_cannot_be_in_the_future
  # code here
  # if date_of_birth.present? && date_of_birth > Date.today
  #   errors.add(:date_of_birth, "can't be in the future")
  # end
  # end
end
