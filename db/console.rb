require("pry-byebug")
require_relative("../models/album")
require_relative("../models/artist")

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({ 'name' => 'King Witch' })
artist1.save()

album1 = Album.new({
  "artist_id" => artist1.id,
  "title" => "Shoulders of Giants",
  "genre" => "Metal"
  })
album1.save()

album2 = Album.new({
  "artist_id" => artist1.id,
  "title" => "Under the Mountain",
  "genre" => "Metal"
  })
album2.save()

artist2 = Artist.new({ 'name' => 'Dune' })
artist2.save()

album3 = Album.new({
  "artist_id" => artist2.id,
  "title" => "Progenitor",
  "genre" => "Metal"
  })
album3.save()

album4 = Album.new({
  "artist_id" => artist2.id,
  "title" => "Aurora Majesty",
  "genre" => "Metal"
  })
album4.save()

binding.pry

nil
