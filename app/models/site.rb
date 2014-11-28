class Site < ActiveRecord::Base
  validates :user_id, :presence => true
  belongs_to :user
  belongs_to :category

  def self.check
    puts 'Doing hard work'
    Site.all.each do |site|
      newhash=site.hash
      if (site.hash_content != newhash)
        puts 'Change detected ', site.url
        site.hash_content=newhash
        site.save!
        UserMailer.change_email(site.user, site).deliver
      end
    end
    puts 'End hard work'
  end

  def hash
    clnt = HTTPClient.new
    doc = Nokogiri::HTML(clnt.get_content(url))
    doc.css('script, link').each { |node| node.remove }
    text = doc.css('body').text
    #File.write('c:\site.txt', text)
    Digest::MD5.hexdigest(text)
  end
end
