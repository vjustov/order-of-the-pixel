ENV['RACK_ENV'] = 'test'
require 'rack/test'
gem "minitest"
require 'minitest/autorun'
require_relative '../app.rb'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "GET test weapon" do
  it "should return the weapon with the example content" do
    get 'api/weapons/1'
    weapon = {id: 1, name: "Mithril Hammer", desc: "The almighty Thor Hammer, gives +10 to all stats"}
    assert_equal weapon.to_json, last_response.body
    last_response.status.must_equal 200
  end
end

describe "GET weapons" do
  it "responds with OK to wepaons index call" do
    get "/api/weapons"
    last_response.status.must_equal 200
  end
end

describe "GET weapon" do
  it "responds with OK to weapon show call" do
    get "/api/weapons/1"
    last_response.status.must_equal 200
  end
end

describe "POST weapon" do
  before do
    data = {name: "Bastard Sword", desc: "Worn by the bravest, adds +1 agility"}
    post "/api/weapons", data
  end
  it "check if the weapon has been created accordingly" do
    resp = JSON.parse(last_response.body)
    resp["name"].must_equal "Bastard Sword"
    resp["desc"].must_equal "Worn by the bravest, adds +1 agility"
  end
end

describe "UPDATE weapon" do
  before do
    data = {name: "Deity Hammer"}
    put "/api/weapons/1", data
  end
  it "check if the weapon has been updated accordingly" do
    resp = JSON.parse(last_response.body)
    resp["name"].must_equal "Deity Hammer"
  end
end

describe "Delete weapon" do
  before do
    data = {name: "Bastard Sword", desc: "Worn by the bravest, adds +1 agility"}
    post "/api/weapons", data
  end
  it "responds successfully with 200" do
    delete "/api/weapons/2"
    last_response.status.must_equal 200
  end
end