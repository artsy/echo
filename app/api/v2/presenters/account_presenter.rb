module V2
  module Presenters
    module AccountPresenter
      include Gris::Presenter

      property :id, writeable: false, type: String, desc: 'Account unique ID.'
      property :name, writeable: true, type: String, desc: 'Account name.'
      property :created_at, writeable: false, type: DateTime, desc: 'Account created timestamp.'
      property :updated_at, writeable: false, type: DateTime, desc: 'Account updated timestamp.'

      collection :features, extend: FeaturePresenter, class: Feature
      collection :messages, extend: MessagePresenter, class: Message
      collection :routes, extend: RoutePresenter, class: Route
    end
  end
end
