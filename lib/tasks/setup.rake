task :setup => :environment do
  system("bundle install --binstubs")
  Rake::Task["db:create"].invoke
  Rake::Task["db:migrate"].invoke
  Rake::Task["db:seed"].invoke
end
