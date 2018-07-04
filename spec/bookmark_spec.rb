require_relative '../lib/bookmark.rb'

describe Bookmark do
  describe '.all' do
    it 'should return all bookmarks' do
      connection = PG.connect dbname: 'bookmark_manager_test'
      connection.exec("INSERT INTO bookmarks (url) VALUES('https://website.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('https://fakeblock.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('https://testpage.com');")
      expected_bookmarks = [
        'https://website.com',
        'https://fakeblock.com',
        'https://testpage.com'
      ]
      expect(Bookmark.all).to eq expected_bookmarks
    end
  end

  describe '.add' do
    it 'should add a bookmark to the database' do
      Bookmark.add('https://time.is')
      expect(Bookmark.all).to include 'https://time.is'
    end

    it 'should not create a bookmark if the url is invalid' do
      Bookmark.add('thisisnotabookmark')
      expect(Bookmark.all).not_to include 'thisisnotabookmark'
    end
  end
end
