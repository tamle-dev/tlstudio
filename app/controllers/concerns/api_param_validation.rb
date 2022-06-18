# include ApiParamValidation
module ApiParamValidation
  module Exception
    class MissingParam < StandardError; end
  end

  def validates_presence_of(attribute)
    fail Exception::MissingParam, I18n.t('api.errors.missing_param', attr: attribute) if params[attribute].blank?
  end
end
