require 'rails_helper'

describe "Todos API" do

  def json(body)
    JSON.parse(body, symbolize_names: true)
  end

  before do
    @user = create(:user)
    @attacker = create(:user)
  end

 
  describe "GET index" do
    before do
      @todo1 = create(:todo, user: @user)
      @todo2 = create(:todo, user: @user)
      @todo3 = create(:todo, user: @user)
    end

    context "authenticated access" do
      it "return the list of all todos related to the signed-in user" do
        get "/api/users/1/todos", {}, {'Authorization' => @user.auth_token}
        expect(response.status).to eq(200) 

        todos = json(response.body)
        bodies = todos.collect { |t| t[:body] }
        expect(bodies).to eq([@todo1.body, @todo2.body, @todo3.body])
      end
    end

    context "un-authenticated access" do
      it "prevent attacker to access the GET request" do
        get "/api/users/1/todos", {}, {'Authorization' => @attacker.auth_token}
        expect(response.status).to eq(422) 
      end
    end
  end

  describe "POST create" do
    context "authenticated access" do
      it "create a new todo item" do 
        post "/api/users/1/todos",
        { todo:
          { user_id: '#{@user.id}', body: 'Learn about bananas.' }
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'Authorization' => @user.auth_token }
        expect(response.status).to eq(201)
        expect(response.content_type).to eq(Mime::JSON)
      end

      it "fails to create invalid todo item" do

        post "/api/users/1/todos",
        { todo:
          { user_id: '#{@user.id}', body: '' }
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'Authorization' => @user.auth_token }
        expect(response.status).to eq(422)
      end
    end

    context "un-authenticated access" do
      it "prevent attacker to hack into other user's POST request" do 
        post "/api/users/1/todos",
        { todo:
          { user_id: '#{@user.id}', body: 'Learn about bananas.' }
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'Authorization' => @attacker.auth_token }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT update" do
    context "authenticated access" do
      it "updates the todo item's description" do 
        todo1 = create(:todo, user: @user)
        put "/api/users/1/todos/1",
        { todo: 
          { body: 'Hello banananana' } 
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'Authorization' => @user.auth_token }
        expect(response.status).to eq(200)
        expect(response.content_type).to eq(Mime::JSON)
        expect(todo1.reload.body).to eq('Hello banananana')
      end

      it "fails to update invalid todo item" do
        todo1 = create(:todo, user: @user)

        put "/api/users/1/todos/1",
        { todo: 
          { body: '' } }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'Authorization' => @user.auth_token }

        expect(response.status).to eq(422)
      end
    end

    context "un-authenticated access" do
      it "prevent attacker to hack into other user's PUT request" do 
        todo1 = create(:todo, user: @user)
        put "/api/users/1/todos/1",
        { todo: 
          { body: 'Hello banananana' } 
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'Authorization' => @attacker.auth_token }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE destroy" do
    context "authenticated access" do
      it "deletes the todo item" do 
        todo1 = create(:todo, user: @user)
        delete "/api/users/1/todos/1", {}, {'Authorization' => @user.auth_token}
        expect(response.status).to eq(204)
        expect(Todo.count).to eq(0)
      end
    end

    context "un-authenticated access" do
      it "prevent attacker to hack into other user's DELETE request" do
        todo1 = create(:todo, user: @user)
        delete "/api/users/1/todos/1", {}, {'Authorization' => @attacker.auth_token}
        expect(response.status).to eq(422)
      end
    end

  end
end