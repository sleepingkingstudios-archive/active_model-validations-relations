# spec/support/models/army.rb

require 'active_model/validations/relations/many'

class Army
  include ActiveModel::Validations
  include ActiveModel::Validations::Relations

  def soldiers
    @soldiers ||= []
  end # method soldiers

  attr_writer :soldiers

  validates_relation :soldiers
end # class
