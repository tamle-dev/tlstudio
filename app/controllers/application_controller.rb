require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder

  layout 'application'

  # Overwriting the sign_in redirect path method
  def after_sign_in_path_for(resource_or_scope)
    dashboards_path
  end

  # Overwriting the sign_up redirect path method
  def after_sign_up_path_for(resource_or_scope)
    dashboards_path
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
