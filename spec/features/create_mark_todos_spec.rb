require 'rails_helper'

feature 'Create and mark off to do list',js: true do
  scenario "lets user create and delete to-do list" do

      #Go to home page
      user = create(:user)
      visit root_path
      
      #Click sign in link
      within '.user-info' do
        click_link 'Sign In'
      end

      #fill in details
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      # #click sign in button
      click_button 'Log in'

      #user create a new todo item
        fill_in 'Enter todo item', with: "Go to market"

      #user click the create button
      click_link 'Create'

      #check that the new todo item has been created
      expect(page).to have_content("Go to market")

      #user create a another new todo item
      fill_in 'Enter todo item', with: "Another market"

      #user click the create button
      click_link 'Create'

      #check that the new todo item has been created
      expect(page).to have_content("Another market")

      #user create a another new todo item
      fill_in 'Enter todo item', with: "Market the third"

      #user click the create button
      click_link 'Create'

      #check that the new todo item has been created
      expect(page).to have_content("Market the third")

      #user delete third item
      within('#todo-3') do
        click_link 'Delete'
      end

      #check that third todo item has been deleted
      expect(page).to have_no_content("Market the third")

      #user mark first todo item as completed
      page.check('todo_1')

      #user mark second todo item as completed
      page.check('todo_2')

      #user click "delete completed" button
      click_button 'Delete completed'

      #check that the marked completed todo items have been deleted
      expect(page).to have_no_content("Go to market")
      expect(page).to have_no_content("Another market")

  end
end