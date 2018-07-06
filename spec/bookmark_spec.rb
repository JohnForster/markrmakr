require_relative '../lib/bookmark.rb'

# Class for wrapping bookmarks and interacting with bookmark database.
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
      not_a_bookmark = Bookmark.add(url: 'thisisnotabookmark', title: 'notavalidtitle')
      expect(Bookmark.all).not_to include not_a_bookmark
    end
  end

  describe '#id' do
    it 'should return the id of the bookmark' do
      bookmark = Bookmark.add(url: 'https://coolors.co', title: 'Coolors')
      expect(bookmark.id).to be_an Integer
    end
  end

  describe '.delete' do
    it 'should delete the given bookmark' do
      bookmark2 = Bookmark.add(url: 'https://bbc.co.uk', title: 'BBC')
      Bookmark.delete(bookmark2.id)
      expect(Bookmark.all).not_to include bookmark2
    end
  end

  describe '.find' do
    it 'should find a bookmark by id' do
      bookmark3 = Bookmark.add(url: 'https://facebook.com', title: 'Facebook')
      expect(Bookmark.find(bookmark3.id)).to eq bookmark3
    end
  end

  describe '.update' do
    it 'should edit a bookmark by id, changing its title/url' do
      bookmark4 = Bookmark.add(url: 'https://markrmakr.com', title: 'Markers')
      bookmark4 = Bookmark.update(id: bookmark4.id, title:'MarkrMakr', url: 'https://markrmakr.com')
      expect(bookmark4.title).to eq 'MarkrMakr'
    end
  end
end
