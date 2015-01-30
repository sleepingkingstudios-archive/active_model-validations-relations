# lib/active_model/validations/relations/base.rb

require 'active_model/validations/relations'
require 'active_model/validations/relations/serializers/bracket_serializer'
require 'active_model/validator'

module ActiveModel::Validations::Relations
  class Base < ActiveModel::Validator
    def serializer
      ActiveModel::Validations::Relations::Serializers::BracketSerializer
    end # method serializer
  end # class
end # module
