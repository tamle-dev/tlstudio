#
module Api
  class ApplicationController < ::ActionController::API
    include ApiErrorHandler
    include ApiParamValidation
    include ApiResponser

    def version
      render json: {
        version: APP_VERSION,
      }, status: 200
    end

    protected

    def current_user
      @current_user ||= find_user(current_user_id)
    end

    def current_user_id
      @current_user_id ||= token_sub == 0 ? nil : token_sub
    end

    def authenticated?
      if auth_token.blank?
        render_t_error(:missing_auth_token, 'MissingAuthToken', :unauthorized)
        return
      end

      authenticate!
    end

    def authenticate!
      return if auth_token.blank?

      @decoded_token = UserService::AuthToken.decode(auth_token)
    end

    def token_sub
      (@decoded_token || {})['sub'].to_i
    end

    def find_user(user_id)
      User.find_by(id: user_id)
    end

    def auth_token
      @auth_token ||= request.headers['HTTP_AUTHORIZATION']
    end

    private

    def paging(collection)
      collection.page(params[:page]).per(per_page)
    end
  
    def per_page
      params[:per_page] || 10
    end
  end
end
