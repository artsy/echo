class Feature < ActiveRecord::Base
  belongs_to :account
  validates :account, presence: true
end
