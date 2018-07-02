require 'sinatra/base'
require_relative './lib/bookmark.rb'

class MarkrMakr < Sinatra::Base
  get '/' do
    erb(:index)
  end

  get '/marks' do
    @marks = Bookmark.all
    erb(:marks)
  end

  run! if app_file == $PROGRAM_NAME
end
