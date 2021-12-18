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
      # Redirect stdout
      $stdout = File.new(File.join(File.dirname(__FILE__), 'dev', 'test-output.txt'), 'w')
    end
    config.after(:all) do 
      $stdout = original_stdout
    end
  end

  # Tests to check if login feature works correctly
describe User do
    before(:each) do # Before running 'User' tests, read user-details.json
        user_data = File.read("./lib/user-details.json")
        temp_json = JSON.parse(user_data)
    end

    it 'should return username "Test"' do
        user = User.new("Test", "foobar123")
        expect(user.username).to eq("Test")
    end

    it 'should return true as username "Test" match is a valid login' do
        user = User.new("Test", "foobar123")
        expect(user.validate_login).to eq(true)
    end
end

# Tests to check if search feature works correctly (pulling list of movies)
describe MovieItems do 
    it 'should return a response from the movie-items API endpoint' do
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

# Carries on from search feature, but tests to see if 2nd endpoint works correctly
# And displays appropriate information (specific as opposed to generalised)
describe Movie do
    it 'should initialize the Movie attributes from MovieItems' do
        movie_items = MovieItems.new
        search_title = "Batman" # Represents tty-prompt user choice
        movie_items.fetch_items(search_title)
        movie_items.add_items
        selected_movie = "Batman Begins" # Represents tty-prompt user choice
        imdb_id = movie_items.get_imdbID
        movie = Movie.new(selected_movie, imdb_id)
        expect(movie.selected_movie).to eq("Batman Begins")
    end

    it 'should return a response from the IMDB API (movie) endpoint' do
        movie = Movie.new("Batman Begins", "tt0372784")
        expect(movie.fetch_items.nil?).to eq(false)
    end

    it 'should display movie details to the terminal' do
        movie = Movie.new("Batman Begins", "tt0372784")
        movie.fetch_items
        expect(movie.display_md).to eq(nil)
    end
end

# Checks to see if Favourites can return favourites & read/write to .JSON
describe Favourites do
    # This test will fail if the user "Ashley" is deleted!
    it 'should successfuly return first entry favourites entry for "Ashley"' do
        favourite = Favourites.new("Ashley", "Batman Begins", "tt0372784")
        favourite.parse_JSON
        favourite.display_favourites # Assigns values from JSON into favourites_arr
        expect(favourite.favourites_arr[0].nil?).to eq(false)
    end

    it 'should successfully write to favourites.json' do 
        # Repeats twice as otherwise won't write/clear entry correctly
        2.times do 
            favourite = Favourites.new("Admin", "Batman Begins", "tt0372784")
            favourite.parse_JSON
            expect(favourite.save_favourite).to eq(nil)
            favourite.clear("Skip")
        end
    end

    it 'should successfully read from favourites.json' do
        favourite = Favourites.new("Ashley", "Batman Begins", "tt0372784")
        expect(favourite.parse_JSON.nil?).to eq(false)
    end
end
