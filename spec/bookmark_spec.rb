require_relative '../lib/bookmark.rb'

describe Bookmark do
  describe '.all' do
    it 'should return all bookmarks' do
      mark1 = Bookmark.add(title: 'Tumblr', url: 'https://tumblr.com')
      mark2 = Bookmark.add(title: 'MarkrMakr', url: 'https://markrmakr.com')
      expect(Bookmark.all).to include mark1
      expect(Bookmark.all).to include mark2
    end
  end

  describe '.add' do
    it 'should add a bookmark to the database' do
      bookmark1 = Bookmark.add(url: 'https://time.is', title: 'Time.is')
      expect(Bookmark.all).to include bookmark1
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
