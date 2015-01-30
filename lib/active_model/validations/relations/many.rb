# lib/active_model/validations/relations/many.rb

require 'active_model/validations/relations/base'

module ActiveModel::Validations::Relations
  class Many < ActiveModel::Validations::Relations::Base
    def validate record
      record.send(relation_name).each.with_index do |relation, index|
        next if relation.errors.blank? && relation.valid?

        relation.errors.each do |attribute, message|
          record.errors.add error_key(relation, index, attribute), message
        end # each
      end # each
    end # method validate

    private

    def error_key relation, index, attribute
      serializer.serialize relation_name, index, *serializer.deserialize(attribute)
    end # method relation_key

    def relation_name
      :relations
    end # method relation_name
  end # class
end # module
