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

describe 'MovieItems' do
    it 'should return search title' do
        movie_items = MovieItems.new("Batman")
        expect(movie_items.search_title).to eq("Batman")
    end

    it 'should return a resposne from the API' do
        movie_items = MovieItems.new("Batman")
        movie_items.fetch_items
        movie_items.parse_JSON
        movie_items.add_items
        expect(movie_items.display_items).to eq(nil)
    end
end

# Create 2 tests for movie.rb

# Creates 2 tests for favourites.rb