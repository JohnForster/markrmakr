require 'pg'
require 'uri'

# Handles bookmark for the MarkrMakr app.
class Bookmark
  attr_reader :id, :title, :url

  def self.all
    results = connection.exec 'SELECT title FROM bookmarks'
    results.map { |bookmark| bookmark['title'] }
  end

  def self.connection
    PG.connect dbname: dbname
  end

  def self.dbname
    ENV['ENVIRONMENT'] == 'test' ? 'bookmark_manager_test' : 'bookmark_manager'
  end

  def self.add(options)
    return false unless url?(options[:url])
    return_array = connection.exec(
      "INSERT INTO bookmarks (url, title)
       VALUES ('#{options[:url]}', '#{options[:title]}')
       RETURNING id;"
    ) # This returns [{"id" => "123"}]
    id = return_array[0]['id'].to_i
    Bookmark.new(url: options[:url], title: options[:title], id: id)
  end

  def self.url?(url)
    url =~ /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/
  end

  private

  def initialize(args)
    @title = args[:title]
    @url = args[:url]
    @id = args[:id]
  end
end
