class WebLink < ApplicationRecord
  validates :key, allow_blank: false, length: { maximum: 10 }
  validates :destination, allow_blank: false, secure_url: true

  before_validation :initialize_key

  def redirect_url
    "#{Rails.configuration.url_root}/r/#{key}"
  end

  private

  def initialize_key
    return if key.present?

    self.key = loop do
      random_key = SecureRandom.alphanumeric(6).upcase

      break random_key unless WebLink.find_by_key(random_key).present?
    end
  end
end
