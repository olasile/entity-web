class Entity::FieldsController < ApplicationController
  before_action :set_entity_field_form, only: [:edit, :update, :destroy]
  before_action :set_entities, except: [:index, :destroy]

  def index
    @entity_fields = Entity::Field.all
  end

  def new
    @entity_field_form = Entity::FieldForm.new(entity_field_attributes.map { |attr| [attr, nil] }.to_h)
  end

  def create
    @entity_field_form = Entity::FieldForm.new(entity_field_params)
    if @entity_field_form.save
      redirect_to entity_fields_path, notice: 'Entity Field created successfully.'
    else
      set_flash_error
      render :new
    end
  end

  def edit
  end

  def update
    if @entity_field_form.update(entity_field_params.merge(id: params[:id]))
      redirect_to entity_fields_path, notice: 'Entity Field updated successfully.'
    else
      set_flash_error
      render :edit
    end
  end

  def destroy
    entity_field = Entity::Field.find(params[:id])
    entity_field.destroy

    redirect_to entity_fields_path, notice: 'Entity Field deleted successfully.'
  end

  private

  def set_flash_error
    flash[:alert] = @entity_field_form.errors.full_messages.to_sentence
  end

  def set_entities
    @entities = Entity.all
  end

  def set_entity_field_form
    entity_field = Entity::Field.find(params[:id])
    @entity_field_form = Entity::FieldForm.new(entity_field.attributes)
  end

  def entity_field_params
    params.require(:entity_field_form).permit(*entity_field_attributes)
  end

  def entity_field_attributes
    [:label, :entity_fieldable_id, :entity_fieldable_type]
  end
end
