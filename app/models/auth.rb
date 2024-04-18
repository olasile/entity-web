class Auth < ApplicationResource
  self.collection_name = "auth"

  def self.sign_in(email, password)
    post(:sign_in, {}, { email: email, password: password }.to_json)
  end
end

