class UserMailer < ActionMailer::Base
  default from: "testing.penton@gmail.com"

  def change_email(user, site)
    @user = user
    @site = site
    mail(to: @user.email, subject: 'Change notification')
  end
end
