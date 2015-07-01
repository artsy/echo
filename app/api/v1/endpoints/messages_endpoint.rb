module V1
  module Endpoints
    class MessagesEndpoint < Grape::API
      namespace :messages do
        desc 'List existing messages'
        params do
          optional :page, type: Integer, default: 1, desc: 'Current page.'
          optional :size, type: Integer, default: 10, desc: 'Number of messages to return per page.'
          optional :account_id, type: Integer, desc: 'Account ID for messages.'
        end
        get do
          conditions = {}
          conditions = conditions.merge(account_id: params[:account_id]) if params[:account_id].present?
          messages = Message.where(conditions)
          present Kaminari.paginate_array(messages).page(params[:page]).per(params[:size]), with: Presenters::MessagesPresenter
        end

        desc 'Create new message.'
        params do
          requires :message, type: Hash do
            requires :name, type: String
            requires :content, type: String
            requires :account_id, type: Integer
          end
        end
        post do
          create Message, with: Presenters::MessagePresenter, from: permitted_params[:message]
        end

        desc 'Retrieve existing message.'
        params do
          requires :id, desc: 'ID of the message'
        end
        get ':id' do
          message = Message.find params[:id]
          present message, with: Presenters::MessagePresenter
        end

        desc 'Update existing message.'
        params do
          requires :id, type: String, desc: 'Message id.'
          requires :message, type: Hash do
            optional :name, type: String
            optional :content, type: String
            optional :account_id, type: Integer
          end
        end
        patch ':id' do
          message = Message.find params[:id]
          update message, with: Presenters::MessagePresenter, from: permitted_params[:message]
        end

        desc 'Delete existing message.'
        params do
          requires :id, type: String, desc: 'Message id.'
        end
        delete ':id' do
          message = Message.find params[:id]
          delete message, with: Presenters::MessagePresenter
        end
      end
    end
  end
end
