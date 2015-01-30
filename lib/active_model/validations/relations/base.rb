# lib/active_model/validations/relations/base.rb

require 'active_model/validations/relations'
require 'active_model/validator'

module ActiveModel::Validations::Relations
  class Base < ActiveModel::Validator
    def serializer
      BracketSerializer
    end # method serializer

    module BracketSerializer
      extend self

      def deserialize key
        key.to_s.sub(/\]\z/, '').split(/\]?\[/)
      end # method deserialize

      def serialize *keys
        keys[1..-1].inject(keys.first.to_s) { |str, key| str << '[' << key.to_s << ']' }.intern
      end # method serialize
    end # class
  end # class
end # module
