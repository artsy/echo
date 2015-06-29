module RootPresenter
  include Gris::Presenter

  link :self do |opts|
    "#{base_url(opts)}"
  end

  link :health do |opts|
    { href: "#{base_url(opts)}/health" }
  end

  # Additional endpoint links

  link :accounts do |opts|
    {
      href: "#{base_url(opts)}/accounts{?page,size}",
      templated: true
    }
  end

  link :account do |opts|
    {
      href: "#{base_url(opts)}/accounts/{id}",
      templated: true
    }
  end

  link :features do |opts|
    {
      href: "#{base_url(opts)}/features{?page,size,account_id}",
      templated: true
    }
  end

  link :feature do |opts|
    {
      href: "#{base_url(opts)}/features/{id}",
      templated: true
    }
  end

  private

  def base_url(opts)
    request = Grape::Request.new(opts[:env])
    request.base_url
  end
end
