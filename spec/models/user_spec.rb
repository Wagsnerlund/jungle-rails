require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    before :each do
      @user = User.new({
        name: 'Chelsea',
        last_name: 'Wagner',
        email: 'chelsea@wagner.com',
        password: 'password',
        password_confirmation: 'password'
      })
    end

    it "is valid with all fields present" do
      expect(@user).to be_valid
    end
    
    it "is invalid if no name is given" do
      @user.name = nil
      @user.save
      expect(@user).to be_invalid
      expect(@user.errors.full_messages[0]). to eq("Name can't be blank")
    end

    it "is invalid if no last name is given" do
      @user.last_name = nil
      @user.save
      expect(@user).to be_invalid
      expect(@user.errors.full_messages[0]). to eq("Last name can't be blank")
    end

    it "is invalid if no email is given" do
      @user.email = nil
      @user.save
      expect(@user).to be_invalid
      expect(@user.errors.full_messages[0]). to eq("Email can't be blank")
    end

    it "is invalid if no password is given" do
      @user.password = nil
      @user.save
      expect(@user).to be_invalid
      expect(@user.errors.full_messages[0]). to eq("Password can't be blank")
    end

    it "is invalid if no password confirmation is given" do
      @user.password_confirmation = nil
      @user.save
      expect(@user).to be_invalid
      expect(@user.errors.full_messages[0]). to eq("Email has already been taken")
    end

    it "is invalid when email is not unique" do
      User.create({
        name: 'Chelsea',
        last_name: 'Wagner',
        email: 'chelsea@wagner.com',
        password: 'password',
        password_confirmation: 'password',
        password_digest: '123'
      })

      expect(@user).to be_invalid
      expect(@user.errors.full_messages[0]). to eq("Email has already been taken")
    end
 
    it "is invalid when password and password_confirmation are less than length 3" do
      @user.password = 'pa'
      @user.password_confirmation = 'pa'
      @user.save
      expect(@user).to be_invalid
      expect(@user.errors.full_messages[0]). to eq("Email has already been taken")
    end
  end

  describe ".authenticate_with_credentials" do
    it "returns user if authenticated" do
      user = User.authenticate_with_credentials('chelsea@wagner.com', 'password')
      expect(user).to be == user
    end

    it "returns nil if not successfully authenticated" do
      user = User.authenticate_with_credentials('chelsea@wagner.com', 'pa')
      expect(user).to be == nil
    end

    it "authenticates is white space before/after email" do
      user = User.authenticate_with_credentials(' chelsea@wagner.com ', 'password')
      expect(user).to be == user
    end
    it "autheticates if lower and uppercase in email" do
      user = User.authenticate_with_credentials('chelsea@wagner.com', 'password')
      expect(user).to be == user
    end
  end
end