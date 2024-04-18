class EntityFieldCollection < ActiveResource::Collection
  # Custom Collection to transform json responses from the API into a format ActiveResource understands
  attr_accessor :parsed_data

  def initialize(parsed_data = {})
    @elements = parsed_data['entity_fields'] || []
  end
end