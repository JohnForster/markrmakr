require 'sinatra'
require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/bookmark.rb'

# The MarkrMakr main app controller.
class MarkrMakr < Sinatra::Base
  enable :sessions
  set :method_override, true # Allows delete and patch in erbs.
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

  get '/marks/:id/edit' do
    @bookmark = Bookmark.find(params['id'])
    erb(:edit_mark)
  end

  delete '/marks/:id' do
    Bookmark.delete(params['id'])
    redirect '/marks'
  end

  patch '/marks/:id' do
    if Bookmark.update(id: params['id'], url: params[:URL], title: params[:title])
      redirect '/marks'
    else
      flash[:notice] = 'Invalid URL!'
      redirect "/marks/#{params['id']}/edit"
    end
  end

  run! if app_file == $PROGRAM_NAME
end
