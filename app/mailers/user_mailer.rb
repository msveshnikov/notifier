class UserMailer < ActionMailer::Base
  default from: "testing.penton@gmail.com"

  def change_email(site, diff)
    @site = site
    @user = site.user
    @diff = sanitize_utf8(diff)
    mail(to: @user.email, subject: 'Change notification')
  end

  def sanitize_utf8(string)
    return nil if string.nil?
    return string if string.valid_encoding?
    string.chars.select { |c| c.valid_encoding? }.join
  end

end
