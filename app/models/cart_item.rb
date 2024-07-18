class CartItem < ApplicationRecord
  # associations
  belongs_to :product
  belongs_to :cart

  # validations
  validates :product_id, uniqueness: { scope: :cart_id, message: "can only be added once per cart" }
end
