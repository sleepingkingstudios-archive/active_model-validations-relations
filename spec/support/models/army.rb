# spec/support/models/army.rb

require 'active_model/validations/relations/many'

class Army
  include ActiveModel::Validations
  include ActiveModel::Validations::Relations

  attr_accessor :general

  def soldiers
    @soldiers ||= []
  end # method soldiers

  attr_writer :soldiers

  validates_relation :general
  validates_relation :soldiers
end # class
