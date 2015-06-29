module FeaturesPresenter
  include Gris::PaginatedPresenter

  collection :to_a, extend: FeaturePresenter, as: :features, embedded: true
end
