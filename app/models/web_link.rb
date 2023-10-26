class WebLink < ApplicationRecord
  validates :key, allow_blank: false, length: { maximum: 10 }
  validates :destination, allow_blank: false, secure_url: true
end
