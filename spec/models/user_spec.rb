require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with all required attributes" do
      user = User.new(
        first_name: "Marlo",
        last_name: "Cat",
        email: 'marlo@cat.com',
        password: "password1234",
        password_confirmation: "password1234"
      )
      expect(user).to be_valid
    end

    it "is invalid without a first name" do
      user = User.new(
        first_name: nil,
        last_name: "Cat",
        email: 'marlo@cat.com',
        password: "password1234",
        password_confirmation: "password1234"
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it "is invalid without a last name" do
      user = User.new(
        first_name: "Marlo",
        last_name: nil,
        email: 'marlo@cat.com',
        password: "password1234",
        password_confirmation: "password1234"
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it "is invalid without an email" do
      user = User.new(
        first_name: "Marlo",
        last_name: "Cat",
        email: nil,
        password: "password1234",
        password_confirmation: "password1234"
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it "is invalid without a password" do
      user = User.new(
        first_name: "Marlo",
        last_name: "Cat",
        email: nil,
        password: nil,
        password_confirmation: nil
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it "is invalid if password and password_confirmation do not match" do
      user = User.new(
        first_name: "Marlo",
        last_name: "Cat",
        email: nil,
        password: "password1234",
        password_confirmation: 'wrongpass1234'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "requires a uniqe email (not case-sensitive)" do
      User.create!(
        first_name: "Marlo",
        last_name: "Cat",
        email: "marlo@CAT.com",
        password: "password1234",
        password_confirmation: 'password1234'
      )

      user = User.new(
        first_name: "Marlo",
        last_name: "Cat",
        email: "Marlo@cat.com",
        password: "password1234",
        password_confirmation: 'password1234'
      )

      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it "requires a password between 12 and 18 characters" do
      user = User.new(
        first_name: "Midna",
        last_name: "Cat",
        email: "Midna@cat.com",
        password: "password1234",
        password_confirmation: 'password1234'
      )

      user1 = User.new(
        first_name: "Midna",
        last_name: "Cat",
        email: "Midna@cat.com",
        password: "password",
        password_confirmation: 'password'
      )

      user2 = User.new(
        first_name: "Midna",
        last_name: "Cat",
        email: "Midna@cat.com",
        password: "password12345678900",
        password_confirmation: 'password12345678900'
      )

      expect(user).to be_valid

      expect(user1).not_to be_valid
      expect(user1.errors.full_messages).to include("Password is too short (minimum is 12 characters)")

      expect(user2).not_to be_valid
      expect(user2.errors.full_messages).to include("Password is too long (maximum is 18 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.create(
        first_name: "Theo",
        last_name: "Cat",
        email: "Theo@cat.com",
        password: "password1234",
        password_confirmation: "password1234"
      )
    end

    it "returns the user if the email and password match" do
      authenticated_user = User.authenticate_with_credentials("Theo@cat.com", "password1234")
      expect(authenticated_user).to eq(@user)
    end

    it "returns nil if the email does not match any user" do
      authenticated_user = User.authenticate_with_credentials("emaildoesnot@exist.com", "password1234")
      expect(authenticated_user).to eq(nil)
    end

    it "returns nil if the password is incorrect" do
      authenticated_user = User.authenticate_with_credentials("theo@cat.com", "password")
      expect(authenticated_user).to eq(nil)
    end

    it "ignores spaces and still authenticates successfully" do
      authenticated_user = User.authenticate_with_credentials("  theo@cat.com", "password1234")
      expect(authenticated_user).to eq(@user)
    end

    it "authenticates regardless of case" do
      authenticated_user = User.authenticate_with_credentials("THEO@cat.com", "password1234")
      expect(authenticated_user).to eq(@user)
    end

  end
end
