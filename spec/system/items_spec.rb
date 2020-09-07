require 'rails_helper'

RSpec.describe '商品出品', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
    @item.image = File.join(Rails.root, 'app/assets/images/camera.png')
  end
  context '出品ができるとき' do
    it 'ログインしたユーザーは商品出品できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path

      # 商品出品ページへのリンクがあることを確認する
      expect(page).to have_content('出品する')

      # 商品出品ページに移動する
      visit new_item_path

      # フォームに情報を入力する
      attach_file 'item-image', "#{Rails.root}/app/assets/images/camera.png"
      fill_in 'item-name', with: @item.name
      fill_in 'item-info', with: @item.info
      select 'メンズ', from: 'item-category'
      select '未使用に近い', from: 'item-sales-status'
      select '着払い（購入者負担）', from: 'item-shipping-fee-status'
      select '京都府', from: 'item-prefecture'
      select '1~2日で発送', from: 'item-scheduled-delivery'
      fill_in 'item-price', with: @item.price

      # 出品するを押すとItemモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(1)

      # トップページに遷移することを確認する
      expect(current_path).to eq root_path

      # トップページには先ほど出品した商品名が存在することを確認する（名前）
      expect(page).to have_content(@item.name)

      # トップページには先ほど出品した商品画像が存在することを確認する（画像）
      expect(page).to have_selector("img[src$='camera.png']")
    end
  end

  context '出品ができないとき' do
    it '誤った情報では商品を出品できずに商品出品ページへ戻ってくる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path

      # 商品出品ページへのリンクがあることを確認する
      expect(page).to have_content('出品する')

      # 商品出品ページに移動する
      visit new_item_path

      # フォームに情報を入力する
      fill_in 'item-name', with: nil
      fill_in 'item-info', with: nil
      select '--', from: 'item-category'
      select '--', from: 'item-sales-status'
      select '--', from: 'item-shipping-fee-status'
      select '--', from: 'item-prefecture'
      select '--', from: 'item-scheduled-delivery'
      fill_in 'item-price', with: nil

      # 出品してもItemモデルのカウントが上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)

      # 商品出品ページへ戻されることを確認する
      expect(current_path).to eq '/items'
    end
    it 'ログインしていないと出品ページへ遷移できない' do
      # トップページに遷移する
      visit root_path

      # 商品出品ページへのリンクがあることを確認する
      expect(page).to have_content('出品する')

      # 出品するボタンを押すことができる
      find('a[href="/items/new"]').click

      # 出品ボタンを押すとログインページへ遷移することを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe '商品詳細', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user_id: @user1.id)
  end

  context '商品の詳細をみることができる' do
    it '出品者以外のユーザーは詳細画面で購入画面ボタンがある' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user1.email
      fill_in 'password', with: @user1.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path

      # ログアウトする
      find('a[href="/users/sign_out"]').click
      visit root_path

      # 商品詳細ページへ移動する
      visit item_path(@item.id)

      # 商品詳細ページに商品情報が表示されている
      expect(page).to have_content(@item.name)
      expect(page).to have_content(@item.info)
      expect(page).to have_content(@item.category.name)
      expect(page).to have_content(@item.sales_status.name)
      expect(page).to have_content(@item.shipping_fee_status.name)
      expect(page).to have_content(@item.prefecture.name)
      expect(page).to have_content(@item.scheduled_delivery.name)

      # 商品詳細ページに購入画面ボタンがあることを確認する
      expect(page).to have_content('購入画面に進む')

      # 商品詳細ページにコメントボタンが表示されていないことを確認する
      expect(page).to have_no_content('コメントする')
    end

    it '出品者は商品詳細画面で編集・削除ボタンがある' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user1.email
      fill_in 'password', with: @user1.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path

      # 商品を出品する
      visit new_item_path
      attach_file 'item-image', "#{Rails.root}/app/assets/images/camera.png"
      fill_in 'item-name', with: @item.name
      fill_in 'item-info', with: @item.info
      select 'メンズ', from: 'item-category'
      select '未使用に近い', from: 'item-sales-status'
      select '着払い（購入者負担）', from: 'item-shipping-fee-status'
      select '京都府', from: 'item-prefecture'
      select '1~2日で発送', from: 'item-scheduled-delivery'
      fill_in 'item-price', with: @item.price
      find('input[name="commit"]').click
      expect(current_path).to eq root_path

      # 商品詳細ページへ移動する
      visit item_path(@item.id)

      # 商品詳細ページに商品情報が表示されている
      expect(page).to have_content(@item.name)
      expect(page).to have_content(@item.info)
      expect(page).to have_content(@item.category.name)
      expect(page).to have_content(@item.sales_status.name)
      expect(page).to have_content(@item.shipping_fee_status.name)
      expect(page).to have_content(@item.prefecture.name)
      expect(page).to have_content(@item.scheduled_delivery.name)

      expect(page).to have_no_content('購入画面に進む')

      # 商品詳細ページに編集・削除ボタンがあることを確認する
      expect(page).to have_content('商品の編集')
      expect(page).to have_content('削除')

      # 商品詳細ページにコメントボタンが表示されていることを確認する
      expect(page).to have_selector('input[value="コメントする"]')
    end
  end
end

