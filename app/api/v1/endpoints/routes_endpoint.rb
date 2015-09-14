module V1
  module Endpoints
    class RoutesEndpoint < Grape::API
      namespace :routes do
        desc 'List existing routes'
        params do
          optional :page, type: Integer, default: 1, desc: 'Current page.'
          optional :size, type: Integer, default: 10, desc: 'Number of routes to return per page.'
          optional :account_id, type: Integer, desc: 'Account ID for routes.'
        end
        get do
          conditions = {}
          conditions = conditions.merge(account_id: params[:account_id]) if params[:account_id].present?
          paginate Route, conditions: conditions, with: Presenters::RoutesPresenter
        end

        desc 'Create new route.'
        params do
          requires :route, type: Hash do
            requires :name, type: String
            requires :path, type: String
            requires :account_id, type: Integer
          end
        end
        post do
          create Route, with: Presenters::RoutePresenter, from: permitted_params[:route]
        end

        desc 'Retrieve existing route.'
        params do
          requires :id, desc: 'ID of the route'
        end
        get ':id' do
          route = Route.find params[:id]
          present route, with: Presenters::RoutePresenter
        end

        desc 'Update existing route.'
        params do
          requires :id, type: String, desc: 'Route id.'
          requires :route, type: Hash do
            optional :name, type: String
            optional :path, type: String
            optional :account_id, type: Integer
          end
        end
        patch ':id' do
          route = Route.find params[:id]
          update route, with: Presenters::RoutePresenter, from: permitted_params[:route]
        end

        desc 'Delete existing route.'
        params do
          requires :id, type: String, desc: 'Route id.'
        end
        delete ':id' do
          route = Route.find params[:id]
          delete route, with: Presenters::RoutePresenter
        end
      end
    end
  end
end
