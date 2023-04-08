require 'rails_helper'

RSpec.describe Group, type: :model do
  before(:each) do
    @user = User.create(name: 'User', email: '456@gmail.com', password: '123456', password_confirmation: '123456')
    @group = Group.create(name: 'Group', icon: 'www.icon.com/icon.png', user_id: @user.id)
  end

  describe 'validations' do
    it 'should be valid with valid attributes' do
      expect(@group).to be_a(Group)
    end

    it 'is valid with a name' do
      expect(@group.name).to eq('Group')
    end
  end
end
