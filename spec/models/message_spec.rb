require 'spec_helper'

describe Message do
  it 'validates that an account is present' do
    expect(subject).to be_invalid
    expect(subject.errors.messages).to eq(account: ["can't be blank"])
  end
end
