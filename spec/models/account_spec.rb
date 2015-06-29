require 'spec_helper'

describe Account do
  it 'validates that a name is present' do
    expect(subject).to be_invalid
    expect(subject.errors.messages).to eq(name: ["can't be blank"])
  end
end
