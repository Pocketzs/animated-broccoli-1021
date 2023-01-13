require 'rails_helper'
# User Story 3, Patient Index Page
# ​
# As a visitor
# When I visit the patient index page
# I see the names of all adult patients (age is greater than 18),
# And I see the names are in ascending alphabetical order (A - Z, you do not need to account for capitalization)
RSpec.describe "patient index page" do
  describe 'As a visitor' do
    describe "When I visit the patient index page" do
      before :each do
        @hospital = Hospital.create!(name: 'Grey Sloan Memorial Hospital')

        @doctor1 = @hospital.doctors.create!(name: 'Meredith Grey', specialty: 'General Surgery', university: 'Harvard University')
        @patient1a = @doctor1.patients.create!(name: 'Katie Bryce', age: 24)
        @patient1b = @doctor1.patients.create!(name: 'Denny Duquette', age: 39)

        @doctor2 = @hospital.doctors.create!(name: 'Alex Karev', specialty: 'Pediatric Surgery', university: 'Johns Hopkins University')
        @patient2a = @doctor2.patients.create!(name: 'Rebecca Pope', age: 32)
        @patient2b = @doctor2.patients.create!(name: 'Zola Shepherd', age: 2)
        @patient2c = @doctor2.patients.create!(name: 'Dean Winchester', age: 18)
        visit patients_path
      end
      it "I see the names of all adult patients (age is greater than 18)" do
        expect(page).to have_content(@patient1a.name)
        expect(page).to have_content(@patient1b.name)
        expect(page).to have_content(@patient2a.name)
        expect(page).to_not have_content(@patient2b.name)
        expect(page).to_not have_content(@patient2c.name)
      end

      it "And I see the names are in ascending alphabetical order(don't need to account for capitalization)" do
        expect(@patient1b.name).to appear_before(@patient1a.name)
        expect(@patient1a.name).to appear_before(@patient2a.name)
      end
    end
  end
end