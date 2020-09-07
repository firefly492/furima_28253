FactoryBot.define do
  factory :item do
    name                     { Faker::Team.name }
    info                     { 'texttext' }
    category_id              { 2 }
    sales_status_id          { 2 }
    shipping_fee_status_id   { 2 }
    prefecture_id            { 2 }
    scheduled_delivery_id    { 2 }
    price                    { 3000 }
    association :user, factory: :user

    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/camera.png'), filename: 'camera.png', content_type: 'camera/png')
    end
  end
end
