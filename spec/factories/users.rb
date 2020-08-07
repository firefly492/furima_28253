FactoryBot.define do
  factory :user do
    nickname                {'aaaaaa'}
    email                   {'test@test.com'}
    password                {'eeee3333'}
    password_confirmation   {password}
    family_name             {'山田'}
    first_name              {'太郎'}
    family_name_kana        {'ヤマダ'}
    first_name_kana         {'タロウ'}
    birth_date              {'2000/01/01'}
    # nickname                {Faker::Name.initials}
    # email                   {Faker::Internet.free_email}
    # password                {Faker::Internet.password(min_length: 6)}
    # password_confirmation   {password}
    # family_name             {Faker::Gimei.family.name.kanji}
    # first_name              {Faker::Gimei.first.name.kanji}
    # family_name_kana        {Faker::Gimei.family.name.katakana}
    # first_name_kana         {Faker::Gimei.firast.name.katakana}
    # birth_date              {2000/01/01}
  end
end