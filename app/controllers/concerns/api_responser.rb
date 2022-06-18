# include ApiResponser
module ApiResponser
  protected

  def render_t_error(locale_key, error_code = 'InvalidParam', status = 400)
    render_error(I18n.t("api.errors.#{locale_key}", default: locale_key), error_code, status)
  end

  def render_error(message, error_code = 'InvalidParam', status = 400)
    render json: Oj.dump({ message: message, error_code: error_code, errors: [] }, mode: :compat), status: status
  end

  def render_form_error(form, error_code = 'InvalidParam', status = 400)
    render json: Oj.dump({ message: form.errors.full_messages.join(', '), error_code: error_code, errors: form.errors }, mode: :compat), status: status
  end
end
