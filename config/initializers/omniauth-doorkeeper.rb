require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Doorkeeper < OmniAuth::Strategies::OAuth2
      # change the class name and the :name option to match your application name
      option :name, :doorkeeper
      option :fields, [:id, :email]

      option :client_options, {
        :site => "http://localhost:3000",
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
        puts "RAW INFO"
        puts access_token.get('/me.json').parsed
        @raw_info ||= access_token.get('/me.json').parsed
      end

      def callback_url
        'http://beam-test:4000/users/auth/doorkeeper/callback'
      end
    end
  end
end
