class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  has_one_attached :image
  belongs_to :user

  belongs_to_active_hash :category
  belongs_to_active_hash :sales_status
  belongs_to_active_hash :shipping_fee_status
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :scheduled_delivery


  with_options presence: true do
    validates :name,                   length: { maximum: 40 }
    validates :info,                   length: { maximum: 1000 }
  end
  validates :category_id,            numericality: { other_than: 0, message: "can't be blank" }
  validates :sales_status_id,        numericality: { other_than: 0, message: "can't be blank" }
  validates :shipping_fee_status_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :prefecture_id,          numericality: { other_than: 0, message: "can't be blank" }
  validates :scheduled_delivery_id,  numericality: { other_than: 0, message: "can't be blank" }
  validates :price,                  numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
end
