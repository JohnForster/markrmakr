require_relative '../lib/comment.rb'
require_relative '../lib/bookmark.rb'

describe Comment do
  describe '.add/.all' do
    it 'should add comments to the database' do
      mk1 = Bookmark.add(title: 'Twitter', url: 'https://twitter.com')
      comment1 = Comment.add(bookmark_id: mk1.id, text: 'My favourite website!')
      comment2 = Comment.add(bookmark_id: mk1.id, text: 'This webiste great!')
      expect(Comment.all(bookmark_id: mk1.id)).to include comment1
      expect(Comment.all(bookmark_id: mk1.id)).to include comment2
    end
  end
end
