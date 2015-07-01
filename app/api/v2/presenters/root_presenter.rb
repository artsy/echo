module V2
  module Presenters
    module RootPresenter
      include Gris::Presenter

      link :self do |opts|
        "#{base_url(opts)}"
      end

      link :account do |opts|
        {
          href: "#{base_url(opts)}/accounts/{id}",
          templated: true
        }
      end

      private

      def base_url(opts)
        request = Grape::Request.new(opts[:env])
        request.base_url
      end
    end
  end
end
