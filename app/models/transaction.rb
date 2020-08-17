class Transaction < ApplicationRecord
  belongs_to :item

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :city
    validates :addresses
    validates :phone_number, format: { with:  /\A\d{10}$|^\d{11}\z/, message: "is invalid. 11 characters."} 
  end

  validates :prefecture, numericality: { other_than: 1, message: "can't be blank" }

end
