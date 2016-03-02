require 'sinatra'
require 'csv'
require_relative "app/models/television_show"

set :views, File.join(File.dirname(__FILE__), "app/views")

get '/' do
erb: homepage
end

get '/television_shows' do
  @data = CSV.readlines('television-shows.csv', headers: true)
  erb :index
end

post '/television_shows' do

  @title = params['title']
  @network = params['network']
  @starting_year = params['starting_year']
  @synopsis = params['synopsis']
  @genre = params['genre']

  CSV.open("television-shows.csv", "a") do |csv|
    csv << [@title, @network, @starting_year, @synopsis, @genre]
  end
  redirect '/television_shows'
end

get '/television_shows/new' do
  erb :new
end
