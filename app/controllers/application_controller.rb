class ApplicationController < ActionController::Base
  include AuthHelper

  before_action :set_access_token
  before_action :authenticate_user

  after_action :clear_thread_current

  private

  def clear_thread_current
    # Make authentication thread safe by clearing access token at the end of each request.
    Thread.current[:access_token] = nil
    Thread.current[:client] = nil
    Thread.current[:uid] = nil
  end

  def set_access_token
    # Set access token in thread at the beginning of each request
    if session[:access_token]
      Thread.current[:access_token] = session[:access_token]
      Thread.current[:client] = session[:client]
      Thread.current[:uid] = session[:uid]
    end
  end


  def authenticate_user
    # Redirect to new auth page if user is not signed in.
    redirect_to new_auth_path unless user_signed_in?
  end
end
