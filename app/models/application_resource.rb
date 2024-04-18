class ApplicationResource < ActiveResource::Base
  self.site = ENV['BASE_API_URL']

  def self.headers
    # Add access token to headers for ActiveResource call to the API.
    super.merge({
                  'access-token' => Array(Thread.current[:access_token]).join(', '),
                  'client'       => Array(Thread.current[:client]).join(', '),
                  'uid'          => Array(Thread.current[:uid]).join(', ')
                })
  end
end
