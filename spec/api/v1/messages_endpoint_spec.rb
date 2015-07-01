require 'spec_helper'

describe V1::Endpoints::MessagesEndpoint do
  include Rack::Test::Methods
  include_context 'with a running app and client accessing API V1'

  let(:parent_account) { Fabricate(:account) }

  context 'messages' do
    before(:each) do
      20.times do
        Fabricate(:message)
      end
    end

    it 'returns 10 messages by default' do
      expect(client.messages.count).to eq 10
    end

    it 'returns 2 messages' do
      expect(client.messages(size: 2).count).to eq 2
    end

    it 'returns messages by account_id' do
      message1 = Fabricate(:message, account: parent_account)
      Fabricate(:message)
      messages = client.messages(account_id: parent_account.id)
      expect(messages.count).to eq 1
      expect(messages.first.id).to eq message1.id
    end

    it 'returns pagination' do
      response = client.messages(size: 2, page: 2)
      expect(response._links.next._url).to eq 'http://example.org/messages?page=3&size=2'
      expect(response._links.prev._url).to eq 'http://example.org/messages?page=1&size=2'
      expect(response._links.self._url).to eq 'http://example.org/messages?page=2&size=2'
    end

    it 'returns all unique ids' do
      messages = client.messages
      expect(messages.map(&:id).uniq.count).to eq 10
    end
  end

  context 'message' do
    let(:message_details) do
      {
        name: 'kanyewest_tweet',
        content: "Kim, I'm so happy to be married to the girl of my dreams...I love you and Nori so much!!! I would find you in any lifetime.",
        account_id: parent_account.id
      }
    end
    let(:message1) { Fabricate(:message, attributes: message_details) }

    it 'creates a message' do
      message = client.messages._post(message: message_details)
      expect(message.name).to eq message_details[:name]
      expect(message.content).to eq message_details[:content]
      expect(message.account_id).to eq parent_account.id
    end

    it 'returns a message' do
      message = client.message(id: message1.id)
      expect(message.id).to eq message1.id
      expect(message.name).to eq message_details[:name]
    end

    it 'updates a message' do
      message = client.message(id: message1.id)._patch(message: { name: 'kanyewest_tweet', content: "I would like to publicly apologize to Beck, I'm sorry Beck." })
      expect(message.id).to eq message1.id
      expect(message.name).to eq 'kanyewest_tweet'
      expect(message.content).to eq "I would like to publicly apologize to Beck, I'm sorry Beck."
      expect(message.account_id).to eq message1.account.id
    end

    it 'deletes a message' do
      message = client.message(id: message1.id)._delete
      expect(message.id).to eq message1.id
    end
  end
end
