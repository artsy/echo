class ApplicationEndpoint < Grape::API
  mount V1::Endpoints::RootEndpoint
  mount V2::Endpoints::RootEndpoint
end
