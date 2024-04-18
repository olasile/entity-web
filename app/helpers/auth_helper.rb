module AuthHelper
  def user_signed_in?
    Thread.current[:access_token].present?
  end
end