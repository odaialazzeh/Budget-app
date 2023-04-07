require 'rails_helper'

RSpec.describe '/payments', type: :request do
  include Devise::Test::IntegrationHelpers

  describe 'GET /new' do
    before do
      @user = User.create(name: 'User', email: 'user@gmail.com', password: '123456', password_confirmation: '123456')
      sign_in @user
      @group = Group.create(name: 'Group', icon: 'www.icon.com/icon.png', user_id: @user.id)
      get new_group_payment_path(group_id: Group.first.id)
    end

    it 'response to html' do
      expect(response.content_type).to include 'text/html'
    end
  end
end
