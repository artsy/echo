module V1
  module Endpoints
    class FeaturesEndpoint < Grape::API
      namespace :features do
        desc 'List existing features'
        params do
          optional :page, type: Integer, default: 1, desc: 'Current page.'
          optional :size, type: Integer, default: 10, desc: 'Number of features to return per page.'
          optional :account_id, type: Integer, desc: 'Account ID for features.'
        end
        get do
          conditions = {}
          conditions = conditions.merge(account_id: params[:account_id]) if params[:account_id].present?
          paginate Feature, conditions: conditions, with: Presenters::FeaturesPresenter
        end

        desc 'Create new feature.'
        params do
          requires :feature, type: Hash do
            requires :name, type: String
            requires :value, type: String
            requires :account_id, type: Integer
          end
        end
        post do
          create Feature, with: Presenters::FeaturePresenter, from: permitted_params[:feature]
        end

        desc 'Retrieve existing feature.'
        params do
          requires :id, desc: 'ID of the feature'
        end
        get ':id' do
          feature = Feature.find params[:id]
          present feature, with: Presenters::FeaturePresenter
        end

        desc 'Update existing feature.'
        params do
          requires :id, type: String, desc: 'Feature id.'
          requires :feature, type: Hash do
            optional :name, type: String
            optional :value, type: String
            optional :account_id, type: Integer
          end
        end
        patch ':id' do
          feature = Feature.find params[:id]
          update feature, with: Presenters::FeaturePresenter, from: permitted_params[:feature]
        end

        desc 'Delete existing feature.'
        params do
          requires :id, type: String, desc: 'Feature id.'
        end
        delete ':id' do
          feature = Feature.find params[:id]
          delete feature, with: Presenters::FeaturePresenter
        end
      end
    end
  end
end
