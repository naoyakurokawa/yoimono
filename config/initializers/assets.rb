# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

webpack_manifest_path = Rails.root.join('public', 'assets', 'manifest.json')
Rails.application.config.assets.webpack_manifest =
 if File.exist?(webpack_manifest_path)
   JSON.parse(File.read(webpack_manifest_path))
 end
# Rails.application.config.assets.precompile += %w(*.js *.css)
# Rails.application.config.assets.precompile << /(^[^_\/]|\/[^_])[^\/]*(\.js|\.css)$/ 