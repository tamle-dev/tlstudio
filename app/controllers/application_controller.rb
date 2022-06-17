require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder

  layout 'application'
end
