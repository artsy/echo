module V2
  module Presenters
    module RootPresenter
      include Gris::Presenter

      link :self do
        Gris::Identity.base_url
      end

      link :account do
        {
          href: "#{Gris::Identity.base_url}/accounts/{id}",
          templated: true
        }
      end
    end
  end
end
