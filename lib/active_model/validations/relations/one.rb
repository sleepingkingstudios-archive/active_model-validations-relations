# lib/active_model/validations/relations/one.rb

require 'active_model/validations/relations/base'

module ActiveModel::Validations::Relations
  class One < ActiveModel::Validations::Relations::Base
    def validate record
      relation = record.send(relation_name)

      return if relation.blank? || (relation.errors.blank? && relation.valid?)

      relation.errors.each do |attribute, message|
        record.errors.add error_key(relation, attribute), message
      end # each
    end # method validate

    private

    def error_key relation, attribute
      serializer.serialize relation_name, *serializer.deserialize(attribute)
    end # method relation_key

    def relation_name
      :relation
    end # method relation_name
  end # class
end # module
