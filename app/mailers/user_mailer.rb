class UserMailer < ActionMailer::Base
  default from: "\"iWatcher\" <best.site.notifier@gmail.com>"

  def change_email(site, diff)
    @site = site
    @user = site.user
    diff_a = diff.split("\n")-["---"]
    diff_a.each { |s| colorize s }
    @diff = diff_a.join
    @diff = sanitize_utf8(@diff)
    diff.replace @diff
    mail(to: @user.email, subject: 'Change notification') if @user.id != 2
  end

  def sanitize_utf8(string)
    return nil if string.nil?
    return string if string.valid_encoding?
    string.chars.select { |c| c.valid_encoding? }.join
  end

  def colorize(s)
    if s[0]=='<'
      s.replace ' <h4> '+s[1..80]+' </h4> '
    else
      if s[0]=='>'
        s.replace ' <h3> '+s[1..80]+' </h3> '
      end
    end
  end

end
