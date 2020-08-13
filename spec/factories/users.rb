FactoryBot.define do
  factory :user do
    nickname                { 'aaaaaa' }
    email                   { 'test@test.com' }
    password                { 'eeee3333' }
    password_confirmation   { password }
    family_name             { '山田' }
    first_name              { '太郎' }
    family_name_kana        { 'ヤマダ' }
    first_name_kana         { 'タロウ' }
    birth_date              { '2000/01/01' }
  end
end
