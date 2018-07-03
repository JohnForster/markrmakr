require_relative '../lib/bookmark.rb'

describe Bookmark do
  describe '.all' do
    it 'should return all bookmarks' do
      connection = PG.connect dbname: 'bookmark_manager_test'
      connection.exec("INSERT INTO bookmarks (url) VALUES('website.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('fakeblock.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('testpage.com');")
      expected_bookmarks = [
        'website.com',
        'fakeblock.com',
        'testpage.com'
      ]
      expect(Bookmark.all).to eq expected_bookmarks
    end
  end
end
