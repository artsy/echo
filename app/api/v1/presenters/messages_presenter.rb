module V1
  module Presenters
    module MessagesPresenter
      include Gris::PaginatedPresenter

      collection :to_a, extend: MessagePresenter, as: :messages, embedded: true
    end
  end
end
