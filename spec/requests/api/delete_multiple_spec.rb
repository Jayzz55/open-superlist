require 'rails_helper'

describe "Todos delete_multiple API" do

  def json(body)
    JSON.parse(body, symbolize_names: true)
  end

  before do
    @user = create(:user)
    @attacker = create(:user)
  end

  describe "DELETE destroy_multiple" do
    context "authenticated access" do
      it "deletes the todo item" do 
        todo1 = create(:todo, user: @user)
        todo2 = create(:todo, user: @user)
        delete "/api/users/1/todos/destroy_multiple", {todos: [1,2]}, {'Authorization' => @user.auth_token}
        expect(response.status).to eq(204)
        expect(Todo.count).to eq(0)
      end
    end

    context "un-authenticated access" do
      it "prevent attacker to hack into other user's DELETE request" do
        todo1 = create(:todo, user: @user)
        todo2 = create(:todo, user: @user)
        delete "/api/users/1/todos/destroy_multiple", {todos: [1,2]}, {'Authorization' => @attacker.auth_token}
        expect(response.status).to eq(422)
      end
    end

  end
end