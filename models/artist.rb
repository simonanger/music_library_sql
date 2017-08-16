require('pg')
require_relative('../db/sql_runner')


class Artist

  attr_accessor(:name)
  attr_reader(:id)

    def initialize( params )
      @id = params['id'].to_i() if params['id']
      @name = params['name']
    end

    def albums()
      sql = '
        SELECT * FROM album
        WHERE artist_id = $1;'
      album_hashes = SqlRunner.run(sql, [@id])

      albums = album_hashes.map do |album_hash|
        Album.new(album_hash)
      end
    end

    def save()
      sql = 'INSERT INTO artist (
      name
      ) VALUES (
      $1
      )
      RETURNING *;'
      values = [@name]
      results = SqlRunner.run(sql, values)
      @id = results[0]['id'].to_i()
    end
    # Why won't this work?!?!
    def update()
      sql = '
      UPDATE artist SET(
      name
      ) = (
      $1
      )
      WHERE id = $2;'
      values = [@name, @id]
      SqlRunner.run(sql, values)
    end

    def Artist.all
      sql = 'SELECT * FROM artist;'
      results = SqlRunner.run(sql)
      artists = results.map {|artist_hash| Artist.new(artist_hash)}
      return artists
    end

    def Artist.delete_all()
      sql = 'DELETE FROM artist;'
      SqlRunner.run(sql)
    end

end
