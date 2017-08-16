require('pg')
require_relative('../db/sql_runner')

class Album

  attr_accessor(:title, :genre)
  attr_reader(:id, :artist_id)

  def initialize( album_details )
    @artist_id = album_details['artist_id']
    @title = album_details['title']
    @genre = album_details['genre']
    @id = album_details['id'].to_i() if album_details['id']
  end

  def artist()
    sql = '
      SELECT * FROM artist
      WHERE id = $1;'
    artist_hashes = SqlRunner.run(sql, [@artist_id])

    artists = artist_hashes.map do |artist_hash|
      Artist.new(artist_hash)
    end
  end

  def save()
    sql = 'INSERT INTO album (
    artist_id,
    title,
    genre
    ) VALUES (
    $1, $2, $3
    )
    RETURNING *;'
    values = [@artist_id, @title, @genre]
    results = SqlRunner.run(sql, values)
    @id = results[0]['id'].to_i()
  end

  def Album.all
    sql = 'SELECT * FROM album;'
    results = SqlRunner.run(sql)
    albums = results.map {|albums_hash| Album.new(albums_hash)}
    return albums
  end

  def Album.delete_all()
    sql = 'DELETE FROM album;'
    SqlRunner.run(sql)
  end



end
