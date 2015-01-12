require 'data_mapper'
require 'Date'
require 'rubygems'
require 'sinatra'
require 'json'


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
  erb :index
end

get '/tasks' do
  @tasks = Task.all
  @tasks.to_json
end

post '/tasks/new' do
  @task = Task.new
  @task.complete = false
  @task.description = params[:description]
  @task.created_at = DateTime.now
  @task.updated_at = nil
end

put '/tasks/:id' do
  @task = Task.find(params[:id])
  @task.complete = params[:complete]
  @task.description = params[:description]
  @task.updated_at = DateTime.now
  if @task.save
    {task: @task, status: 'success'}.to_json
  else
    {task: @task, status: 'failure'}.to_json
  end
end

delete '/tasks/:id' do
  @task = Task.find(params[:id])
  if @task.destroy
    {task: @task, status: 'success'}.to_json
  else
    {task: @task, status: 'failure'}.to_json
  end
end
