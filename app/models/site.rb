class Site < ActiveRecord::Base
  validates :user_id, :presence => true
  belongs_to :user

  def self.check
    puts 'Doing hard work'
    Site.all.each do |site|
      newhash=SitesController.hash_from_url(site.url)
      if (site.hash_content != newhash)
        puts 'Change detected ', site.url
        site.hash_content=newhash
        site.save!
        UserMailer.change_email(site.user, site).deliver
      end
    end
    puts 'End hard work'
  end
end
