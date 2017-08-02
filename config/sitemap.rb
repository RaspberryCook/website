# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'http://raspberry-cook.fr'

SitemapGenerator::Sitemap.create do
  add home_path
  add infos_path
  add credits_path
  add about_path

  add signin_path
  add signup_path
  add signout_path

  add fridge_path

  add recipes_path
  add recipes_shuffle_path
  Recipe.all.each do |recipe|
    add recipe_path(recipe), lastmod: recipe.updated_at
    add save_recipe_path(recipe.id), lastmod: recipe.updated_at
  end

  add users_path
  User.all.each do |user|
    add user_path(user), changefreq: 'daily'
  end

end
