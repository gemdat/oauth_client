require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class TopaxAuth < OmniAuth::Strategies::OAuth2
      # change the class name and the :name option to match your application name
      option :name, :topax_auth

      option :client_options, {
                                :site => "http://localhost:3001",
                                :authorize_url => "/oauth/authorize"
                            }

      uid { raw_info["id"] }

      info do
        {
            :email => raw_info["email"]
            # and anything else you want to return to your API consumers
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/user').parsed
      end
    end
  end
end
