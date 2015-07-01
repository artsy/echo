module V1
  module Presenters
    module MessagePresenter
      include Gris::Presenter

      property :id, writeable: false, type: String, desc: 'Message unique ID.'
      property :account_id, writeable: true, type: String, desc: 'Message account ID.'
      property :name, writeable: true, type: String, desc: 'Message name.'
      property :content, writeable: true, type: String, desc: 'Message content.'
      property :created_at, writeable: false, type: DateTime, desc: 'Message created timestamp.'
      property :updated_at, writeable: false, type: DateTime, desc: 'Message updated timestamp.'

      link :self do |opts|
        request = Grape::Request.new(opts[:env])
        "#{request.base_url}/features/#{id}"
      end
    end
  end
end
