require 'rails_helper'

describe "Sessions API" do

  before do
    @user = create(:user)

    def json(body)
      JSON.parse(body, symbolize_names: true)
    end
  end

  describe "POST #create" do

    context "when the credentials are correct" do
      it "returns the user record corresponding to the given credentials" do

        post '/api/sessions',
        { session:
          { email: @user.email, password: @user.password }
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

        expect(@user.reload.auth_token).to eq(json(response.body)[:auth_token])
        expect(response.status).to eq(200)
      end
    end

    context "when the credentials are incorrect" do
      it "returns a json with an error" do

        post '/api/sessions',
        { session:
          { email: @user.email, password: nil }
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
        
        expect(json(response.body)[:errors]).to eql "Invalid email or password"
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "generate a new auth_token and overwrite the exisiting one " do

      post '/api/sessions',
        { session:
          { email: @user.email, password: @user.password }
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

      expect(@user.reload.auth_token).to eq(json(response.body)[:auth_token])

      delete "/api/sessions/#{@user.auth_token}"

      expect(response.status).to eq(204)
    end

  end
end