describe "Users API" do
  def json(body)
    JSON.parse(body, symbolize_names: true)
  end

  # xit 'sends a list of messages' do
  #   user1 = create(:user)
  #   user2 = create(:user)

  #   get '/api/users'

  #   expect(response).to be_success            # test for the 200 status-code
  #   json = JSON.parse(response.body)
  #   users = json(response.body)
  #   names = users.collect { |u| u[:name] }
  #   expect(names).to eq([user1.name, user2.name])
  #   # expect(json['messages'].length).to eq(10) # check to make sure the right amount of messages are returned
  # end

  describe "GET index" do
    it "return a list of all users name" do
      user1 = create(:user)
      user2 = create(:user)
      
      get '/api/users'
      expect(response).to be_success 

      users = json(response.body)
      names = users.collect { |u| u[:name] }
      expect(names).to eq([user1.name, user2.name])

    end
  end

  describe "GET show" do
    context "authorized" do
      it "shows the id, name, and email of the user" do
        user1 = create(:user)
        
        get "/api/users/#{user1.id}"
        expect(response).to be_success

        user = json(response.body)
        expect(user[:id]).to eq(user1.id)
        expect(user[:name]).to eq(user1.name)
        expect(user[:email]).to eq(user1.email)
        
      end
    end

    context "unauthorized" do
      xit "access other user's information" do
      end
    end
  end

  describe "POST create" do
    xit "creates a new user" do
    end
  end

  describe "PUT update" do
    context "authorized" do
      xit "updates the user's name, email, and password" do 
      end
    end

    context "unauthorized" do
      xit "cannot update other's account" do
      end
    end
  end

  describe "DELETE destroy" do
    context "authorized" do
      xit "deletes it's own user account" do 
      end
    end

    context "unauthorized" do
      xit "cannot delete other's account" do
      end
    end
  end
end