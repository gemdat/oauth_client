class TasksController < ApplicationController
  def index
    @tasks = access_token.get("#{ENV['OAUTH_PROVIDER']}/api/users").parsed
  end

  def create
    access_token.post('/api/users', params: { task: { name: params[:name] } })
    redirect_to root_url
  end
end
