ENV['RACK_ENV'] = 'test'
require 'rack/test'
gem "minitest"
require 'minitest/autorun'
require_relative '../app.rb'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "GET test race" do
  it "should return the race with the example content" do
    get 'api/races/1'
    race = {id: 1, name: "Human"}
    assert_equal race.to_json, last_response.body
    last_response.status.must_equal 200
  end
end

describe "GET races" do
  it "responds with OK to races index call" do
    get "/api/races"
    last_response.status.must_equal 200
  end
end

describe "GET race" do
  it "responds with OK to race show call" do
    get "/api/races/1"
    last_response.status.must_equal 200
  end
end

describe "POST race" do
  before do
    data = {name: "Elf"}
    post "/api/races", data
  end
  it "check if the race has been created accordingly" do
    resp = JSON.parse(last_response.body)
    resp["name"].must_equal "Elf"
  end
end

describe "UPDATE race" do
  before do
    data = {name: "Elf"}
    put "/api/races/1", data
  end
  it "check if the race has been updated accordingly" do
    resp = JSON.parse(last_response.body)
    resp["name"].must_equal "Elf"
  end
end

describe "Delete race" do
  before do
    data = {name: "Elf"}
    post "/api/races", data
  end
  it "responds successfully with 200" do
    delete "/api/races/2"
    last_response.status.must_equal 200
  end
end