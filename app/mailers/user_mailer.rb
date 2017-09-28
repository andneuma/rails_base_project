class UserMailer < ApplicationMailer
  def send_welcome_mail(user_id:)
    @user = User.find(user_id)
    mail(
      from: Admin::Setting.relay_mail_address,
      to: @user.email,
      subject: "Welcome to #{Admin::Setting.app_title}"
    )
  end

  def send_password_reset_link(user)
    @user = user
    @password_reset_link = reset_password_url id: @user.id, token: @user.password_reset_token
    mail(from: Admin::Setting.relay_mail_address, to: user.email, subject: "Password reset for #{Admin::Setting.app_title}")
  end
end
