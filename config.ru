# frozen_string_literal: true

require 'sinatra'
require 'dotenv'

environment = ENV['RACK_ENV'] || 'development'
Dotenv.load("config/#{environment}.env")

require 'sinatra/activerecord'
require 'byebug'
require 'redis'
require 'rubocop'
require 'faraday'
require 'phonelib'
require 'date'

disable :run, :reload

configure do
  uri = URI.parse(ENV['REDIS_URL'])
  $redis = Redis.new(host: uri.host, port: uri.port)
end

configure :development do
  disable :show_exceptions
  disable :raise_errors
end

require './app'
require './controller/init'
require './models/init'
require './util/init'

Phonelib.default_country = COUNTRY_CODE

run Sinatra::Application
