require 'rails_helper'
describe User do
  describe '#create' do

    it "is valid with a nickname, an email, a password and a password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid without a nickname" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it "is invalid without an email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "is invalid if the nickname consists of greater than or equal to 7 characters" do
      user = build(:user, nickname: "1234567")
      user.valid?
      expect(user.errors[:nickname][0]).to include("is too long (maximum is 6 characters)")
    end

    it "is valid if the nickname consists of less than or equal to 6 characters" do
      user = build(:user, nickname: "123456")
      user.valid?
      expect(user).to be_valid
    end

    it "is invalid with a duplicate email address" do
      #はじめにユーザーを登録
      user = create(:user)
      #先に登録したユーザーと同じemailの値を持つユーザーのインスタンスを作成
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    it "is valid with a password consists of greater than or equal to 8 characters" do
      user = build(:user, password: "12345678", password_confirmation: "12345678")
      user.valid?
      expect(user).to be_valid
    end

    it "is invalid with a password consists of less than or equal to 7 characters" do
      user = build(:user, password: "1234567", password_confirmation: "1234567")
      user.valid?
      expect(user.errors[:password][0]).to include("is too short (minimum is 8 characters)")
    end

  end
end
