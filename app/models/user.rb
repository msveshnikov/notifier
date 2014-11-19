class User < ActiveRecord::Base
  has_many :sites

  validates :name, :presence => true
#  validates :email, :presence => true
  validates :google_id, :uniqueness => true, :presence => true
end
