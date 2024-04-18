class Entity::Field < ApplicationResource
  self.collection_name = 'entity/fields'
  self.collection_parser = EntityFieldCollection

  def as_json(options = {})
    { entity_field: super(options) }
  end
end
