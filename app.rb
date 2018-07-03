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

  get '/marks/new' do
    erb(:new_mark)
  end

  post '/marks' do
    Bookmark.add(params[:URL])# add mark to Database
    redirect '/marks'
  end

  run! if app_file == $PROGRAM_NAME
end
