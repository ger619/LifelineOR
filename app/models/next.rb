class Next < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
