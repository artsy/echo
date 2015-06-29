module AccountsPresenter
  include Gris::PaginatedPresenter

  collection :to_a, extend: AccountPresenter, as: :accounts, embedded: true
end
