require 'spec_helper'

describe V1::Endpoints::RoutesEndpoint do
  include Rack::Test::Methods
  include_context 'with a running app and client accessing API V1'

  let(:parent_account) { Fabricate(:account) }

  context 'routes' do
    before(:each) do
      20.times do
        Fabricate(:route)
      end
    end

    it 'returns 10 routes by default' do
      expect(client.routes.count).to eq 10
    end

    it 'returns 2 routes' do
      expect(client.routes(size: 2).count).to eq 2
    end

    it 'returns routes by account_id' do
      route1 = Fabricate(:route, account: parent_account)
      Fabricate(:route)
      routes = client.routes(account_id: parent_account.id)
      expect(routes.count).to eq 1
      expect(routes.first.id).to eq route1.id
    end

    it 'returns pagination' do
      response = client.routes(size: 2, page: 2)
      expect(response._links.next._url).to eq 'http://example.org/routes?page=3&size=2'
      expect(response._links.prev._url).to eq 'http://example.org/routes?page=1&size=2'
      expect(response._links.self._url).to eq 'http://example.org/routes?page=2&size=2'
    end

    it 'returns all unique ids' do
      routes = client.routes
      expect(routes.map(&:id).uniq.count).to eq 10
    end
  end

  context 'route' do
    let(:route_details) do
      {
        name: 'KanyeWestTweet',
        path: "Fame is often looked down upon in the design world, so it's actually been something I had to overcome.",
        account_id: parent_account.id
      }
    end
    let(:route1) { Fabricate(:route, attributes: route_details) }

    it 'creates a route' do
      route = client.routes._post(route: route_details)
      expect(route.name).to eq route_details[:name]
      expect(route.path).to eq route_details[:path]
      expect(route.account_id).to eq parent_account.id
    end

    it 'returns a route' do
      route = client.route(id: route1.id)
      expect(route.id).to eq route1.id
      expect(route.name).to eq route_details[:name]
    end

    it 'updates a route' do
      route = client.route(id: route1.id)._patch(route: { name: 'KanyeWestTweets', path: "I don't call myself a designer as I was not allowed to go to Saint Martins" })
      expect(route.id).to eq route1.id
      expect(route.name).to eq 'KanyeWestTweets'
      expect(route.path).to eq "I don't call myself a designer as I was not allowed to go to Saint Martins"
      expect(route.account_id).to eq route1.account.id
    end

    it 'deletes a route' do
      route = client.route(id: route1.id)._delete
      expect(route.id).to eq route1.id
    end
  end
end
