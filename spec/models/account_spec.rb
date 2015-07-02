require 'spec_helper'

describe Account do
  it { should validate_presence_of(:name) }
  [:features, :messages, :routes].each do |association|
    it { should have_many(association).order(:created_at) }
  end
end
