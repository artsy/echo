require 'spec_helper'

describe V2::Endpoints::AccountsEndpoint do
  include Rack::Test::Methods
  include_context 'with a running app and client accessing API V2'

  context 'account' do
    let(:account_details) do
      {
        name: 'the loveliest app'
      }
    end
    let(:account1) { Fabricate(:account, attributes: account_details) }

    it 'returns account' do
      account = client.account(id: account1.id)
      expect(account.id).to eq account1.id
      expect(account.name).to eq account_details[:name]
    end

    it 'returns associated features array' do
      2.times do
        Fabricate(:feature, account: account1)
      end
      account = client.account(id: account1.id)
      expect(account.features.count).to eq 2
    end

    it 'returns associated messages array' do
      2.times do
        Fabricate(:message, account: account1)
      end
      account = client.account(id: account1.id)
      expect(account.messages.count).to eq 2
    end

    it 'returns associated routes array' do
      2.times do
        Fabricate(:route, account: account1)
      end
      account = client.account(id: account1.id)
      expect(account.routes.count).to eq 2
    end
  end
end
