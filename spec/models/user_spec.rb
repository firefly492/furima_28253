require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  #pending "add some examples to (or delete) #{__FILE__}"

  describe 'ユーザー新規登録' do
    context 'ユーザー新規登録がうまくいくとき' do

      it '全ての値が正しく入力されていれば保存できる' do
        expect(@user).to be_valid
      end

      it 'emailに@があれば登録できる' do
        @user.email = "test@test.com"
        expect(@user).to be_valid
      end

      it 'passwordが６文字以上であれば登録できる' do
        @user.password = "eeee3333"
        expect(@user).to be_valid
      end

      it 'passwordが半角英数混合であれば登録できる' do
        @user.password = "eeee3333"
        expect(@user).to be_valid
      end

      it 'passwordがpassword_confirmationと一緒であれば登録できる' do
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end

      it 'family_nameとfirst_nameかつ両方とも全角（漢字・ひらがな・カタカナ）があれば登録できる' do
        @user.family_name = "山田"
        @user.first_name = "太郎"
        expect(@user).to be_valid
      end

      it 'family_name_kanaとfirst_name_kanaかつ全角（カタカナ）があれば登録できる' do
        @user.family_name_kana = "ヤマダ"
        @user.first_name_kana = "タロウ"
        expect(@user).to be_valid
      end
    end

    context 'ユーザー新規登録がうまくいかないとき' do
      
      it "nicknameが空だと登録できない" do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it "emailが空だと登録できない" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "emailの一意性がないと登録できない" do
        duplicate_user = @user.dup
        duplicate_user.email = @user.email.upcase
        @user.save
        duplicate_user.valid?
        expect(duplicate_user.errors.full_messages).to include("Email has already been taken")
      end

      it "emailに@がないと登録できない" do
        @user.email = "testtest.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "passwordが空だと登録できない" do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "passwordが5文字以下であれば登録できない" do
        @user.password = "aaaaa"
        @user.password_confirmation = "aaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it "passwordが半角英数字混合以外だと登録できない" do
        @user.password = "eeee333３"
        @user.password_confirmation = "eeee333３"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Input half-width characters.")
      end

      it "pssswordが入力されていても、password_confirmationが空だと登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", "Password confirmation can't be blank", "Password confirmation is invalid. Input half-width characters.")
      end

      it "password_confirmationがpasswordと一致しないと登録できない" do
        @user.password = "eeee3333"
        @user.password_confirmation = "eeee2222"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "family_nameとが空だと登録できない" do
        @user.family_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end

      it "family_nameが全角（漢字・ひらがな・カタカナ）以外だと登録できない" do
        @user.family_name = "yamada"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid. Input full-width characters.")
      end

      it "first_nameが空だと登録できない" do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it "first_nameが全角（漢字・ひらがな・カタカナ）以外だと登録できない" do
        @user.first_name = "tarou"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters.")
      end

      it "family_name_kanaが空だと登録できない" do
        @user.family_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end

      it "family_name_kanaが全角（カタカナ）以外だと登録できない" do
        @user.family_name_kana = "yamada"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana is invalid. Input full-width katakana characters.")
      end

      it "first_name_kanaが空だと登録できない" do
        @user.first_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it "first_name_kanaが全角（カタカナ）以外だと登録できない" do
        @user.first_name_kana = "tarou"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters.")
      end

      it "birth_dateが空だと登録できない" do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end