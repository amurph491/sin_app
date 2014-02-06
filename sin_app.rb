require 'sinatra'
require 'sinatra/activerecord'
require 'json'

set :database, "sqlite3:///temp.sqlite3"

class TempRecording < ActiveRecord::Base
	validates_presence_of :temp
end

get '/' do
	@temps = TempRecording.all
	erb :index
end

get '/r' do
	TempRecording.last[:temp]
end

get '/series' do
	s = TempRecording.find(:all, :order => "id desc", :limit => 30).reverse
	s.map! {|t| t[:temp]}
	s.to_json
end

post '/' do
	temp = TempRecording.create(temp: params[:temp])
	temp[:temp]
end

get '/clear' do
	TempRecording.delete_all
	redirect to('/')
end