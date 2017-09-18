FactoryGirl.define do
  factory :settings, class: 'Admin::Setting' do
    app_title 'SomeApp'
    relay_mail_address 'admin@secret.com'
    user_activation_tokens 3
    captcha_system 'recaptcha'
  end
end
