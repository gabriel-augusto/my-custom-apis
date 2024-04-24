require "rails_helper"

RSpec.describe "/up", type: :request do
  before { host! "0.0.0.0:3000" }

  it 'check app health status' do
    get '/up'
    
    expect(response).to be_successful
  end
end
