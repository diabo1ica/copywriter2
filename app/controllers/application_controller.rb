class ApplicationController < ActionController::Base

  rescue_from ActionController::InvalidAuthenticityToken do
    redirect_to invalid_token_path, alert: 'Why are you not loggen in? Please log in again.'
  end

  protected

  def after_sign_out_path_for(resource_or_scope)
    posts_path # or any other path you want to redirect to
  end

end
