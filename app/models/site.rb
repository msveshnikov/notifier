class Site < ActiveRecord::Base
  validates :user_id, :presence => true
  belongs_to :user
  belongs_to :category

  def self.check
    puts 'Doing hard work'
    Site.all.each do |site|
      begin
        oldcontent     =site.content
        oldhash_content=site.hash_content
        site.calc_hash
        if site.hash_content != oldhash_content
          puts 'Change detected ', site.url, ' old hash ', oldhash_content, ' new hash ', site.hash_content
          File.write('tmp/old', oldcontent)
          File.write('tmp/new', site.content)
          system 'diff tmp/old tmp/new >tmp/diff'
          @diff=File.read('tmp/diff')
          UserMailer.change_email(site, @diff).deliver
          site.diff        = @diff
          site.was_changed = true
          site.save!
        end
      rescue Exception => e
        puts "Error checking site "+site.url+" "+e.message
      end
    end
    puts 'End hard work'
  end

  def calc_hash
    clnt = HTTPClient.new
    doc               = Nokogiri::HTML(clnt.get_content(url))
    doc.css('script, link').each { |node| node.remove }
    self.content      = doc.css('body').text #diff with numbers, hash - without
    self.hash_content = Digest::MD5.hexdigest(self.content.gsub(/[0-9]/, ""))
    save!
  end
end
