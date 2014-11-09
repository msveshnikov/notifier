class User < ActiveRecord::Base
#  attr_accessible :google_id, :name, :email

  validates :name, :presence => true
#  validates :email, :presence => true
  validates :google_id, :uniqueness => true, :presence => true
end
