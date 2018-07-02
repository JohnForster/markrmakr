require_relative '../lib/bookmark.rb'

describe Bookmark do
  describe '.all' do
    it 'should return all bookmarks' do
      expect(Bookmark.all).to be_an Array
    end
  end
end
