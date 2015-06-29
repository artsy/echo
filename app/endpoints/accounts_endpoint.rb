class AccountsEndpoint < Grape::API
  namespace :accounts do
    desc 'List existing accounts'
    params do
      optional :page, type: Integer, default: 1, desc: 'Current page.'
      optional :size, type: Integer, default: 10, desc: 'Number of accounts to return per page.'
    end
    get do
      conditions = {}
      accounts = Account.where(conditions)
      present Kaminari.paginate_array(accounts).page(params[:page]).per(params[:size]), with: AccountsPresenter
    end

    desc 'Create new account.'
    params do
      requires :account, type: Hash do
        requires :name, type: String
      end
    end
    post do
      create Account, with: AccountPresenter, from: permitted_params[:account]
    end

    desc 'Retrieve existing account.'
    params do
      requires :id, desc: 'ID of the account'
    end
    get ':id' do
      account = Account.find params[:id]
      present account, with: AccountPresenter
    end

    desc 'Update existing account.'
    params do
      requires :id, type: String, desc: 'Account id.'
      requires :account, type: Hash do
        optional :name, type: String
      end
    end
    patch ':id' do
      account = Account.find params[:id]
      update account, with: AccountPresenter, from: permitted_params[:account]
    end

    desc 'Delete existing account.'
    params do
      requires :id, type: String, desc: 'Account id.'
    end
    delete ':id' do
      account = Account.find params[:id]
      delete account, with: AccountPresenter
    end
  end
end
