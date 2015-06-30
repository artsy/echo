require 'spec_helper'

describe V1::Endpoints::AccountsEndpoint do
  include Rack::Test::Methods
  include_context 'with a running app and client accessing API V1'

  context 'accounts' do
    before(:each) do
      20.times do
        Fabricate(:account)
      end
    end

    it 'returns 10 accounts by default' do
      expect(client.accounts.count).to eq 10
    end

    it 'returns 2 accounts' do
      expect(client.accounts(size: 2).count).to eq 2
    end

    it 'returns pagination' do
      response = client.accounts(size: 2, page: 2)
      expect(response._links.next._url).to eq 'http://example.org/accounts?page=3&size=2'
      expect(response._links.prev._url).to eq 'http://example.org/accounts?page=1&size=2'
      expect(response._links.self._url).to eq 'http://example.org/accounts?page=2&size=2'
    end

    it 'returns all unique ids' do
      accounts = client.accounts
      expect(accounts.map(&:id).uniq.count).to eq 10
    end
  end

  context 'account' do
    let(:account_details) do
      {
        name: 'the loveliest app'
      }
    end
    let(:account1) { Fabricate(:account, attributes: account_details) }

    it 'creates account' do
      account = client.accounts._post(account: account_details)
      expect(account.name).to eq account_details[:name]
    end

    it 'returns account' do
      account = client.account(id: account1.id)
      expect(account.id).to eq account1.id
      expect(account.name).to eq account_details[:name]
    end

    it 'returns associated features' do
      Fabricate(:feature, account: account1)
      Fabricate(:feature, account: account1)
      account = client.account(id: account1.id)
      expect(account.features.count).to eq 2
    end

    it 'updates account' do
      account = client.account(id: account1.id)._patch(account: { name: 'the most loveliest app' })
      expect(account.id).to eq account1.id
      expect(account.name).to eq 'the most loveliest app'
    end

    it 'deletes account' do
      account = client.account(id: account1.id)._delete
      expect(account.id).to eq account1.id
    end
  end
end
