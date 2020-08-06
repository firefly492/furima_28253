class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.text     :item_image,                 null: false
      t.string   :item_name,                  null: false
      t.text     :item_info,                 null: false
      t.integer  :item_category,              null: false
      t.integer  :item_sales_status,          null: false
      t.integer  :item_shipping_fee_status,   null: false
      t.integer  :item_prefecture,            null: false
      t.integer  :item_scheduled_delivery,    null: false
      t.integer  :item_price,                 null: false
      t.integer  :user_id,                    null: false, foreign_key: true
      t.timestamps
    end
  end
end
