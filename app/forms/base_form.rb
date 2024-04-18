class BaseForm
  # Interface to build form objects for views, and to persist ActiveResource data to the API.
  include ActiveModel::Model

  def initialize(attributes = {})
    @attributes = attributes

    attributes.each do |attribute_name, attribute_value|
      self.class.class_eval {attr_accessor attribute_name}
      self.instance_variable_set("@#{attribute_name}", attribute_value)
    end
  end

  def save
    return false unless valid?
    resource = persist_resource
    resource.save
  end

  def update(params)
    @attributes = params
    save
  end

  private

  def persist_resource
    resource = if respond_to?(:id) && id.present?
                 resource_class.find(id)
             else
               resource_class.new
             end

    resource.attributes = @attributes
    resource
  end

  def resource_class
    raise(NotImplementedError)
  end
end
