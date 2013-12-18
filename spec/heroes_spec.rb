ENV['RACK_ENV'] = 'test'
require 'rack/test'
gem "minitest"
require 'minitest/autorun'
require_relative '../app.rb'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "Get test hero" do
  it "should return the hero with the example content" do
    get 'api/heroes/1'
    hero = { id: 1, name: 'Thor', weapon_id: 1, job_id: 1, race_id: 1 }
    assert_equal hero.to_json, last_response.body
    last_response.status.must_equal 200
  end
end

describe "GET heroes" do
  it "responds with OK to hero index call" do
    get "/api/heroes"
    last_response.status.must_equal 200
  end
end

describe "GET hero" do
  it "responds with OK to hero show call" do
    get "/api/heroes/1"
    last_response.status.must_equal 200
  end
end

describe "POST hero" do
  before do
    data = {name: "Mindless Zombie",
      weapon_id: 1,
      job_id: 1,
      race_id: 1}
    post "/api/heroes", data
  end
  it "check if the hero has been created accordingly" do
    resp = JSON.parse(last_response.body)
    resp["name"].must_equal "Mindless Zombie"
    resp["weapon_id"].must_equal 1
    resp["race_id"].must_equal 1
    resp["job_id"].must_equal 1
  end
end

describe "PUT hero" do
  before do
    data = {name: "Zeus"}
    put "/api/heroes/1", data
  end
  it "check if the hero has been updated accordingly" do
    resp = JSON.parse(last_response.body)
    resp["name"].must_equal "Zeus"
  end
end

describe "Delete hero" do
  it "responds successfully with 200" do
    delete "/api/heroes/1"
    last_response.status.must_equal 200
  end
end