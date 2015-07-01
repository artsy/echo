module V1
  module Presenters
    module FeaturePresenter
      include Gris::Presenter

      property :id, writeable: false, type: String, desc: 'Feature unique ID.'
      property :account_id, writeable: true, type: String, desc: 'Feature account ID.'
      property :name, writeable: true, type: String, desc: 'Feature name.'
      property :value, writeable: true, type: String, desc: 'Feature value.'
      property :created_at, writeable: false, type: DateTime, desc: 'Feature created timestamp.'
      property :updated_at, writeable: false, type: DateTime, desc: 'Feature updated timestamp.'

      link :self do |opts|
        request = Grape::Request.new(opts[:env])
        "#{request.base_url}/features/#{id}"
      end
    end
  end
end
