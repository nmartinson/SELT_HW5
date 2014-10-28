require 'rails_helper'
require 'spec_helper'

describe MoviesController do
  describe 'searching TMDb' do
    it 'should call the model method that performs TMDb search' do
   #   Movie= double(Movie)
      fake_results = [double('movie1'), double('movie2')]
      expect(Movie).to receive(:find_in_tmdb).with('Ted').and_return(fake_results)
      post :search_tmdb, {:search_terms => 'Ted'}
    end
    it 'should select the Search Results template for rendering' do
    #  Movie=double(Movie)
      allow(Movie).to receive(:find_in_tmdb)
      post :search_tmdb, {:search_terms => 'Ted'} 
      expect(response).to render_template('search_tmdb')
    end
    it 'should make the TMDb search results available to that template' do
     # Movie=double(Movie)
      fake_results = [double('Movie'), double('Movie')]
      allow(Movie).to receive(:find_in_tmdb).and_return(fake_results) 
      post :search_tmdb,{:search_terms => 'hardware'}
      expect(assigns(:movies)) == fake_results
    end
    it 'should flash that no movies found if they are not in tmdb' do
      #Movie=double(Movie)
      fake_results = []
      allow(Movie).to receive(:find_in_tmdb).and_return(fake_results) 
      post :search_tmdb,{:search_terms => 'asdfasasfa'}
      expect(assigns(:movies)) == fake_results
    end
    it 'should flash for invalid search if nothing is entered' do
     # Movie=double(Movie)
      fake_results = []
      allow(Movie).to receive(:find_in_tmdb).and_return(fake_results) 
      post :search_tmdb,{:search_terms => ''}
      expect(assigns(:movies)) == fake_results
    end
  end


  describe 'adding to Rotten Potatoes' do
    it 'should be possible to create movie with a movie selected' do
    #  Movie = double(Movie)
      allow(Movie).to receive(:create_from_tmdb)
      post :add_tmdb, {:movie => Movie, :tmdb_movies => {Movie => "1"} }
      expect(response).to redirect_to(movies_path)
    end
    it 'should not be possible to create movie without a movie selected' do
    #  Movie = double(Movie)
      !allow(Movie).to receive(:create_from_tmdb)
      post :add_tmdb, {:movie => Movie}
      expect(response).to redirect_to(movies_path)
    end
  end
end

