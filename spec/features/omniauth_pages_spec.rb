require 'rails_helper'

feature "OmniauthPages", :type => :feature do
	scenario "Omniauth", :js => true do
		visit root_path
		expect(page).to have_content('Sign up with Twitter')

	end
end
