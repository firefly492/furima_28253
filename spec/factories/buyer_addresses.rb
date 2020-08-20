FactoryBot.define do
  factory :buyer_address do
    postal_code             { '123-4567' }
    prefecture              { 2 }
    city                    { '渋谷区' }
    addresses               { '青山１−１' }
    building                { '青山ビル' }
    phone_number            { '09012345678' }
  end
end
