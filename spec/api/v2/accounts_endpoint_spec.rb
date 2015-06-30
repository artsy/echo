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

    it 'does not return a link to associated features' do
      account = client.account(id: account1.id)
      expect(account.try(:features)).to be_nil
    end
  end
end
