module V2
  module Presenters
    module RoutePresenter
      include Gris::Presenter
      property :name, writeable: true, type: String, desc: 'Route name.'
      property :path, writeable: true, type: String, desc: 'Route path.'
    end
  end
end
