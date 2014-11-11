class Resource < ActiveRecord::Base
  validates :user_id, :presence => true

  def check
    puts 'Doing hard work'
  end

end
