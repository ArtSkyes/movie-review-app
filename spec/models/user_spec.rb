require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(email: 'test@example.com', password: 'password123')
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user = User.new(email: nil, password: 'password123')
      expect(user).not_to be_valid
    end

    it 'is not valid without a password' do
      user = User.new(email: 'test@example.com', password: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid with a duplicate email' do
      User.create(email: 'test@example.com', password: 'password123')
      user = User.new(email: 'test@example.com', password: 'password1234')
      expect(user).not_to be_valid
    end
  end
end
