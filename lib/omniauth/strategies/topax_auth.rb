require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class TopaxAuth < OmniAuth::Strategies::OAuth2
      option :name, :topax_auth

      option :client_options, site: ENV['OAUTH_PROVIDER'],
                              authorize_url: '/oauth/authorize'

      uid do
        raw_info['id']
      end

      info do
        {
          email: raw_info['email']
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/user').parsed
      end
    end
  end
end
