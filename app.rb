require 'sinatra/base'
require_relative './lib/bookmark.rb'

# The MarkrMakr main app controller.
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
    flash[:notice] = 'Invalid URL!' unless Bookmark.add(params[:URL])
    redirect '/marks'
  end

  run! if app_file == $PROGRAM_NAME
end
