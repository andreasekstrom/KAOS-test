#!/usr/bin/env ruby

require "sinatra"
require "sinatra/reloader" if development?

enable :sessions

get '/' do
  session[:cart] ||= 0
  @items_in_cart = session[:cart]
  haml :index, :format => :html5
end

get '/login' do
  haml :login, :format => :html5
end

post '/login' do
  puts params[:username]
  session[:username] = params[:username]
  redirect '/pay'
end

get '/add_to_cart' do
  session[:cart] ||= 0
  session[:cart] += 1
  redirect '/'
end

get '/checkout' do
  @items_in_cart = session[:cart]
  haml :checkout, :format => :html5
end

get '/pay' do
  @username = session[:username]
  @items_in_cart = session[:cart]
  haml :pay, :format => :html5
end
