require 'rails_helper'

RSpec.describe Payment, type: :model do
  before(:each) do
    @user = User.create(name: 'User', email: '456@gmail.com', password: '123456', password_confirmation: '123456')
    @payment = Payment.create(name: 'Payment', amount: 123, user_id: @user.id)
  end

  describe 'validations' do
    it 'should be valid with valid attributes' do
      expect(@payment).to be_a(Payment)
    end

    it 'is valid with a name' do
      expect(@payment.name).to eq('Payment')
    end
  end
end
