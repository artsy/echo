class Account < ActiveRecord::Base
  validates :name, presence: true
  has_many :features, -> { order(:created_at) }
  has_many :messages, -> { order(:created_at) }
  has_many :routes, -> { order(:created_at) }
end
