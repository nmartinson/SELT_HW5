class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 R)
  end

  def self.find_in_tmdb(title)
    matching_movies = Tmdb::Movie.find(title)
    @movies = []
    matching_movies.each do |movie|
      @movies << {:title => movie.title, :release_date => movie.release_date, :rating => "G", :tmdb_id => movie.id}    
    end
    return @movies
  end

  def self.create_from_tmdb(tmdb_id)
    movie = Tmdb::Movie.detail(tmdb_id)
    movieHash = {:title => "#{movie.title}", :release_date => "#{movie.release_date}", :rating => "G" }
    Movie.create!(movieHash)
  end

end
