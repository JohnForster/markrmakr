require 'sinatra'
require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/bookmark.rb'

# The MarkrMakr main app controller.
class MarkrMakr < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

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
    if Bookmark.add(url: params[:URL], title: params[:title])
      redirect '/marks'
    else
      flash[:notice] = 'Invalid URL!'
      redirect '/marks/new'
    end
  end

  run! if app_file == $PROGRAM_NAME
end
