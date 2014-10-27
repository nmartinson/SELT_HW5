require 'rails_helper'
require 'spec_helper'

describe Movie do
  describe 'searching Tmdb by keyword' do    







    before :each do
      @fake_movie = [Tmdb::Movie.new(:original_title => "Hello", :release_date=>'2010-06-06')]
    end
    it 'should call Tmdb with title keywords given valid API key' do
      expect(Tmdb::Movie).to receive(:find).with('Inception')
      Movie.find_in_tmdb('Inception')
    end
    it 'should supply a valid key' do
      expect{Movie.find_in_tmdb('Inception')}.to_not raise_error(Exception)
    end
    it 'should return an empty array if no results were found' do
      Tmdb::Movie.stub(:find).and_return([])
      res = Movie.find_in_tmdb('blahblah')
      expect(res).to eq([])
    end
    it 'should return a nonempty array if results were found' do
      Tmdb::Movie.stub(:find).and_return(@fake_movie)
      res = Movie.find_in_tmdb('blah')
      expect(res.length).to be > 0
    end
  end
end
