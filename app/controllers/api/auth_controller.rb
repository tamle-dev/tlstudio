#
module Api
  class AuthController < ::Api::ApplicationController
    before_action :authenticated?
  end
end
