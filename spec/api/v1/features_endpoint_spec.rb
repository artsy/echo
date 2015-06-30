require 'spec_helper'

describe V1::Endpoints::FeaturesEndpoint do
  include Rack::Test::Methods
  include_context 'with a running app and client accessing API V1'

  let(:parent_account) { Fabricate(:account) }

  context 'features' do
    before(:each) do
      20.times do
        Fabricate(:feature)
      end
    end

    it 'returns 10 features by default' do
      expect(client.features.count).to eq 10
    end

    it 'returns 2 features' do
      expect(client.features(size: 2).count).to eq 2
    end

    it 'returns features by account_id' do
      feature1 = Fabricate(:feature, account: parent_account)
      Fabricate(:feature)
      features = client.features(account_id: parent_account.id)
      expect(features.count).to eq 1
      expect(features.first.id).to eq feature1.id
    end

    it 'returns pagination' do
      response = client.features(size: 2, page: 2)
      expect(response._links.next._url).to eq 'http://example.org/features?page=3&size=2'
      expect(response._links.prev._url).to eq 'http://example.org/features?page=1&size=2'
      expect(response._links.self._url).to eq 'http://example.org/features?page=2&size=2'
    end

    it 'returns all unique ids' do
      features = client.features
      expect(features.map(&:id).uniq.count).to eq 10
    end
  end

  context 'feature' do
    let(:feature_details) do
      {
        name: 'allow_a_user_to_sign_out',
        value: false,
        account_id: parent_account.id
      }
    end
    let(:feature1) { Fabricate(:feature, attributes: feature_details) }

    it 'creates a feature' do
      feature = client.features._post(feature: feature_details)
      expect(feature.name).to eq feature_details[:name]
      expect(feature.value).to eq feature_details[:value]
      expect(feature.account_id).to eq parent_account.id
    end

    it 'returns a feature' do
      feature = client.feature(id: feature1.id)
      expect(feature.id).to eq feature1.id
      expect(feature.name).to eq feature_details[:name]
    end

    it 'updates a feature' do
      feature = client.feature(id: feature1.id)._patch(feature: { name: 'dont_allow_a_user_to_sign_out', value: true })
      expect(feature.id).to eq feature1.id
      expect(feature.name).to eq 'dont_allow_a_user_to_sign_out'
      expect(feature.value).to eq true
      expect(feature.account_id).to eq feature1.account.id
    end

    it 'deletes a feature' do
      feature = client.feature(id: feature1.id)._delete
      expect(feature.id).to eq feature1.id
    end
  end
end
