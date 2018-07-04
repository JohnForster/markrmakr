require_relative '../lib/bookmark.rb'

describe Bookmark do
  describe '.all' do
    it 'should return all bookmarks' do
      connection = PG.connect dbname: 'bookmark_manager_test'
      connection.exec("INSERT INTO bookmarks (url, title) VALUES('https://website.com', 'Website');")
      connection.exec("INSERT INTO bookmarks (url, title) VALUES('https://fakeblock.com', 'FakeBlock');")
      connection.exec("INSERT INTO bookmarks (url, title) VALUES('https://testpage.com', 'TestPage');")
      expect(Bookmark.all).to be_an Array
    end
  end

  describe '.add' do
    it 'should add a bookmark to the database' do
      Bookmark.add(url: 'https://time.is', title: 'Time.is')
      expect(Bookmark.all).to include 'Time.is'
    end

    it 'should not create a bookmark if the url is invalid' do
      Bookmark.add(url: 'thisisnotabookmark', title: 'notavalidtitle')
      expect(Bookmark.all).not_to include 'thisisnotabookmark'
    end
  end

  describe '#id' do
    it 'should return the id of the bookmark' do
      bookmark = Bookmark.add(url: 'https://coolors.co', title: 'Coolors')
      expect(bookmark.id).to be_an Integer
    end
  end
end
