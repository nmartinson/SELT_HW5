class Movie < ActiveRecord::Base

  class Movie::InvalidKeyError < StandardError ; end

  def self.all_ratings
    %w(G PG PG-13 R)
  end

  def self.find_in_tmdb(title)
    begin
     Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
     matching_movies = Tmdb::Movie.find(title)
     @movies = []
     if( matching_movies)
       matching_movies.each do |movie|
          @movies << {:title => movie.title, :release_date => movie.release_date, :rating => "G", :tmdb_id => movie.id}
       end
     end
     rescue NoMethodError => tmdb_gem_exception
        if Tmdb::Api.response['code'] == '401'
           raise Movie::InvalidKeyError, 'Invalid API key'
        else
           raise tmdb_gem_exception
        end
     end
    return @movies
  end

  def self.create_from_tmdb(tmdb_id)
    movie = Tmdb::Movie.detail(tmdb_id)
    movieHash = {:title => "#{movie.title}", :release_date => "#{movie.release_date}", :rating => "G" }
    Movie.create!(movieHash)
  end

end
