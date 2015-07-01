Fabricator(:route) do
  account { Fabricate(:account) }
  name { 'ARArtistRoute' }
  path { '/artist/:id' }
end
