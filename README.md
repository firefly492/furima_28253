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
| birth_date        | date    | null: false |

### Association

- has_many :items
- has_one :buyer
- has_many :comments

## items テーブル

| Column                    | Type     | Option                         |
| --------------------------|----------|--------------------------------|
| image                     | text     | null: false                    |
| name                      | string   | null: false                    |
| info                      | text     | null: false                    |
| category                  | integer  | null: false                    |
| sales_status              | integer  | null: false                    |
| shipping_fee_status       | integer  | null: false                    |
| prefecture                | integer  | null: false                    |
| scheduled_delivery        | integer  | null: false                    |
| price                     | integer  | null: false                    |
| user_id                   | integer  | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :transaction
- has_one :buyer

## addresses テーブル

| Column            | Type     | Option                         |
| ------------------|----------|--------------------------------|
| postal_code       | string   | null: false                    |
| prefecture        | string   | null: false                    |
| city              | string   | null: false                    |
| addresses         | string   | null: false                    |
| building          | string   |                                |
| phone_number      | integer  | null: false                    |
| item_id           | integer  | null: false, foreign_key: true |

### Association

- belongs_to :item
- has_many :comments

## buyers

| Column            | Type     | Option                         |
| ------------------|----------|--------------------------------|
| user_id           | integer  | null: false, foreign_key: true |
| item_id           | integer  | null: false, foreign_key: true |

- belongs_to :user
- belongs_to :item

## comments テーブル

| Column            | Type     | Option                         |
| ------------------|----------|--------------------------------|
| comment           | text     | null: false                    |
| user_id           | integer  | null: false, foreign_key: true |
| buyer_id          | integer  | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :buyer