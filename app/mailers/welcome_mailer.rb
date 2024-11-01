class WelcomeMailer < ApplicationMailer
  def welcome(user)
    @user = user
    mail(
      to: email_address_with_name(@user.email, @user.full_name),
      subject: 'Bienvenido a Xherpas'
    )
  end
end
