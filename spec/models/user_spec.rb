require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'must be created with password and password_confirmation fields' do
      user = User.new(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user.valid?).to be true
    end

    it 'requires password and password_confirmation to match' do
      user = User.new(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password123',
        password_confirmation: 'differentpassword'
      )
      expect(user.valid?).to be false
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'requires password and password_confirmation fields when creating the model' do
      user = User.new(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe'
      )
      expect(user.valid?).to be false
    end
    
    it 'requires emails to be unique (case-insensitive)' do
      existing_user = User.create(
        email: 'test@test.com',
        first_name: 'Jane',
        last_name: 'Smith',
        password: 'password123',
        password_confirmation: 'password123'
      )

      user = User.new(
        email: 'test@test.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user.valid?).to be false
    end

    it 'requires email, first name, and last name fields when creating the model' do
      user = User.new(
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user.valid?).to be false
    end

    it 'requires a minimum length for the password when creating the model' do
      user = User.new(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'pass',
        password_confirmation: 'pass'
      )
      expect(user.valid?).to be false
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'john.doe@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
    end

    it 'returns user instance when provided with valid credentials' do
      authenticated_user = User.authenticate_with_credentials('john.doe@example.com', 'password123')
      expect(authenticated_user).to eq(@user)
    end

    it 'returns nil when provided with incorrect password' do
      authenticated_user = User.authenticate_with_credentials('john.doe@example.com', 'wrong_password')
      expect(authenticated_user).to be_nil
    end

    it 'returns nil when provided with non-existent email' do
      authenticated_user = User.authenticate_with_credentials('non_existent@example.com', 'password123')
      expect(authenticated_user).to be_nil
    end

    it 'ignores leading/trailing whitespaces in email' do
      authenticated_user = User.authenticate_with_credentials('  john.doe@example.com  ', 'password123')
      expect(authenticated_user).to eq(@user)
    end

    it 'performs a case-insensitive search for email' do
      authenticated_user = User.authenticate_with_credentials('JOHN.DOE@example.com', 'password123')
      expect(authenticated_user).to eq(@user)
    end
    
  end

end
