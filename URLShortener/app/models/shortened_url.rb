# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord 
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true
  validates :user_id, presence: true
  
  def self.random_code
    code = SecureRandom.urlsafe_base64
    
    while ShortenedUrl.exists?(:short_url => code)
      code = SecureRandom.urlsafe_base64
    end
    
    code
  end
  
  
  def self.create_short_url(user_id, long_url)
    new_short_url = ShortenedUrl.random_code
    
    ShortenedUrl.create(long_url: long_url, short_url: new_short_url, user_id: user_id)
  end
  
  belongs_to :submitter,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User 
  # Person.exists?(:name => "David")
  
end 
