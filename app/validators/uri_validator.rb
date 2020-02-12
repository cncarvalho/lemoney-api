class UriValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless is_a_valid_uri?(value)
      record.errors.add(attribute, 'Must be a valid URI')
    end
  end

  private

  def is_a_valid_uri?(value)
    begin
      parsed_uri = URI.parse(value)
      parsed_uri.is_a?(URI::HTTP) and parsed_uri.host.present?
    rescue URI::InvalidURIError
      false
    end
  end
end
