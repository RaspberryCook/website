Raspberry Cook
=========


![Raspberry Logo](https://raw.githubusercontent.com/RaspberryCook/website/master/app/assets/images/og_image.png)


The history
-----------------


**Raspberry** Cook is a project started near September 2015. The first idea was simple: try to build a web-application without knowing. To make it more funny, I want to build it on a Raspberry Pi B+.

So I asked my girlfriend:

>"Hey! Do you want a cool website?"

>"Yes, I want! To save all my recipes to cook."

>"Say no more!"


So for me purposes was very clear:


* make a beautiful design
* built it on my great Raspberry Pi B+
* build a clean code and learn more & more technology
* make happier my girlfriend
* make it with love

So this project start with PHP / SQL / HTML / CCS on my **Linux** Mint laptop. I buy a Raspberry PI for some Euro. I start to learn all SSH commands and to build a Apache Server. And I did all my best

When I was happy of my work. I broke all result to convert it into **Ruby On Rails** Framework to have the greatest website on hearth, of course !!


Development
-----------------------

### Global things

* **SASS** for Stylesheets
* **Units Tests** to ensure all work fine `rake test`
* **Capistrano** to deploy on my Raspberry Pi

### Gems

* [will_paginate](https://github.com/mislav/will_paginate) for pagination
* [carrierwave](https://github.com/carrierwaveuploader/carrierwave) & [rmagick](https://github.com/rmagick/rmagick) for upload picture and resizing *( may need to install libmagickwand-dev `sudo apt-get install libmagickwand-dev`)*
* [sitemap_generator](https://github.com/christianhellsten/sitemap-generator) to build automatically a beautiful Site Map `ruby config/sitemap.rb`
* [authlogic](https://github.com/binarylogic/authlogic) for authentication
* [unread](https://github.com/ledermann/unread) for notifications system
* [simplecov](https://github.com/colszowka/simplecov) for units tests coverage

Things I want to do
----------------------------

* [ ] Add a ingredients feature to calculate some stats about the recipe
* [ ] add connection with **Instagram** & **Facebook**


[License MIT](https://opensource.org/licenses/MIT) | [Rousseau Alexandre](https://github.com/madeindjs)


