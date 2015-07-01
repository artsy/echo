module V1
  module Endpoints
    class RootEndpoint < Grape::API
      format :json
      formatter :json, Grape::Formatter::Roar
      content_type :json, 'application/hal+json'
      version 'v1', using: :header, vendor: 'echo'

      helpers do
        include Gris::AuthenticationHelpers
      end

      before do
        token_authentication!
      end

      desc 'Get the Root API Endpoint'
      get do
        present self, with: Presenters::RootPresenter
      end

      mount V1::Endpoints::AccountsEndpoint
      mount V1::Endpoints::FeaturesEndpoint
    end
  end
end
