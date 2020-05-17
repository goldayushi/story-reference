require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include SessionsHelper

  it "get new" do
    get :new
    expect(response.status).to eq(200)
  end

end
