require 'data_mapper'
require 'rubygems'
require 'sinatra'
require 'json'
require 'Date'

env = ENV['RACK_ENV'] || 'development'

# we're telling datamapper to use a postgres database on localhost. The name will be "bookmark_manager_test" or "bookmark_manager_development" depending on the environment
DataMapper.setup(:default, "postgres://localhost/toDoJavascript_#{env}")

require './task' # this needs to be done after datamapper is initialised

# After declaring your models, you should finalise them
DataMapper.finalize

# However, the database tables don't exist yet. Let's tell datamapper to create them
DataMapper.auto_upgrade!

before do
  content_type 'application/json'
end

get '/' do
  content_type 'html'

  @tasks = Task.all
  
  erb :index
end
