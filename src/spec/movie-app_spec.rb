require_relative '../user'
require_relative '../movie-items'
require_relative '../movie'
require_relative '../favourites'
system("clear")

describe 'User' do

    # Before running 'User' tests, read user-details.json
    before(:each) do
        user_data = File.read("./lib/user-details.json")
        temp_json = JSON.parse(user_data)
    end

    it 'should return username' do
    user = User.new("Test", "foobar123")
        expect(user.get_username).to eq("Test")
    end

    it 'should return true as username "Test" match is found' do
    user = User.new("Test", "foobar123")
        expect(user.validate_login).to eq(true)
    end
end