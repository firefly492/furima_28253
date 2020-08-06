class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string  :postal_code,        null: false
      t.string  :prefecture,         null: false
      t.string  :city,               null: false
      t.string  :addresses,          null: false
      t.string  :building
      t.integer :phone_number,       null: false
      t.integer :item_id,            null: false, foreign_key: true
      t.timestamps
    end
  end
end
