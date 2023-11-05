class WebLink < ApplicationRecord
  validates :key, allow_blank: false, length: { maximum: 10 }
  validates :destination, allow_blank: false, secure_url: true

  before_validation :initialize_key
  before_create :initialize_expires_at

  scope :active, -> { where("expires_at > ?", DateTime.current) }

  def redirect_url
    "#{Rails.configuration.url_root}/r/#{key}"
  end

  def active?
    WebLink.active.exists?(id)
  end

  private

  def initialize_key
    return if key.present?

    self.key = loop do
      # 26 upcase-letters + 10 digits = 1.94 million unique combinations
      random_key = SecureRandom.alphanumeric(6).upcase

      break random_key unless WebLink.active.find_by_key(random_key).present?
    end
  end

  def initialize_expires_at
    return if expires_at.present?

    # 1.94 million keys, each valid 6 months = up to 10k per day on average
    self.expires_at = 6.months.from_now.at_end_of_day
  end
end
