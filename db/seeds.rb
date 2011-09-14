# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(:original => "anteseraotro", :original_uid => "18735167",
                   :translated => "guilleiguaran", :translated_uid => "252932427",
                   :lang_from => 'es', :lang_to => 'en',
                   :token => "252932427-3ppZwS3RdAOieWtBOb7QrGhcS645xCn5T8Hl9w0t",
                   :secret => "mQDBJz6P4duLaIzO1m9xBJBSmoP75qKrMtYWZPBts")

user.add_to_watching