RSpec.describe '商品編集', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user_id: @user1.id)
  end
  context '商品の編集をすることができる' do
    it '商品出品者は出品商品を編集することができる' do
      # ログインして商品詳細ページへ移動する
      visit new_user_session_path
      fill_in 'email', with: @user1.email
      fill_in 'password', with: @user1.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      visit item_path(@item.id)

      # 商品詳細ページに編集ボタンがあることを確認する
      expect(page).to have_content('商品の編集')

      # 商品編集画面へ遷移することができる
      visit edit_item_path(@item.id)

      # 商品詳細ページに商品情報が表示されている
      expect(page).to have_content(@item.name)
      expect(page).to have_content(@item.info)
      expect(page).to have_content(@item.category.name)
      expect(page).to have_content(@item.sales_status.name)
      expect(page).to have_content(@item.shipping_fee_status.name)
      expect(page).to have_content(@item.prefecture.name)
      expect(page).to have_content(@item.scheduled_delivery.name)

      # 商品情報を変更する

      fill_in 'item-name', with: 'カメラ'
      fill_in 'item-info', with: '本体です'
      select 'メンズ', from: 'item-category'
      select '傷や汚れあり', from: 'item-sales-status'
      select '送料込み（出品者負担）', from: 'item-shipping-fee-status'
      select '東京都', from: 'item-prefecture'
      select '2~3日で発送', from: 'item-scheduled-delivery'
      fill_in 'item-price', with: '5000'

      # 出品してもItemモデルのカウントが上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)

      # 商品詳細ページに遷移することを確認する
      expect(current_path).to eq item_path(@item.id)

      # 商品詳細ページの商品情報が編集されているか確認する
      expect(page).to have_content('カメラ')
      expect(page).to have_content('本体です')
      expect(page).to have_content('メンズ')
      expect(page).to have_content('傷や汚れあり')
      expect(page).to have_content('送料込み（出品者負担）')
      expect(page).to have_content('東京都')
      expect(page).to have_content('2~3日で発送')
      expect(page).to have_content('5000')
    end
  end
end

RSpec.describe '商品購入', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user_id: @user1.id)
    @address = FactoryBot.build(:buyer_address, item_id: @item.id)
  end

  context '商品の購入をすることができる' do
    it '出品者以外のログインユーザーは商品を購入できる' do
      # ログインして商品詳細ページへ移動する
      visit new_user_session_path
      fill_in 'email', with: @user2.email
      fill_in 'password', with: @user2.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      visit item_path(@item.id)

      # 商品購入画面に移動する
      visit item_buyers_path(@item)

      # フォームに情報を入力する
      fill_in 'card-number', with: '4242424242424242'
      fill_in 'card-exp-month', with: '3'
      fill_in 'card-exp-year', with: '23'
      fill_in 'card-cvc', with: '123'
      fill_in 'postal-code', with: @address.postal_code
      select '北海道', from: 'prefecture'
      fill_in 'city', with: @address.city
      fill_in 'addresses', with: @address.addresses
      fill_in 'phone-number', with: @address.phone_number

      # 購入ボタンを押すとAddressモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
        sleep(3)
      end.to change { Address.count }.by(1)

      # トップページに遷移することを確認する
      expect(current_path).to eq root_path

      # トップページにsoldoutがあることを確認する
      expect(page).to have_content('Sold Out!!')
    end

    it '誤った情報では商品を購入できずに商品購入ページへ戻ってくる' do
      # ログインして商品詳細ページへ移動する
      visit new_user_session_path
      fill_in 'email', with: @user2.email
      fill_in 'password', with: @user2.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      visit item_path(@item.id)

      # 商品購入画面に移動する
      visit item_buyers_path(@item)

      # フォームに情報を入力する
      fill_in 'card-number', with: nil
      fill_in 'card-exp-month', with: nil
      fill_in 'card-exp-year', with: nil
      fill_in 'card-cvc', with: nil
      fill_in 'postal-code', with: nil
      select '北海道', from: 'prefecture'
      fill_in 'city', with: nil
      fill_in 'addresses', with: nil
      fill_in 'phone-number', with: nil

      # 購入してもBuyerモデルとAddressモデルのカウントが上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Buyer.count }.by(0)

      expect do
        find('input[name="commit"]').click
      end.to change { Address.count }.by(0)

      # 商品購入ページへ戻されることを確認する
      expect(current_path).to eq item_buyers_path(@item)
    end

    it 'ログインしていないユーザーは商品購入画面へ移動できない' do
      # 商品詳細ページへ移動する
      visit item_path(@item.id)

      # 商品詳細ページで購入画面へ進むを押す
      find('a[class="item-red-btn"]').click

      # 購入画面に進むを押すとログインページへ遷移することを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe '商品削除', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user_id: @user1.id)
  end
  context '商品の削除をすることができる' do
    it '商品出品者は自ら出品商品を削除することができる' do
      # ログインして商品詳細ページへ移動する
      visit new_user_session_path
      fill_in 'email', with: @user1.email
      fill_in 'password', with: @user1.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      visit item_path(@item.id)

      # 商品詳細ページに削除ボタンがあることを確認する
      expect(page).to have_content('削除')

      # 削除ボタンを押すことができる
      find('a[class="item-destroy"]').click

      # 削除ボタンを押すとトップページへ遷移することを確認する
      expect(current_path).to eq root_path

      # トップページには先ほど出品した商品画像が存在しないことを確認する（画像）
      expect(page).to have_no_selector("img[src$='camera.png']")
    end
  end
end
