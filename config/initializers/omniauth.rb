require File.expand_path('lib/omniauth/strategies/topax_auth', Rails.root)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :topax_auth, ENV['OAUTH_ID'], ENV['OAUTH_SECRET']
end
