require 'rails_helper'

feature "Log in" do
	context "Signning in", :js => true  do
		@javascript
		scenario "Omniauth authentication" do
		visit '/'
		end
	end
end
