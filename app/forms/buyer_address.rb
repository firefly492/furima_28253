class BuyerAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture, :city, :addresses, :building, :phone_number, :user_id, :item_id

  postal = /\A\d{3}[-]\d{4}\z/
  telephone = /\A\d{11}\z/

  with_options presence: true do
    validates :postal_code, format: { with: postal, message: 'を（ハイフン）入れて入力してください' }
    validates :city
    validates :addresses
    validates :phone_number, format: { with: telephone, message: 'を11桁で入力してください' }
  end

  validates :prefecture, numericality: { other_than: 1, message: 'を入力してください' }

  def save
    address = Address.create(postal_code: postal_code, prefecture: prefecture, city: city, addresses: addresses, building: building, phone_number: phone_number, item_id: item_id)
    Buyer.create(user_id: user_id, item_id: item_id)
  end
end
