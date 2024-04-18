class AuthController < ApplicationController
  skip_before_action :authenticate_user

  def sign_out
    # Clear access token from session
    session.delete(:access_token)
    session.delete(:client)
    session.delete(:uid)

    redirect_to new_auth_path, notice: "You have been successfully signed out."
  end
  def new
  end


  def create
    # Auth with API, and add access token to session
    response = Auth.sign_in(params[:email], params[:password])

    if response.code.to_i == 200
      headers = response.to_hash

      access_token = headers["access-token"]
      client = headers["client"]
      uid = headers["uid"]

      session[:access_token] = Array(access_token).join(', ')
      session[:client] = Array(client).join(', ')
      session[:uid] = Array(uid).join(', ')

      redirect_to root_path, notice: 'Successfully signed in.'
    else
      redirect_to new_auth_path, alert: 'Authentication failed. Please check your email and password.'
    end
  end
end

