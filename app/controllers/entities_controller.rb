class EntitiesController < ApplicationController
  before_action :set_entity_form, only: [:edit, :update, :destroy]

  def index
    @entities = Entity.all
  end

  def new
    @entity_form = EntityForm.new(entity_attributes.map { |attr| [attr, nil] }.to_h)
  end

  def create
    @entity_form = EntityForm.new(entity_params)
    if @entity_form.save
      redirect_to entities_path, notice: 'Entity created successfully.'
    else
      set_flash_error
      render :new
    end
  end

  def edit
  end

  def update
    if @entity_form.update(entity_params.merge(id: params[:id]))
      redirect_to entities_path, notice: 'Entity updated successfully.'
    else
      set_flash_error
      render :edit
    end
  end

  def destroy
    entity = Entity.find(params[:id])
    entity.destroy

    redirect_to entities_path, notice: 'Entity deleted successfully.'
  end

  private

  def set_flash_error
    flash[:alert] = @entity_field_form.errors.full_messages.to_sentence
  end

  def set_entity_form
    entity = Entity.find(params[:id])
    @entity_form = EntityForm.new(entity.attributes)
  end

  def entity_params
    params.require(:entity_form).permit(*entity_attributes)
  end

  def entity_attributes
    [:name]
  end
end
