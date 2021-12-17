require_relative '../user'
require_relative '../movie-items'
require_relative '../movie'
require_relative '../favourites'
system("clear")

## Each test should:
# - cover a different feature of the application
# - state what is being tested
# - provide at least TWO test cases and the expected results for each test case

# > An outline of the testing procedure and cases should be included with the source code of the application
#spec_helper.rb

# Writes to ./spec/dev/test-output.txt
RSpec.configure do |config|
    original_stdout = $stdout
    config.before(:all) do 
      # Redirect stderr and stdout
      $stdout = File.new(File.join(File.dirname(__FILE__), 'dev', 'test-output.txt'), 'w')
    end
    config.after(:all) do 
      $stdout = original_stdout
    end
  end

describe 'User' do
    # Before running 'User' tests, read user-details.json
    before(:each) do
        user_data = File.read("./lib/user-details.json")
        temp_json = JSON.parse(user_data)
    end

    it 'should return username' do
        user = User.new("Test", "foobar123")
        expect(user.username).to eq("Test")
    end

    it 'should return true as username "Test" match is found' do
        user = User.new("Test", "foobar123")
        expect(user.validate_login).to eq(true)
    end
end

describe 'MovieItems' do ## Modified 2 tests, creating 4 new tests (2x2)
    it 'should return a response from the API' do
        movie_items = MovieItems.new
        search_title = "Batman"
        expect(movie_items.fetch_items(search_title).nil?).to be(false)
    end

    it 'should return an array of movie items' do
        movie_items = MovieItems.new
        search_title = "Batman"
        movie_items.fetch_items(search_title)
        movie_items.add_items
        movie_items.display_items
        expect(movie_items.movie_items.length > 0).to be(true)
    end
end

# Create 2 tests for movie.rb
## 1. Successfully parses the called JSON
    # pass imdb id to fetch items
    # parse the file
    # check to see if the response is not nil

#     describe 'Movie' do
#     it 'should parse the called JSON' do
#         movie = Movie.new("Batman Begins", "tt0372784")
#         movie.fetch_items
        
#     end

#     it 'should initialize movie attributes' do
#         movie = Movie.new("Batman Begins", "tt0372784")
#     end

#     it 'should display movie details' do
#         movie = Movie.new("Batman Begins", "tt0372784")
#         movie.fetch_items
#         movie.parse_JSON
#         expect(movie.display_md).to eq(nil)
#     end
# end

## 2. Displays an output to our terminal
    # pass imdb_id to fetch_items
    # parse it
    # display_md
    # expect the output to eq nil

describe 'Favourites' do
    it 'should succesfully read favourites from favourites.json' do
        # Check to see if there's an entry at index 0
    end

## 2. Retrieves favourites
    # should run without error (return nil)
end
