# lib/active_model/validations/relations/one.rb

require 'active_model/validations/relations'
require 'active_model/validator'

module ActiveModel::Validations::Relations
  class One < ActiveModel::Validator
    def validate record
      @record = record

      return if relation.nil? || relation.valid?

      relation.errors.each do |attribute, message|
        record.errors.add error_key(relation, attribute), message
      end # each
    end # method validate

    private

    def error_key relation, attribute
      :"#{relation_name}[#{attribute}]"
    end # method relation_key

    def relation
      @record.send(relation_name)
    end # method relation

    def relation_name
      :relation
    end # method relation_name
  end # class
end # module
