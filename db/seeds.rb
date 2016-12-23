require 'faker'


User.create username: 'madeindjs', firstname: 'Alexandre',lastname: 'Rousseau', email: 'madeindjs@gmail.com', password: "20462046", password_confirmation: '20462046'


100.times do 

	User.create(
		username: Faker::Internet.user_name , 
		firstname: Faker::Name.first_name,
		email: Faker::Internet.email,
		password: "20462046", 
		password_confirmation: '20462046'
	)

end



300.times do

	steps = Array.new
	5.times{ steps << Faker::Food.measurement }

	ingredients = Array.new
	10.times{ingredients << Faker::Food.ingredient }

	Recipe.create(
		name: Faker::Book.title,
		user_id: Random.new.rand(1...100) ,
		description: Faker::Hipster.sentence,
		ingredients: ingredients.join("\r\n"),
		steps: steps.join("\r\n"),
	)
end