class User < ActiveRecord::Base
  devise :rememberable, :omniauthable
  attr_accessible :provider, :uid, :email, :name
  has_many :authentications
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.uid + "@twitter.com").first
      if registered_user
	return registered_user
      else 
	user = User.create(name:auth.extra.raw_info.name, provider:auth.provider, uid:auth.uid, email:auth.uid+"@twitter.com", password:Devise.friendly_token[0,20])
	return user
      end
    end
  end
end
