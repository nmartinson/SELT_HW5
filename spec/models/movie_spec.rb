require 'rails_helper'
require 'spec_helper'

describe Movie do
  describe 'searching Tmdb by keyword' do    
    before :each do
      @movie = [Tmdb::Movie.new(:original_title => "Hi", :release_date=> '2010-07-09')]
      @addMovie = {:title => "Billy", :release_date => "2010-07-09", :rating => "G" }
      @movieID = '2343'
    end  
    context 'with validkey' do
      it 'should call Tmdb with title keywords' do
        expect(Tmdb::Movie).to receive(:find).with('Inception')
        Movie.find_in_tmdb('Inception')
      end
    end
    context 'with invalid key' do
      it 'should raise invalidKeyError if key is missing or invalid' do
        allow(Tmdb::Movie).to receive(:find).and_raise(NoMethodError)
        allow(Tmdb::Api).to receive(:response).and_return({'code' => '401'})
        expect {Movie.find_in_tmdb('Inception')}.to raise_error(Movie::InvalidKeyError)
      end
    end
    it 'should call tmdb with real method' do
       allow(Tmdb::Movie).to receive(:find).and_return([])
       res = Movie.find_in_tmdb('blah')
       expect(res).to eq([])
    end
    it 'should return a nonempty array if results are found' do
      allow(Tmdb::Movie).to receive(:find).and_return(@movie)
      res = Movie.find_in_tmdb('blah')
      expect(res.length).to be > 0
    end
    it 'should create a movie in the database' do

      Movie.create_from_tmdb(@movieID) 
      expect(Movie.where(:id => "#{@movieID}").count > 0)
    end
  end
end






 
