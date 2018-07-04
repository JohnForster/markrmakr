require 'pg'
require 'uri'

# Handles bookmark for the MarkrMakr app.
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

  def self.add(options)
    return false unless url?(options[:url])
    connection.exec "INSERT INTO bookmarks (url) VALUES ('#{options[:url]}');"
  end

  def self.url?(url)
    url =~ /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/
  end
end
