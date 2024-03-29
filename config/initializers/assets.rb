# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# %w(about application civility_votes debate_votes debaters debates judges messages profiles rounds topic_votes topics verdicts welcome comments).each do |controller|
#   Rails.application.config.assets.precompile += ["#{controller}.js", "#{controller}.css"]
# end

# Add additional assets to the asset load path (CKeditor)
Rails.application.config.assets.precompile += %w( ckeditor/* )

# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
