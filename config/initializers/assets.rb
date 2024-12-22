Rails.application.config.assets.version = "1.0"

Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'builds', 'js')
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'builds', 'css')

Rails.application.config.assets.precompile += [
  Rails.root.join('vendor/assets/javascripts/*').to_s,
  Rails.root.join('vendor/assets/stylesheets/*').to_s
]
