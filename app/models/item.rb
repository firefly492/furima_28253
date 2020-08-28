class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  has_one_attached :image, dependent: :destoroy
  belongs_to :user
  has_one :address
  has_one :buyer
  has_many :comments

  belongs_to_active_hash :category
  belongs_to_active_hash :sales_status
  belongs_to_active_hash :shipping_fee_status
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :scheduled_delivery

  with_options presence: true do
    validates :image
    validates :name,                   length: { maximum: 40 }
    validates :info,                   length: { maximum: 1000 }
  end

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  def self.save_from_yml!(yml_path)
    yml = yml.load(yml_path)
    item = new
    item.image = yml['image']
    item.name = yml['name']
    item.info = yml['info']
    item.category_id = yml['category_id']
    item.sales_status_id = yml['sales_status_id']
    item.shipping_fee_status_id = yml['shipping_fee_status_id']
    item.prefecture_id = yml['prefecture_id']
    item.scheduled_delivery_id = yml['scheduled_delivery_id']
    item.price = yml['price']
    item.save_from_yml!
  end

  def self.edit_item!(image, name, info, category_id, sales_status_id, shipping_fee_status_id, prefecture_id, scheduled_delivery_id, price)
    item = new
    item.image = find_by!(data: image)
    item.name = find_by!(data: name)
    item.info = find_by!(data: info)
    item.category_id = find_by!(data: category_id)
    item.sales_status_id = find_by!(data: sales_status_id)
    item.shipping_fee_status_id = find_by!(data: shipping_fee_status_id)
    item.prefecture_id = find_by!(data: prefecture_id)
    item.scheduled_delivery_id = find_by!(data: scheduled_delivery_id)
    item.price = find_by!(data: price)
    item.save!
  end
end
