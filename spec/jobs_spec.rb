ENV['RACK_ENV'] = 'test'
require 'rack/test'
gem "minitest"
require 'minitest/autorun'
require_relative '../app.rb'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "GET test job" do
  it "should return the job with the example content" do
    get 'api/jobs/1'
    job = {id: 1, name: "Paladin"}
    assert_equal job.to_json, last_response.body
    last_response.status.must_equal 200
  end
end

describe "GET jobs" do
  it "responds with OK to heros index call" do
    get "/api/jobs"
    last_response.status.must_equal 200
  end
end

describe "GET job" do
  it "responds with OK to job show call" do
    get "/api/jobs/1"
    last_response.status.must_equal 200
  end
end

describe "POST job" do
  before do
    data = {name: "Rogue"}
    post "/api/jobs", data
  end
  it "check if the job has been created accordingly" do
    resp = JSON.parse(last_response.body)
    resp["name"].must_equal "Rogue"
  end
end

describe "UPDATE job" do
  before do
    data = {name: "Rogue"}
    put "/api/jobs/1", data
  end
  it "check if the job has been updated accordingly" do
    resp = JSON.parse(last_response.body)
    resp["name"].must_equal "Rogue"
  end
end

describe "Delete job" do
  before do
    data = {name: "Rogue"}
    post "/api/jobs", data
  end
  it "responds successfully with 200" do
    delete "/api/jobs/2"
    last_response.status.must_equal 200
  end
end