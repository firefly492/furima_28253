require 'rails_helper'

RSpec.describe BuyerAddress, type: :model do
  before do
    @buyer_address = FactoryBot.build(:buyer_address)
  end

  describe '商品購入情報' do
    context '購入がうまくいく時' do
      it '全ての値が正しく入力されていれば保存できる' do
        expect(@buyer_address).to be_valid
      end

      it '建物名が入力されていなくても保存できる' do
        @buyer_address.building = nil
        expect(@buyer_address).to be_valid
      end

      it '電話番号にハイフンがなくても保存できる' do
        @buyer_address.phone_number = '09012345678'
        expect(@buyer_address).to be_valid
      end
    end

    context '購入がうまくいかない時' do
      it '郵便番号が正しく入力できていなければ保存できない' do
        @buyer_address.postal_code = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('郵便番号を入力してください', '郵便番号を（ハイフン）入れて入力してください')
      end

      it '郵便番号が7桁でハイフン(-)が入力されていなければ保存できない' do
        @buyer_address.postal_code = '1234567'
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('郵便番号を（ハイフン）入れて入力してください')
      end

      it '都道府県が正しく入力できていなければ保存できない' do
        @buyer_address.prefecture = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('都道府県を入力してください')
      end

      it '市町村が正しく入力できていなければ保存できない' do
        @buyer_address.city = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('市区町村を入力してください')
      end

      it '番地が正しく入力できていなければ保存できない' do
        @buyer_address.addresses = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('番地を入力してください')
      end

      it '電話番号が正しく入力できていなければ保存できない' do
        @buyer_address.phone_number = nil
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('電話番号を入力してください', '電話番号を11桁で入力してください')
      end

      it '電話番号が11桁出なければ保存できない' do
        @buyer_address.phone_number = '0901234567'
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('電話番号を11桁で入力してください')
      end
    end
  end
end
