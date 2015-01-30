# lib/active_model/validations/relations/serializers/bracket_serializer.rb

require 'active_model/validations/relations'

module ActiveModel::Validations::Relations
  module Serializers
    module BracketSerializer
      extend self

      def deserialize key
        key.to_s.sub(/\]\z/, '').split(/\]?\[/)
      end # method deserialize

      def serialize *keys
        keys[1..-1].inject(keys.first.to_s) { |str, key| str << '[' << key.to_s << ']' }.intern
      end # method serialize

      private

      def humanize_attribute attribute
        attr_name = attribute.to_s.tr('.', '_').humanize :capitalize => false
        attr_name = @base.class.human_attribute_name(attribute, default: attr_name) if defined?(@base)
        attr_name
      end # method humanize_attribute
    end # module
  end # module
end # module
