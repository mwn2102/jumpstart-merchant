class User < ActiveRecord::Base
    has_many :orders
    
    def self.find_or_create_by_auth(auth_data)
      #find_or_create_by is a rails dynamic finder. Name hash will only be used when creating new parameters    
      #find_or_create_by_provider_and_uid(auth_data["provider"], auth_data["uid"], name: auth_data["info"]["name"])
      create_with(name: auth_data["screen_name"]).find_or_create_by(provider: auth_data["provider"], uid: auth_data["uid"])
    end
end
