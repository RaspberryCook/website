#
class PagesController < ApplicationController
  before_filter :authenticate, :only =>  [:feeds]

  

  # GET /home
  # GET /pages/home
  # a web page to present Raspberry Cook
  def home
    @description = 'Des recettes. Partout. Tout plein!'
    @jsonld = home_jsonld

    @recipes = Recipe.where.not(image: nil).order(id: 'DESC').limit(3)
  end


  # GET /about
  # GET /pages/about
  # a web page to present Raspberry Cook
  def about
    @title = "A propos de Raspberry Cook"
    @description = 'Des recettes. Partout. Tout plein!'
    @jsonld = home_jsonld
    @recipes = Recipe.where.not(image: nil).order(id: 'DESC').limit(3)
  end


  # GET /credits
  # GET /pages/credits
  # a web page to thank all contributors on this amazing project
  def credits
    @title = 'credits'
    @description = 'Un grand merci à toi, lecteur.'
    @jsonld = home_jsonld
  end


  # GET /feeds
  # GET /pages/feeds
  # allow usser to consult what he missed on Raspberry Cook
  def feeds
    @title = 'actualités'
    @description = 'Tout ce que vous n\'avez pas ecore vu'
    @recipes_feeds = Recipe.unread_by(current_user).paginate(:page => params[:page]).order('id DESC')
    @unread_comments = Comment.unread_by(current_user)
    Comment.mark_as_read! :all, for: current_user
  end


  # GET /fridge
  # GET /pages/fridge
  # POST /fridge
  # POST /pages/fridge
  def fridge
    @title = 'Vider mon frigo'
    @description = 'Cuisinez avec tout ce qui traine dans votre frigo'

    recipes = nil

    if params[:ingredients]
      ingredients = params[:ingredients].split('_')
      query = []
      ingredients_params = []
      ingredients.map{|ing|
        query << "ingredients LIKE ?"
        ingredients_params << "%#{ing}%"
      }
      recipes = Recipe.where(query.join(" AND "), *ingredients_params)
    else
      recipes = Recipe.all
    end
    @recipes = recipes.paginate :page => params[:page]
  end

  private

  def home_jsonld
    author = {
      "@context" => "http://schema.org/",
      "@type": "Person",
      givenName: 'Alexandre',
      familyName: 'Rousseau',
      url: Rails.application.routes.url_helpers.user_url(self.id),
      contactPoint: {
        email: 'a.rousseau@protonmail.com'
      },
      sameAs: [
        'https://www.linkedin.com/in/alexandre-rousseau-a55a9464/'
      ]
    }

    {
      "@context": "http://schema.org",
      "@type": "WebSite",
      name: "Raspberry Cook",
      url: "http://raspberry-cook.fr",
      author: author,
      funder: author,
      sameAs: [
        "https://www.facebook.com/raspberrycook",
        "https://github.com/RaspberryCook",
        "https://www.instagram.com/raspberry_cook",
      ],
      contactPoint: {
        email: 'a.rousseau@protonmail.com'
      }
    }
  end

end
