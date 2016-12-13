namespace :yard do

  desc "Generate yard documentation"
  task create: :environment do
    exec 'yard'
  end

end
