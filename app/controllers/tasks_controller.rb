class TasksController < ApplicationController
  def index
    @tasks = access_token.get("#{ENV['OAUTH_PROVIDER']}/api/users").parsed
    puts @tasks.inspect
    head status: 404 unless @tasks
  end

  def create
    access_token.post('/api/users', params: { task: { name: params[:name] } })
    redirect_to root_url
  end
end
