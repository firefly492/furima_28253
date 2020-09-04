require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  def basic_login
    @request.env ||= {}
    user = "admin"
    pass = "1111"
    @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pass)
  end

  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      #Basic認証を入力する
      

      # トップページに移動する
      visit root_path

      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')

      # 新規登録ページへ移動する
      visit new_user_registration_path

      # ユーザー情報を入力する
      fill_in 'nickname', with: @user.nickname
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password_confirmation
      fill_in 'first-name', with: @user.family_name
      fill_in 'last-name', with: @user.first_name
      fill_in 'first-name-kana', with: @user.family_name_kana
      fill_in 'last-name-kana', with: @user.first_name_kana
      select 1932, from: "user_birth_date_1i"
      select 3, from: "user_birth_date_2i"
      select 11, from: "user_birth_date_3i"

      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)

      # トップページへ遷移する
      expect(current_path).to eq root_path

      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')

      # ユーザーネーム、ログアウトするボタンが表示されていることを確認する
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content('ログアウト')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path

      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')

      # 新規登録ページへ移動する
      visit new_user_registration_path

      # ユーザー情報を入力する
      fill_in 'nickname', with: nil
      fill_in 'email', with: nil
      fill_in 'password', with: nil
      fill_in 'password-confirmation', with: nil
      fill_in 'first-name', with: nil
      fill_in 'last-name', with: nil
      fill_in 'first-name-kana', with: nil
      fill_in 'last-name-kana', with: nil
      select '--', from: "user_birth_date_1i"
      select '--', from: "user_birth_date_2i"
      select '--', from: "user_birth_date_3i"

      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)

      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq'/users'
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path

      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')

      # ログインページへ遷移する
      visit new_user_session_path

      # 正しいユーザー情報を入力する
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password

      # ログインボタンを押す
        find('input[name="commit"]').click

      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path

      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')

      # ログアウトボタンが表示されることを確認する
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content('ログアウト')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path

      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')

      # ログインページへ遷移する
      visit new_user_session_path

      # ユーザー情報を入力する
      fill_in 'email', with: nil
      fill_in 'password', with: nil

      # ログインボタンを押す
      find('input[name="commit"]').click

      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end