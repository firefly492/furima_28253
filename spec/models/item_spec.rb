require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/camera.png'))
  end

  describe '出品機能' do
    context '出品がうまくいく時' do
      it '全ての値が正しく入力されていれば保存できる' do
        expect(@item).to be_valid
      end

      it '画像が1枚あれば出品できる' do
        @item.image = Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/camera.png'))
        expect(@item).to be_valid
      end

      it '商品名が40字以内であれば出品できる' do
        @item.name = 'aaaaaa'
        expect(@item).to be_valid
      end

      it '価格の範囲が¥300~¥9,999,999の間であれば出品できる' do
        @item.price = '3000'
        expect(@item).to be_valid
      end
    end

    context '出品がうまくいかない時' do
      it '画像が空だと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("出品画像を入力してください")
      end

      it '商品名が空だと出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it '商品説明が空だと出品できない' do
        @item.info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end

      it 'カテゴリーが空だと出品できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end

      it '商品状態が空だと出品できない' do
        @item.sales_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end

      it '配送料の負担が空だと出品できない' do
        @item.shipping_fee_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end

      it '発送元の地域が空だと出品できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end

      it '発送までの日数が空だと出品できない' do
        @item.scheduled_delivery_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
      end

      it '価格が空だと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は数値で入力してください")
      end

      it '価格が¥300以下だと出品できない' do
        @item.price = '200'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は300以上の値にしてください")
      end

      it '価格が¥9,999,999以上だと出品できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は9999999以下の値にしてください")
      end
    end
  end
end
