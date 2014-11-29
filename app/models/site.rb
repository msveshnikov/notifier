class Site < ActiveRecord::Base
  validates :user_id, :presence => true
  belongs_to :user
  belongs_to :category

  def self.check
    puts 'Doing hard work'
    Site.all.each do |site|
      oldcontent=site.content
      newhash=site.hash
      if site.hash_content != newhash
        puts 'Change detected ', site.url
        site.hash_content = newhash
        site.was_changed = true
        site.save!
        File.write('tmp/old', oldcontent)
        File.write('tmp/new', site.content)
        #system 'diff tmp/old tmp/new >tmp/diff'
        diff=File.read('tmp/diff')
        diff.gsub! "\n", "<br>"
        UserMailer.change_email(site, diff).deliver
      end
    end
    puts 'End hard work'
  end

  def hash
    clnt = HTTPClient.new
    doc = Nokogiri::HTML(clnt.get_content(url))
    doc.css('script, link').each { |node| node.remove }
    self.content= doc.css('body').text
    Digest::MD5.hexdigest(self.content)
  end
end
