# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'http://raspberry-cook.fr'

SitemapGenerator::Sitemap.create do

  add home_path, priority: 0.9, changefreq: 'monthly'
  add infos_path, changefreq: 'monthly'
  add credits_path, changefreq: 'monthly'
  add about_path

  add signin_path
  add signup_path
  add signout_path

  add fridge_path

  add recipes_path
  add recipes_shuffle_path
  Recipe.all.each do |recipe|
    add recipe_path(recipe), changefreq: 'monthly', lastmod: recipe.updated_at
    add save_recipe_path(recipe.id), changefreq: 'monthly', lastmod: recipe.updated_at
  end

  add users_path
  User.all.each do |user|
    add user_path(user), changefreq: 'daily'
  end

end
