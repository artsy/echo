Fabricator(:message) do
  account { Fabricate(:account) }
  name Fabricate.sequence(:name) { |i| "Message name #{i}" }
  content { 'Message content goes here.' }
end
