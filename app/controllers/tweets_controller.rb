require 'grackle'
require 'rinku'
require 'twitter-text'

class TweetsController < ApplicationController
	include Twitter::Autolink
	def get_tweets
		# Devise manages the authorization in this controller
		# FIX-ME: make this controller to inherit from AcrtionController::API
		if signed_in?
			raw_tws = client.search.tweets?(:q => params[:symbol], :lang => 'en', :result_type => 'recent')
			@tweets = ActiveSupport::JSON.decode(raw_tws)
			@array_twt = Array.new
			@tweets.each do |key, val|
				val.each do |tw_t|
					if tw_t.class == Hash
						if tw_t.has_key?("text")
							tweetText = tw_t["text"]
							tweetText = auto_link(tweetText)
							tweetDate = Date.parse(tw_t["created_at"])
							@array_twt.push({:created_at => tw_t["created_at"],
								:id => tw_t["id"].to_s,
								:text => tweetText,
								:screen_name => tw_t["user"]["screen_name"],
								:name => tw_t["user"]["name"],
								:profile_image_url_https => tw_t["user"]["profile_image_url_https"],
							}) 
						end
					end
				end
			end

			hash_twt = Hash.new
			hash_twt = {:"tweets" => @array_twt}
			render json: @array_twt.to_json
		else
			render json: {"error" => "Please sign in"}
		end
	end

	private
	def client
	  Grackle::Client.new(:ssl=>true, :handlers=>{:json=>Grackle::Handlers::StringHandler.new}, :auth=>{
		  :type=>:oauth,
		  :consumer_key=> ENV['TWITTER_CONSUMER_KEY'],
		  :consumer_secret=> ENV['TWITTER_CONSUMER_SECRET'],
		  :token=> ENV['TWITTER_TOKEN'],
		  :token_secret=> ENV['TWITTER_TOKEN_SECRET']
	  })
	end
end
