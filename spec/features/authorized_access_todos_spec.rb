require 'rails_helper'

feature "authorized access to todos" do
  scenario "non-signed in user attempt to access todos" do
    user = create(:user)
    visit todos_path
    
    #non-signed in user redirected to sign-in page
    expect(current_path).to eq(user_session_path)

  end
end