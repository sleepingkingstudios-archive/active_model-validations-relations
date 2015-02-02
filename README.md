# ActiveModel::Validations::Relations [![Build Status](https://travis-ci.org/sleepingkingstudios/active_model-validations-relations.svg?branch=master)](https://travis-ci.org/sleepingkingstudios/active_model-validations-relations)

Improves support for validating related models and displaying the resulting error(s).

## Support

ActiveModel::Validations::Relations is tested against Mongoid 4.

## Contribute

### GitHub

The canonical repository for this gem is located at https://github.com/sleepingkingstudios/https://github.com/sleepingkingstudios/active_model-validations-relations.

### A Note From The Developer

Hi, I'm Rob Smith, a Ruby Engineer and the developer of this library. I use these tools every day, but they're not just written for me. If you find this project helpful in your own work, or if you have any questions, suggestions or critiques, please feel free to get in touch! I can be reached on GitHub (see above, and feel encouraged to submit bug reports or merge requests there) or via email at `merlin@sleepingkingstudios.com`. I look forward to hearing from you!

## Using This Gem

To include this functionality in your custom models, require the gem and then include the gem module as a concern in the model file:

```ruby
require 'active_model/validations/relations'

# ActiveRecord
class Forest < ActiveRecord::Base
  include ActiveModel::Validations::Relations

  has_many :trees

  validates_related_records :trees
end # class

# Mongoid
class Army
  include Mongoid::Document
  include ActiveModel::Validations::Relations

  # Disable the default Mongoid validation with :validate => false.
  has_many :soldiers, :validate => false

  validates_related_documents :soldiers
end # class
```

Using this gem, when validating an instance of the `Forest` or `Army` models, then any errors on the related `Tree` or `Soldier` objects will be merged into the top-level model's `#errors` object.

### Object Mappings

For specific information on using this gem with object mappings such as ActiveRecord or Mongoid, see below.

#### Mongoid

If you are validating related or embedded Mongoid documents using this gem, I recommend disable the built-in validation when defining the relation, e.g. `has_many :posts, :validate => false`. By default, Mongoid will validate the relation on its own, which can result in an extra `Posts is invalid` error message.

This is even more important when validating a `belongs_to` or `embedded_in` relationship, as it can result in an infinite validation loop between the parent and child documents (see Troubleshooting, below).

### Troubleshooting

#### Extra `Child is invalid` or `Children is invalid` messages

If you are seeing extra `Child is invalid` or `Children is invalid` error messages on your top-level model, then your ORM or ODM is running its default validation on the relation. To remove these messages, try adding a `:validate => false` option when you are defining the relation, e.g. `has_many :soldiers, :validate => false`.

#### SystemStackError: stack level too deep

If you are getting a `SystemStackError: stack level too deep` exception, there is a validation loop where the top-level model is trying to validate the related models, which triggers a validation of the top-level model again, which tries to validate the related models, and so on. Make sure you are not trying to validate both sides of the relationship.

Some mappings, including Mongoid, add a default validation when defining a relationship. This can cause the stack to overflow when validating the relationship from the model with the foreign key. To prevent this message from appearing, add a `:validate => false` option when defining the `has_one` or `has_many` relationship.
