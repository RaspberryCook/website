namespace :export do

  # https://recipemd.org/specification.html
  desc "Generate yard documentation"
  task markdown: :environment do

    Recipe.all.each do |recipe|
      filename = "exports/#{recipe.slug}.md"


      File.open(filename, 'w') do |f|
          f.write <<-eos
---
title: #{recipe.name}
time:
  baking: #{recipe.baking}
  cooling: #{recipe.cooling}
  cooking: #{recipe.cooking}
  rest: #{recipe.rest}
author: #{recipe.user&.complete_name}
image: #{recipe.true_image_url}
old_id: #{recipe.id}
created_at: #{recipe.created_at}
updated_at: #{recipe.updated_at}
---

# #{recipe.name}

          eos

          f.write "#{recipe.description}\n\n" if recipe.description
          f.write "*Saisons: #{recipe.season}*\n\n" if recipe.season
          f.write "*#{recipe.allergens.map(&:name).join(', ')}*\n\n" if recipe.allergens.length > 0
          f.write <<-eos
*Préparation: #{recipe.cooking} min, Cuisson: #{recipe.baking} min, Refrigération: #{recipe.cooling} min, Repos: #{recipe.rest}*

---

- #{recipe.ingredients&.split("\n")&.join("\n- ")}

---

#{recipe.steps&.split("\n")&.join("\n\n")}
          eos
      end
    end
  end
end
