Fabricator(:feature) do
  account { Fabricate(:account) }
  name Fabricate.sequence(:name) { |i| "My awesome feature #{i}" }
  value { true }
end
