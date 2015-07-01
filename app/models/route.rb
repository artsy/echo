class Route < ActiveRecord::Base
  belongs_to :account
  validates :account, presence: true
end
