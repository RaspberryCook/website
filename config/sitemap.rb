# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'http://raspberry-cook.fr'

SitemapGenerator::Sitemap.create do
	
	add '/home' , 	:priority => 0.9, :changefreq => 'monthly'
	add '/infos' , 	:changefreq => 'monthly'
	add '/credits' , :changefreq => 'monthly'
	add '/signup'
	add '/signin' 
	add '/signout' 

	add '/pages/credits'
	add '/pages/home'
	add '/pages/infos'

	add '/recipes/index', :changefreq => 'daily'
	add '/recipes/show'
	add '/recipes/edit', :changefreq => 'daily'
	add '/recipes/update', :changefreq => 'daily'
	add '/recipes/save'
	add '/recipes/search'
	add '/recipes/vote'

	add 'users/new'
	add 'users/index'
	add 'users/edit'

end
