class Admin::SettingsController < Admin::AdminController
  before_action :init_settings, only: [:edit, :update]

  def edit
    @settings_hash = Admin::Setting.all_settings
    respond_to do |format|
			format.html
      format.json { render json: @settings_hash.to_json, status: :ok }
    end
  end

  def update
    respond_to do |format|
      if @settings.update_attributes(settings_params)
        format.html do
          flash[:success] = "Settings updated successfully!"
          redirect_to admin_settings_url
        end
        format.json { render json: @settings.to_json, status: :ok}
      else
        format.html do
          flash[:danger] = @settings.errors.full_messages.to_sentence
          render :edit
        end
        format.json { render json: @settings.errors.to_json, status: :bad_request}
			end
    end
  end

  def captcha_system_status
    respond_to do |format|
      format.json { render json: check_captcha_system(captcha_system: params[:captcha_system]).to_json, status: 200 }
    end
  end

  private

  def check_captcha_system(captcha_system:)
    case captcha_system
      when 'recaptcha'
        return recaptcha_status
      when 'simple_captcha'
        return simple_captcha_status
    end
  end

  def recaptcha_status
    if ENV['RECAPTCHA_SITE_KEY'] && ENV['RECAPTCHA_SECRET_KEY']
      { status_code: 'working', status_message: 'Captcha system working' }
    else
      { status_code: 'error', status_message: 'No valid API key' }
    end
  end

  def simple_captcha_status
    return { status_code: 'working', status_message: 'Captcha system working' }
  end

  def settings_params
    params.require(:admin_setting).permit(
        :app_title,
        :admin_email_address,
        :user_activation_tokens,
        :captcha_system,
        :app_imprint,
        :app_privacy_policy,
        :multi_color_pois,
        :default_poi_color,
        :expiry_days
    )

  end

  def init_settings
    @settings = Admin::Setting.last || Admin::Setting.create
  end
end
