require 'pg'
require 'uri'

# Handles comments for the MarkrMakr app.
class Comment
  attr_reader :comment_id, :bookmark_id, :text
  DATABASE = 'bookmark_manager'.freeze
  TEST_DATABASE = 'bookmark_manager_test'.freeze

  private

  def initialize(args)
    @comment_id = args[:comment_id]
    @bookmark_id = args[:bookmark_id]
    @text = args[:text]
  end

  public

  def self.add(args)
    results = connection.exec(
      "INSERT INTO comments (bookmark_id, text)
       VALUES ('#{args[:bookmark_id]}', '#{args[:text]}')
       RETURNING comment_id;"
    )
    Comment.new(
      comment_id: results[0]['comment_id'],
      bookmark_id: args[:bookmark_id],
      text: args[:text]
    )
  end

  def self.all(args)
    results = search_by(id: args[:bookmark_id])
    results.map do |comment|
      Comment.new(
        comment_id: comment['comment_id'],
        bookmark_id: comment['bookmark_id'],
        text: comment['text']
      )
    end
  end

  def self.connection
    PG.connect(dbname: dbname)
  end

  def self.dbname
    ENV['ENVIRONMENT'] == 'test' ? TEST_DATABASE : DATABASE
  end

  def self.search_by(args)
    connection.exec(
      "SELECT * FROM comments
       WHERE bookmark_id = #{args[:id]};"
    )
  end

  def ==(other)
    @comment_id == other.comment_id
  end
end
