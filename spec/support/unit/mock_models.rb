# frozen_string_literal: true

module MockModels
  ATTRIBUTES = {
    :testi_user => %i[
      name
      email
      phone_number
      password
      customer
    ],
  }.freeze

  class Cache
    class << self
      attr_accessor :classes
    end
  end

  def imitate(model, attributes = {})
    attributes ||= {}
    class_for(model).new attributes_for(model).merge(attributes)
  end

  def class_for(model)
    return classes[model] if classes[model]

    base = StrongStruct.new(*ATTRIBUTES[model])

    model_name = model.to_s.camelize

    klass = create_class_for(base, model_name)

    classes[model] = klass
  end

  private

  def classes
    Cache.classes ||= {}
  end

  def create_class_for(base, model_name)
    instance_module = get_instance_module_for(model_name)
    class_module    = get_class_module_for(model_name)

    mock =
      Class.new(base) do
        extend  class_module if class_module
        include instance_module if instance_module
        include ActiveModel::Validations
      end

    Object.const_set "#{model_name}Mock", mock
  end

  def get_instance_module_for(model_name)
    get_module_for "#{model_name}Instance"
  end

  def get_class_module_for(model_name)
    get_module_for "#{model_name}Class"
  end

  def get_module_for(module_name)
    return unless Concerns.const_defined?(module_name)

    Concerns.const_get module_name
  end
end

RSpec.configure do |config|
  config.include MockModels
end
