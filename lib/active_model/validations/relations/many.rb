# lib/active_model/validations/relations/many.rb

require 'active_model/validations/relations'
require 'active_model/validator'

module ActiveModel::Validations::Relations
  class Many < ActiveModel::Validator
    def validate record
      @record = record

      relations.each.with_index do |relation, index|
        next if relation.valid?

        relation.errors.each do |attribute, message|
          record.errors.add error_key(relation, index, attribute), message
        end # each
      end # each
    end # method validate

    private

    def error_key relation, index, attribute
      :"#{relation_name}[#{index}][#{attribute}]"
    end # method relation_key

    def relations
      @record.send(relation_name)
    end # method relations

    def relation_name
      :relations
    end # method relation_name
  end # class
end # module
