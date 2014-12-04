require 'rails_helper'

describe TodosController do
  context '#destroy' do
    #this spec is skipped, since the destroy function is done via api
    xit "destroys todo" do
      user = create(:user)
      todo = create(:todo, user: user)
      sign_in user
    
      delete :destroy, id: todo.to_param

      expect( Todo.all.count ).to eq(0)

    end
  end

  context '#destroy_multiple' do
    it "destroy multiple items" do
      user = create(:user)
      todo1 = create(:todo, user: user)
      todo2 = create(:todo, user: user)
      sign_in user

      delete :destroy_multiple, todos: [todo1.id, todo2.id]

      expect( Todo.all.count).to eq(0)

    end

    it "prevent an attacker destroying items" do
      user = create(:user)
      attacker = create(:user)
      todo1 = create(:todo, user: user)
      todo2 = create(:todo, user: user)
      sign_in attacker

      delete :destroy_multiple, todos: [todo1.id, todo2.id]

      expect( Todo.all.count).to eq(2)

    end

  end

end