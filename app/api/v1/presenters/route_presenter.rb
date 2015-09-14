module V1
  module Presenters
    module RoutePresenter
      include Gris::Presenter

      property :id, writeable: false, type: String, desc: 'Route unique ID.'
      property :account_id, writeable: true, type: String, desc: 'Route account ID.'
      property :name, writeable: true, type: String, desc: 'Route name.'
      property :path, writeable: true, type: String, desc: 'Route path.'
      property :created_at, writeable: false, type: DateTime, desc: 'Route created timestamp.'
      property :updated_at, writeable: false, type: DateTime, desc: 'Route updated timestamp.'

      link :self do
        "#{Gris::Identity.base_url}/features/#{id}"
      end
    end
  end
end
