# frozen_string_literal: true

require 'sinatra'
set :raise_errors, false
set :dump_errors, false
set :show_exceptions, false

post '/' do
  Dial::Manager.new(request.body.read).process
end
