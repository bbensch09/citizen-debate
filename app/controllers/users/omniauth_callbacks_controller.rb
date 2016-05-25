class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include WelcomeHelper

  def facebook
    auth = request.env['omniauth.auth']
    # @user = User.find_for_facebook_oauth
    # if @user = User.where(email:auth.info.email).first
    #   # sign_in_and_redirect_to root_path @user, :event => :authentication #this will throw if @user is not activated
    #   set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    #   sign_in(@user)
    #   flash[:notice] = "Thanks for logging in with Facebook. Please scroll back to the bottom of the page to confirm your vote."
    #   redirect_to (session[:previous_url] || root_path)
    # else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      user = User.find_or_create_by(email:auth.info.email)
      if user.sign_in_count == 0
        user.password = Devise.friendly_token[0,20]
      end
      user.uid = auth['uid']
      user.provider = auth['provider']
      # if auth.extra.raw_info.location
      #   p user.location = auth.extra.raw_info.location.name
      # else
      #   user.location = "unknown"
      # end
      p user.save!
      sign_in(user)
      @user = user
      p "----USER SIGNED IN VIA FB------"
      p "email: #{user.email}"
      p "sign_in_count: #{user.sign_in_count}"
      p session[:user_id] = user.id
      current_user = @user
      session[:civility_vote] = nil
      session[:vote_before] = nil
      session[:vote_after] = nil
      flash[:notice] = "Thanks for logging in with Facebook. You are now ready to initiate or join a debate."
      redirect_to (session[:previous_url] || root_path)

  end

# EXTRA VALIDATION FOUND IN omniauth-facebook gem
    # if @user.persisted?
    #   sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    #   set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    # else
    #   session["devise.facebook_data"] = request.env["omniauth.auth"]
    #   redirect_to new_user_registration_url
    # end
  # end

  def failure
    puts "----------error with sign in"
    redirect_to root_path
  end
end
