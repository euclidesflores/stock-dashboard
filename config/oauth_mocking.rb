module OauthMocking
	def login_with_oauth(provider = :twitter)
		visit "/users/auth/twitter"
	end
end
