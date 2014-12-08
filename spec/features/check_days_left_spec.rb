require 'rails_helper'

feature 'days_left counting how many days left',js: true do
  scenario "checks to-do items automatically deleted after 7 days" do
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
      click_button 'Create'

      #check that the new todo item has been created
      expect(page).to have_content("Go to market")

      #user create a another new todo item
      fill_in 'Enter todo item', with: "Another market"

      #user click the create button
      click_button 'Create'

      #check that the new todo item has been created
      expect(page).to have_content("Another market")
    
      #Check that the days_left counter is working
      expect(page).to have_content(7)
      new_time = Time.now + 7.days
      Timecop.travel(new_time)
      click_link 'My List'
      expect(page).to have_content(0)

  end

end
