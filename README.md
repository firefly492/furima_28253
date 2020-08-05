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
- has_many :comments
- has_one :exhibition

## items テーブル

| Column            | Type    | Option                         |
| ------------------|---------|--------------------------------|
| image             | img     | null: false                    |
| item_name         | string  | null: false                    |
| item_explanation  | text    | null: false                    |
| price             | string  | null: false                    |
| user_id           | string  | null: false, foreign_key: true |
##### ActiveHash
| category_id          | integer  | null: false                |
| item_status_id       | integer  | null: false                |
| delivery_burden_id   | integer  | null: false                |
| sipping_region_id    | integer  | null: false                |
| sipping_date_id      | integer  | null: false                |

### Association

- belongs_to :user
- has_one :exhibition
- belongs_to :buyer

## comments テーブル

| Column            | Type    | Option                         |
| ------------------|---------|--------------------------------|
| comment           | text    | null: false                    |
| user_id           | string  | null: false, foreign_key: true |
| buyer_id          | string  | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :buyer

## buyer テーブル

| Column            | Type    | Option                         |
| ------------------|---------|--------------------------------|
| postal_code       | string  | null: false                    |
| prefecture        | string  | null: false                    |
| city              | string  | null: false                    |
| house_number      | string  | null: false                    |
| building_name     | string  |                                |
| telephone_number  | string  | null: false                    |
| item_id           | string  | null: false, foreign_key: true |

### Association

- belongs_to :item
- has_many :comments

## exhibition

| Column            | Type    | Option                         |
| ------------------|---------|--------------------------------|
| user_id           | string  | null: false, foreign_key: true |
| item _id          | string  | null: false, foreign_key: true |

- belongs_to :user
- belongs_to :item



##### ActiveHash

| category_id          | integer  | null: false                    |
| item_status_id       | integer  | null: false                    |
| delivery_burden_id   | integer  | null: false                    |
| sipping_region_id    | integer  | null: false                    |
| sipping_date_id      | integer  | null: false                    |