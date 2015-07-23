require 'rails_helper'

RSpec.describe TasksController do
  render_views

  describe 'GET#index' do
    context 'having access token' do
      include_context 'no auth needed'
      it 'responds with 200' do
        get :index
        puts response.body
        expect(response).to have_http_status(200)
      end
    end

    context 'having no access token' do
      include_context 'auth needed'
      it 'responds with 302' do
        get :index
        expect(response).to have_http_status(302)
      end
    end


  end
end



