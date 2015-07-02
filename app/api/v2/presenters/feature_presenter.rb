module V2
  module Presenters
    module FeaturePresenter
      include Gris::Presenter
      property :name, writeable: true, type: String, desc: 'Feature name.'
      property :value, writeable: true, type: String, desc: 'Feature value.'
    end
  end
end
