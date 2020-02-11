class UnprocessableEntitySerializer
  def initialize(resource)
    @resource = resource
  end

  def serialized_json
    format_response.to_json
  end

  private

  def format_response
    {
      data: {
        id: @resource.id,
        type: @resource.class.name.downcase,
        errors: map_resource_errors
      }
    }
  end

  def map_resource_errors
    @resource.errors.messages.map do |error|
      field, messages = error
      { field: field, messages: messages }
    end
  end
end
