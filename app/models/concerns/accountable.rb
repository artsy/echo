module Accountable
  extend ActiveSupport::Concern
  included do
    belongs_to :account, touch: true
    validates :account, presence: true
  end
end
