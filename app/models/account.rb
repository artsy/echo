class Account < ActiveRecord::Base
  validates :name, presence: true
  has_many :features, -> { order(:created_at) }
end
