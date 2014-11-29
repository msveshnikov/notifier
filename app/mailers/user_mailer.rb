class UserMailer < ActionMailer::Base
  default from: "testing.penton@gmail.com"

  def change_email(site, diff)
    @site = site
    @user = site.user
    diff_a = diff.split("\n")
    diff_a.each { |s| colorize s }
    @diff = diff_a.join("<br>")
    @diff = sanitize_utf8(@diff)
    mail(to: @user.email, subject: 'Change notification')
  end

  def sanitize_utf8(string)
    return nil if string.nil?
    return string if string.valid_encoding?
    string.chars.select { |c| c.valid_encoding? }.join
  end

  def colorize(s)
    s.replace "<h3>"+s+"</h3>" if s[0]==">"
    s.replace "<h4>"+s+"</h4>" if s[0]=="<"
  end
end
