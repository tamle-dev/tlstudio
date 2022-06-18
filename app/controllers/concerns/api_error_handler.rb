# include ApiErrorHandler
module ApiErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError do |e|
      render json: { message: e.message, error_code: 'StandardError', errors: []}, status: :bad_request
    end

    rescue_from Exception do |e|
      render json: { message: e.message, error_code: 'StandardError', errors: []}, status: :bad_request
    end

    rescue_from ApiParamValidation::Exception::MissingParam do |e|
      render json: { message: e.message, error_code: 'MissingParam', errors: []}, status: :bad_request
    end

    rescue_from ActiveRecord::RecordNotFound do |_|
      render json: { message: I18n.t('api.errors.resource_not_found'), error_code: 'ResourceNotFound', errors: []}, status: :bad_request
    end

    rescue_from PG::ConnectionBad, PG::Error do |_e|
      render json: { message: I18n.t('api.errors.server_is_maintenance'), error_code: 'StandardError', errors: []}, status: :bad_request
    end

    rescue_from JWT::VerificationError, JWT::InvalidJtiError, JWT::DecodeError do
      render_t_error(:invalid_auth_token, 'InvalidAuthToken', :unauthorized)
    end

    rescue_from JWT::ExpiredSignature do
      render_t_error(:expired_auth_token, 'ExpiredAuthToken', :unauthorized)
    end

    rescue_from JWT::InvalidAudError do
      render_t_error(:forbidden, 'Forbidden', :forbidden)
    end
  end
end
