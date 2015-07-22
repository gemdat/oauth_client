class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :auth, if: :auth_needed?

  rescue_from OAuth2::Error do |exception|
    alert = exception.description
    if exception.response.status == 401
      session[:access_token] = nil
      alert = 'access token expired'
    end

    session[:access_token] = nil
    puts alert
    redirect_to root_url, alert: alert
  end

  private

  def oauth_client
    @oauth_client ||= OAuth2::Client.new(ENV['OAUTH_ID'], ENV['OAUTH_SECRET'], site: ENV['OAUTH_PROVIDER'])
  end

  def access_token
    if session[:access_token]
      @access_token ||= OAuth2::AccessToken.new(oauth_client, session[:access_token])
    else
      fail StandardError, 'invalid app state'
    end
  end

  def auth_needed?
    session[:access_token].nil?
  end

  def access_grant
    session[:access_grant] = params[:code] if params[:code]
    session[:access_grant]
  end

  def retrieve_access_token
    oauth_client.auth_code.get_token(params[:code], redirect_uri: tasks_url).token
  end

  def authorize_url
    oauth_client.auth_code.authorize_url(redirect_uri: tasks_url)
  end

  def auth
    if access_grant
      puts 'retrieving access grant and handle in for token'
      session[:access_token] = retrieve_access_token
    else
      puts 'redirect to authorize url to get access grant'
      redirect_to authorize_url
    end
  end
end
