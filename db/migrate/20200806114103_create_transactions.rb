class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string  :postal_code,        null: false
      t.integer :prefecture,         null: false
      t.string  :city,               null: false
      t.string  :addresses,          null: false
      t.string  :building
      t.bigint  :phone_number,       null: false
      t.references :user,            null: false, foreign_key: true
      t.references :item,            null: false, foreign_key: true
      t.timestamps
    end
  end
end
