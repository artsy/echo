module V2
  module Endpoints
    class AccountsEndpoint < Grape::API
      namespace :accounts do
        desc 'Retrieve an existing account.'
        params do
          requires :id, desc: 'ID of the account'
        end
        get ':id' do
          account = Account.find params[:id]
          header 'Updated-At', account.updated_at.to_s
          present account, with: Presenters::AccountPresenter
        end
      end
    end
  end
end
