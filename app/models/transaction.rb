class Transaction < ApplicationRecord
  belongs_to :item

  with_options presence: true do
    validates :phone_number, format: { with:  /\A\d{10}$|^\d{11}\z/ } 
  end
end
