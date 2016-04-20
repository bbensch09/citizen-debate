class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # def after_sign_in_path_for(user)
  #   if user.sign_in_count <= 1
  #     '/profiles/new'
  #   else
  #     stored_location_for(resource) || root_path
  #   end
  # end

after_filter :store_location

def store_location
  # store last url - this is needed for post-login redirect to whatever the user last visited.
  return unless request.get?
  if (request.path != "/users/sign_in" &&
      request.path != "/users/sign_up" &&
      request.path != "/users/password/new" &&
      request.path != "/users/password/edit" &&
      request.path != "/users/confirmation" &&
      request.path != "/users/sign_out" &&
      !request.xhr?) # don't store ajax calls
    session[:previous_url] = request.fullpath
  end
end

def after_sign_in_path_for(resource)
  if session[:vote_before].present?
    # @temp_vote = DebateVote.new(session[:vote_before])
    # puts "saved to AR the previously temporary debate vote"
    # session[:vote_before] = @temp_vote
    puts "the session variable is storing the vote_before value as #{session[:vote_before]}"
    flash[:notice] = "Thanks for signing up. Please scroll back to the bottom of the page to confirm your vote."
  else
    super
  end
  session[:previous_url] || root_path
end

end
