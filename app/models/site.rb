class Site < ActiveRecord::Base
  validates :user_id, :presence => true
  belongs_to :user

  def self.check
    puts 'Doing hard work'
    Site.all.each do |site|
      clnt = HTTPClient.new
      doc = Nokogiri::HTML(clnt.get_content(site.url))
      puts site.last_updated
      newhash=Digest::MD5.hexdigest(doc.xpath("//body").first)
      if (site.last_updated != clnt.head(site.url).header['Last-Modified'][0]) || (site.hash_content != newhash)
        puts 'Change detected ', site.url
        site.hash_content=newhash
        site.save!
        UserMailer.change_email(site.user, site).deliver
      end
    end
    puts 'End hard work'
  end
end
