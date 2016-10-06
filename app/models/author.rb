require 'uri'

class Author < ActiveRecord::Base
  #has_and_belongs_to_many :papers

  validates :last_name, presence: true
  validate :homepage_url

  def name
    "#{first_name} #{last_name}"
  end

  def homepage_url
    uri = URI.parse(homepage)
    unless uri.kind_of?(URI::HTTP)
      errors.add(:error, 'invalid url')
      return false
    end
    rescue URI::InvalidURIError
      false
  end
end
