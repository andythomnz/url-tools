class SecureUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    url = URI.parse(value) rescue nil

    record.errors.add(attribute, "must be an HTTPS URL") unless url&.is_a?(URI::HTTPS)
  end
end