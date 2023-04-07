require 'rails_helper'

RSpec.describe '/groups', type: :request do
  include Devise::Test::IntegrationHelpers

  describe 'GET /new' do
    before do
      @user = User.create(name: 'User', email: 'user@gmail.com', password: '123456', password_confirmation: '123456')
      sign_in @user
      get new_group_path
    end

    it 'responds with HTML' do
      expect(response.content_type).to include 'text/html'
    end
  end

  describe 'GET /index' do
    before do
      @group = Group.create(name: 'Test Group', icon: 'www.icon.com/icon.png',
                            user_id: User.create(name: 'User2', email: 'user2@gmail.com', password: '123456',
                                                 password_confirmation: '123456').id)
      get group_path(@group)
    end

    it 'responds with HTML' do
      expect(response.content_type).to include 'text/html'
    end
  end
end
