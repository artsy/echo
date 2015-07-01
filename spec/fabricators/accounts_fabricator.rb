Fabricator(:account) do
  name Fabricate.sequence(:name) { |i| "My awesome app #{i}" }
end
