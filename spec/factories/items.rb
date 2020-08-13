FactoryBot.define do
  factory :item do
    name                     { 'aaaaaa' }
    info                     { 'texttext' }
    category_id              { 1 }
    sales_status_id          { 1 }
    shipping_fee_status_id   { 1 }
    prefecture_id            { 1 }
    scheduled_delivery_id    { 1 }
    price                    { 3000 }
    association :user
  end
end
