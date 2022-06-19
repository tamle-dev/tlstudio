require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder

  layout 'application'

  # Overwriting the sign_in redirect path method
  def after_sign_in_path_for(resource_or_scope)
    root_path
  end

  # Overwriting the sign_up redirect path method
  def after_sign_up_path_for(resource_or_scope)
    root_path
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def page
    params[:page] || 1
  end

  def per_page
    params[:per_page] || 5
  end

  def paging(collection)
    collection.page(page).per(per_page)
  end

  def current_user_id
    current_user&.id
  end

  def verify_authenticity_token
    request.headers['X-CSRF-Token'] ||= request.headers['X-XSRF-TOKEN']
    super
  end
end
