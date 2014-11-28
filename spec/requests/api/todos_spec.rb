require 'rails_helper'

describe "Todos API" do

  def json(body)
    JSON.parse(body, symbolize_names: true)
  end

  # context "authorized" do 
    describe "GET index" do
      it "return the list of all todos related to the signed-in user", focus: true do
        user1 = create(:user)
        todo1 = create(:todo, user: user1)
        todo2 = create(:todo, user: user1)
        todo3 = create(:todo, user: user1)
        
        get '/api/todos'
        expect(response.status).to eq(200) 

        todos = json(response.body)
        binding.pry
        bodies = todos.collect { |t| t[:body] }
        expect(bodies).to eq([todo1.body, todo2.body, todo3.body])
      end
    end

    describe "POST create" do
      it "create a new todo item" do 
        user1 = create(:user)

        post '/api/todos',
        { todo:
          { user_id: '#{user1.id}', body: 'Learn about bananas.' }
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
        expect(response.status).to eq(201)
        expect(response.content_type).to eq(Mime::JSON)
      end

      it "fails to create invalid todo item" do
        user1 = create(:user)

        post '/api/todos',
        { todo:
          { user_id: '#{user1.id}', body: '' }
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
        expect(response.status).to eq(422)
      end
    end

    describe "PUT update" do
      it "updates the todo item's description" do 
        user1 = create(:user)
        todo1 = create(:todo, user: user1)

        put "/api/todos/#{todo1.id}",
        { todo: 
          { body: 'Hello banananana' } 
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

        expect(response.status).to eq(200)
        expect(response.content_type).to eq(Mime::JSON)
        expect(todo1.reload.body).to eq('Hello banananana')

      end

      it "fails to update invalid todo item" do
        user1 = create(:user)
        todo1 = create(:todo, user: user1)

        put "/api/todos/#{todo1.id}",
        { todo: 
          { body: '' } }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

        expect(response.status).to eq(422)
      end
    end

    describe "DELETE destroy" do
      it "deletes the todo item" do 
        user1 = create(:user)
        todo1 = create(:todo, user: user1)

        delete "/api/todos/#{todo1.id}"

        expect(response.status).to eq(204)
        expect(Todo.count).to eq(0)

      end
    end
  # end

  context "unauthorized" do
    xit "unauthorized user cannot access todos list" do
    end
  end
end