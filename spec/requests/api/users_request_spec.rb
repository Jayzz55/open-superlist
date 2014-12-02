require 'rails_helper'

describe "Users API" do
  def json(body)
    JSON.parse(body, symbolize_names: true)
  end

  describe "GET show" do
    it "shows the id, name, and email of the user" do
      user1 = create(:user)
      
      get "/api/users/#{user1.id}", {}, { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'Authorization' => user1.auth_token  }
      expect(response).to be_success

      user = json(response.body)
      expect(user[:id]).to eq(user1.id)
      expect(user[:name]).to eq(user1.name)
      expect(user[:email]).to eq(user1.email)
    end
  end

  describe "POST create" do
    it "create a new user" do 
      post '/api/users',
      { user:
        { name: 'John', email: 'john@example.com', password: '12345678' }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
      expect(response.status).to eq(201)
      expect(response.content_type).to eq(Mime::JSON)
      expect(User.first.name).to eq('John')
      expect(User.first.email).to eq('john@example.com')
    end

    it "fails to create invalid user" do
      post '/api/users',
       { user:
        { name: 'John', email: '', password: '12345678' }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
      expect(response.status).to eq(422)
    end
  end

  describe "PUT update" do
    it "update a user's detail" do 
      user1 = create(:user)

      put '/api/users/1',
      { user:
        { name: 'Ben'}
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'Authorization' => user1.auth_token }
      expect(response.status).to eq(200)
      expect(response.content_type).to eq(Mime::JSON)
      expect(User.first.name).to eq('Ben')
    end

    it "fails to create invalid user" do
      user1 = create(:user)

      put '/api/users/1',
       { user:
        {  email: '' }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'Authorization' => user1.auth_token  }
      expect(response.status).to eq(422)
    end
  end

  describe "DELETE destroy" do
    it "deletes it's own account" do 
      user1 = create(:user)

      delete '/api/users/1', {},
      {'Authorization' => user1.auth_token  }

      expect(response.status).to eq(204)
      expect(User.count).to eq(0)

    end
  end
end