class Entity::FieldForm < BaseForm
  validates :label, presence: true

  def resource_class
    Entity::Field
  end
end
