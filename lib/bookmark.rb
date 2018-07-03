require 'pg'

class Bookmark

  def self.all
    results = connection.exec 'SELECT url FROM bookmarks'
    results.map { |bookmark| bookmark['url'] }
  end

  def self.connection
    PG.connect dbname: dbname
  end

  def self.dbname
    ENV['ENVIRONMENT'] == 'test' ? 'bookmark_manager_test' : 'bookmark_manager'
  end

  def self.add(url)
    connection.exec "INSERT INTO bookmarks (url) VALUES ('#{url}');"
  end
end
