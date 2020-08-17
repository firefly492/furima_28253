class Transaction < ApplicationRecord
  belongs_to :item

  with_options presence: true do
    validates :postal_code
    validates :city
    validates :addresses
    validates :phone_number, format: { with:  /\A\d{10}$|^\d{11}\z/ } 
  end

  validates :prefecture, numericality: { other_than: 1, message: "can't be blank" }

end
