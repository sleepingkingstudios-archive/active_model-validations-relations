# ActiveModel::Validations::Relations [![Build Status](https://travis-ci.org/sleepingkingstudios/active_model-validations-relations.svg?branch=master)](https://travis-ci.org/sleepingkingstudios/active_model-validations-relations)

## Object Mappings

### Mongoid

If you are validating related or embedded Mongoid documents using this gem, I recommend disable the built-in validation when defining the relation, e.g. `has_many :posts, :validate => false`. By default, Mongoid will validate the relation on its own, which can result in an extra `Posts is invalid` error message. This is even more important when validating a `belongs_to` or `embedded_in` relationship, as it can result in an infinite validation loop between the parent and child documents.
