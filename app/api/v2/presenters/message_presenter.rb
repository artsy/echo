module V2
  module Presenters
    module MessagePresenter
      include Gris::Presenter
      property :name, writeable: true, type: String, desc: 'Message name.'
      property :content, writeable: true, type: String, desc: 'Message content.'
    end
  end
end
