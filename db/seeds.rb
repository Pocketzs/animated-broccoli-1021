# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@hospital = Hospital.create!(name: 'Grey Sloan Memorial Hospital')

@doctor1 = @hospital.doctors.create!(name: 'Meredith Grey', specialty: 'General Surgery', university: 'Harvard University')
@patient1a = @doctor1.patients.create!(name: 'Katie Bryce', age: 24)
@patient1b = @doctor1.patients.create!(name: 'Denny Duquette', age: 39)

@doctor2 = @hospital.doctors.create!(name: 'Alex Karev', specialty: 'Pediatric Surgery', university: 'Johns Hopkins University')
@patient2a = @doctor2.patients.create!(name: 'Rebecca Pope', age: 32)
@patient2b = @doctor2.patients.create!(name: 'Zola Shepherd', age: 2)
@patient2c = @doctor2.patients.create!(name: 'Dean Winchester', age: 18)