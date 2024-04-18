class EntityForm < BaseForm
  validates :name, presence: true

  def resource_class
    Entity
  end
end
