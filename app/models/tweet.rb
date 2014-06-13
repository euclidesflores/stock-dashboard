require 'grackle'
require 'json'
class Tweet < ActiveRecord::Base
  def self.get_latest
	raw_tweets = client.search.tweets?(:q => "$fb")
	@tweets = ActiveSupport::JSON.decode(raw_tweets)
	@tweets.each do |key, val|
		val.each do |tw_t|
			if tw_t.class == Hash
				if tw_t.has_key?("text") 
					print "Key does exist\n"
				end
			end
		end
	end
  end

  private 
  def self.client
	  Grackle::Client.new(:ssl=>true,
			      :handlers=>{:json=>Grackle::Handlers::StringHandler.new},
			      :auth=>{
		  :type=>:oauth,
		  :consumer_key=> ENV['TWITTER_CONSUMER_KEY'],
		  :consumer_secret=> ENV['TWITTER_CONSUMER_SECRET'],
		  :token=> ENV['TWITTER_TOKEN'],
		  :token_secret=> ENV['TWITTER_TOKEN_SECRET']
	  })
  end
end
