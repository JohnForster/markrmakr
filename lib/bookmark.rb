require 'pg'

class Bookmark
  @bookmarks = ['wikipedia.org', 'facebook.com']

  def self.all
    results = connection.exec 'SELECT url FROM bookmarks'
    results.map { |bookmark| bookmark['url'] }
  end

  def self.connection
    PG.connect dbname: 'bookmark_manager', user: 'johnforster'
  end
end
