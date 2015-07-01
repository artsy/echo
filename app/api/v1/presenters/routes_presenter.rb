module V1
  module Presenters
    module RoutesPresenter
      include Gris::PaginatedPresenter

      collection :to_a, extend: RoutePresenter, as: :routes, embedded: true
    end
  end
end
