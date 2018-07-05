require 'pg'
require 'uri'

# Handles bookmark for the MarkrMakr app.
class Bookmark
  attr_reader :id, :title, :url
  DATABASE = 'bookmark_manager'.freeze
  TEST_DATABASE = 'bookmark_manager_test'.freeze

  private

  def initialize(args)
    @title = args[:title]
    @url = args[:url]
    @id = args[:id].to_i
  end

  public

  def self.add(options)
    return false unless url?(options[:url])
    return_array = connection.exec(
      "INSERT INTO bookmarks (url, title)
       VALUES ('#{options[:url]}', '#{options[:title]}')
       RETURNING id;"
    ) # This returns [{"id" => "123"}]
    id = return_array[0]['id']
    Bookmark.new(url: options[:url], title: options[:title], id: id)
  end

  def self.all
    results = connection.exec 'SELECT * FROM bookmarks'
    results.map do |mark|
      Bookmark.new(title: mark['title'], url: mark['url'], id: mark['id'])
    end
  end

  def self.connection
    PG.connect(dbname: dbname)
  end

  def self.dbname
    ENV['ENVIRONMENT'] == 'test' ? TEST_DATABASE : DATABASE
  end

  def self.url?(url)
    url =~ /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/
  end

  def self.find(id)
    mark = connection.exec(
      "SELECT title, url, id FROM bookmarks
       WHERE id = #{id};"
    ) # returns [{title: "title", url: "url", id: "id"}]
    mark = mark.first
    Bookmark.new(title: mark['title'], url: mark['url'], id: mark['id'])
  end

  def self.delete(id)
    connection.exec(
      "DELETE FROM bookmarks
       WHERE id = #{id};"
    )
  end

  def self.update(args)
    return false unless url?(args[:url])
    connection.exec(
      "UPDATE bookmarks
       SET title = '#{args[:title]}', url = '#{args[:url]}'
       WHERE id = #{args[:id]};"
    )
    Bookmark.new(title: args[:title], url: args[:url], id: args[:id])
  end

  def ==(other)
    @id == other.id
  end
end
