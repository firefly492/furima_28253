require 'rails_helper'

RSpec.describe '商品出品', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
    @item.image = File.join(Rails.root, 'app/assets/images/camera.png')
  end
  context '出品ができるとき'do
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
      select "メンズ", from: "item-category"
      select "未使用に近い", from: "item-sales-status"
      select "着払い（購入者負担）", from: "item-shipping-fee-status"
      select "京都府", from: "item-prefecture"
      select "1~2日で発送", from: "item-scheduled-delivery"
      fill_in 'item-price', with: @item.price

      # 出品するを押すとItemモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(1)

      # トップページに遷移することを確認する
      expect(current_path).to eq root_path

      # トップページには先ほど出品した商品名が存在することを確認する（名前）
      expect(page).to have_content(@item.name)

      # トップページには先ほど出品した商品画像が存在することを確認する（画像）
      expect(page).to  have_selector("img[src$='camera.png']")
    end
  end

  context '出品ができないとき'do
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
      select "--", from: "item-category"
      select "--", from: "item-sales-status"
      select "--", from: "item-shipping-fee-status"
      select "--", from: "item-prefecture"
      select "--", from: "item-scheduled-delivery"
      fill_in 'item-price', with: nil

      # 出品してもItemモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(0)

      # 商品出品ページへ戻されることを確認する
      expect(current_path).to eq'/items'
    end
    it 'ログインしていないと出品ページへ遷移できない' do
      # トップページに遷移する
      visit root_path

      #商品出品ページへのリンクがあることを確認する
      expect(page).to have_content('出品する')

      # 出品するボタンを押すことができる
      find('a[href="/items/new"]').click

      # 出品ボタンを押すとログインページへ遷移することを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end