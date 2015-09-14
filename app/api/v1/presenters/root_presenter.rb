module V1
  module Presenters
    module RootPresenter
      include Gris::Presenter

      link :self do
        Gris::Identity.base_url
      end

      endpoint_link :health

      resource_links :account
      resource_links :feature, [:account_id]
      resource_links :message, [:account_id]
      resource_links :route, [:account_id]
    end
  end
end
