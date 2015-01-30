# lib/active_model/validations/relations.rb

require 'active_model/validations'
require 'active_model/validations/relations/many'
require 'active_model/validations/relations/one'

module ActiveModel::Validations
  module Relations
    extend ActiveSupport::Concern

    module ClassMethods
      def validates_relation relation_name, options = {}
        ActiveModel::Validations::Relations.apply self, relation_name, options
      end # class method validates_relation
    end # module

    class << self
      def apply base, relation_name, options
        arity = options[:arity] || guess_arity(relation_name)

        case arity.intern
        when :one
          validator_base = ActiveModel::Validations::Relations::One
        when :many
          validator_base = ActiveModel::Validations::Relations::Many
        else
          raise ArgumentError.new "unrecognized arity value #{arity} -- must be :one or :many"
        end # case

        validator_class = Class.new(validator_base) do
          define_method :relation_name do
            relation_name
          end # method relation_name
        end # class

        base.send :validates_with, validator_class
      end # module method apply

      private

      def guess_arity relation_name
        relation_name.to_s == relation_name.to_s.singularize ?
          :one :
          :many
      end # module method guess_arity
    end # eigenclass
  end # module
end # module
