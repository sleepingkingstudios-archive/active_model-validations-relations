# lib/active_model/validations/relations/serializers/underscore_serializer.rb

require 'active_model/validations/relations'

module ActiveModel::Validations::Relations
  module Serializers
    module UnderscoreSerializer
      extend self

      def deserialize key
        key.to_s.split('_')
      end # method deserialize

      def serialize *keys
        keys.join('_').intern
      end # method serialize
    end # module
  end # module
end # module
