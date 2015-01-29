# active_model-validations-relations.gemspec

$: << './lib'
require 'active_model/validations/relations/version'

Gem::Specification.new do |gem|
  gem.name        = 'active_model-validations-relations'
  gem.version     = ActiveModel::Validations::Relations::VERSION
  gem.date        = Time.now.utc.strftime "%Y-%m-%d"
  gem.summary     = 'Improved support for error validation on related models.'
  gem.description = <<-DESCRIPTION
    Improves support for validating related models and displaying the resulting
    error(s). For more information, check out the README.
  DESCRIPTION
  gem.authors     = ['Rob "Merlin" Smith']
  gem.email       = ['merlin@sleepingkingstudios.com']
  gem.homepage    = 'http://sleepingkingstudios.com'
  gem.license     = 'MIT'

  gem.require_path = 'lib'
  gem.files        = Dir["lib/**/*.rb", "LICENSE", "*.md"]

  gem.add_runtime_dependency 'activemodel', '~> 4.2'
end # gemspec