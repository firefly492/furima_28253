class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :item, dependent: :destroy
  has_one :buyer
  has_many :comments

  with_options presence: true do
    validates :nickname, uniqueness: true
    validates :password_confirmation, format: { with: /\A[a-z0-9]+\z/i, message: 'を半角で入力してください。' }
    validates :family_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'を全角で入力してください。' }
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'を全角で入力してください。' }
    validates :family_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'を全角カナで入力してください。' }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'を全角カナで入力してください。' }
  end
  validates :password, format: { with: /\A[a-z0-9]+\z/i, message: 'を半角で入力してください。' }
  validates :birth_date, presence: true
end
