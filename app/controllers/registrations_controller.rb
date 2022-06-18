class RegistrationsController < Devise::RegistrationsController
  def create
    flash[:alert] = []
    if username_exists?
      flash[:alert] << 'Username already exists'
      return redirect_to new_user_registration_path
    else
      build_resource(sign_up_params)
      resource.save

      unless resource.valid?
        resource.errors.full_messages.each do |message|
          flash[:alert] << message
        end
      end
    end

    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  private

  def username_exists?
    User.exists?(username: username)
  end

  def username
    return unless params[:user]

    params[:user][:username]
  end
end