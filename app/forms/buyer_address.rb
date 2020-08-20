class BuyerAddress

  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture, :city, :addresses, :building, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :city
    validates :addresses
    validates :phone_number, format: { with:  /\A\d{10}$|^\d{11}\z/, message: "is invalid. 11 characters."} 
  end

  validates :prefecture, numericality: { other_than: 1, message: "can't be blank" }

  def save
    address = Address.create(postal_code: postal_code, prefecture: prefecture, city: city, addresses: addresses, building: building, phone_number: phone_number, item_id: item_id)
    Buyer.create(user_id: user_id, item_id: item_id)
  end

end