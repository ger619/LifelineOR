class User < ApplicationRecord
  devise :two_factor_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :validatable

  # After User is create create a bio
  after_create :create_profile

  def create_profile
    Profile.create(user_id: id)
    Bio.create(user_id: id)
  end

  has_one :bio, foreign_key: :user_id, class_name: 'Bio', dependent: :destroy
  has_one :profile, foreign_key: :user_id, class_name: 'Profile', dependent: :destroy
  has_one :profile, foreign_key: :user_id, class_name: 'Profile', dependent: :destroy

  has_many :exist, foreign_key: :user_id, class_name: 'Exist', dependent: :destroy
  has_many :consultation, foreign_key: :user_id, class_name: 'Consultation', dependent: :destroy
end
