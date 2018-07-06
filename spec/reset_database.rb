require 'pg'

def reset_database!
  connection = PG.connect dbname: 'bookmark_manager_test'
  connection.exec 'TRUNCATE bookmarks, comments;'
end
