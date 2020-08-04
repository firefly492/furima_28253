テーブル設計

## users テーブル

| Column            | Type    | Option      |
| ------------------|---------|-------------|
| nickname          | string  | null: false |
| email             | string  | null: false |
| password          | string  | null: false |
| family_name       | string  | null: false |
| first_name        | string  | null: false |
| family_name_kana  | string  | null: false |
| first_name_kana   | string  | null: false |
| birth_year        | string  | null: false |
| birth_month       | string  | null: false |
| birth_date        | string  | null: false |

### Association

- has_many :posts
- has_many :items
- has_many :comments
- has_one :credit_card
- has_one :buyer


## posts テーブル

| Column            | Type    | Option                         |
| ------------------|---------|--------------------------------|
| name              | string  | null: false                    |
| price             | string  | null: false                    |
| category          | string  | null: false                    |
| item_explanation  | text    | null: false                    |
| delivery_burden   | string  | null: false                    |
| prefecture        | string  | null: false                    |
| sipping_date      | string  | null: false                    |
| user_id           | string  | null: false, foreign_key: true |

### Association

- belongs_to :user

## items テーブル

| Column            | Type    | Option                         |
| ------------------|---------|--------------------------------|
| image             | img     | null: false                    |
| item_name         | string  | null: false                    |
| item_explanation  | text    | null: false                    |
| category          | string  | null: false                    |
| item_status       | string  | null: false                    |
| delivery_burden   | string  | null: false                    |
| sipping_region    | string  | null: false                    |
| sipping_date      | string  | null: false                    |
| price             | string  | null: false                    |
| user_id           | string  | null: false, foreign_key: true |

### Association

- belongs_to :user

## comments テーブル

| Column            | Type    | Option                         |
| ------------------|---------|--------------------------------|
| comment           | text    | null: false                    |
| user_id           | string  | null: false, foreign_key: true |
| buyer_id          | string  | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :buyer


## credit_cards テーブル

| Column            | Type    | Option                         |
| ------------------|---------|--------------------------------|
| card_number       | string  | null: false                    |
| expiration_date   | string  | null: false                    |
| expiration_month  | string  | null: false                    |
| security_code     | string  | null: false                    |
| user_id           | string  | null: false, foreign_key: true |

### Association

- belongs_to :user

## buyer テーブル

| Column            | Type    | Option                         |
| ------------------|---------|--------------------------------|
| family_name       | string  | null: false                    |
| first_name        | string  | null: false                    |
| family_name_kana  | string  | null: false                    |
| first_name_kana   | string  | null: false                    |
| postal_code       | string  | null: false                    |
| prefecture        | string  | null: false                    |
| city              | string  | null: false                    |
| house_number      | string  | null: false                    |
| building_name     | string  |                                |
| telephone_number  | string  | null: false                    |
| buyer_id          | string  | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments