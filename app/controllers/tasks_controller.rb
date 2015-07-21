class TasksController < ApplicationController
  def index
    if params[:code]
      puts 'retrieving access token'
      session[:access_token] = oauth_client.auth_code.get_token(params[:code], redirect_uri: tasks_url).token
    else
      puts 'redirect to authorize url to get access grant'
      redirect_to oauth_client.auth_code.authorize_url(redirect_uri: tasks_url)
    end

    @tasks = access_token.get('http://localhost:3001/api/users').parsed if access_token
  end

  def create
    access_token.post('/api/users', params: {task: {name: params[:name]}})
    redirect_to root_url
  end
end
