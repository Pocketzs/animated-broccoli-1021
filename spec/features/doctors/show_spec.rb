require 'rails_helper'
# User Story 1, Doctors Show Page
# ​
# As a visitor
# When I visit a doctor's show page
# I see all of that doctor's information including:
#  - name
#  - specialty
#  - university where they got their doctorate
# And I see the name of the hospital where this doctor works
# And I see the names of all of the patients this doctor has
RSpec.describe 'doctor show page' do
  describe 'As a visitor' do
    describe 'When I visit a doctors show page' do
      before :each do
        @hospital = Hospital.create!(name: 'Grey Sloan Memorial Hospital')

        @doctor1 = @hospital.doctors.create!(name: 'Meredith Grey', specialty: 'General Surgery', university: 'Harvard University')
        @patient1a = @doctor1.patients.create!(name: 'Katie Bryce', age: 24)
        @patient1b = @doctor1.patients.create!(name: 'Denny Duquette', age: 39)

        @doctor2 = @hospital.doctors.create!(name: 'Alex Karev', specialty: 'Pediatric Surgery', university: 'Johns Hopkins University')
        @patient2a = @doctor2.patients.create!(name: 'Rebecca Pope', age: 32)
        @patient2b = @doctor2.patients.create!(name: 'Zola Shepherd', age: 2)
      end
      it 'I see all of that doctors info' do
        visit doctor_path(@doctor1)

        expect(page).to have_content(@doctor1.name)
        expect(page).to have_content(@doctor1.specialty)
        expect(page).to have_content(@doctor1.university)
        expect(page).to_not have_content(@doctor2.name)
        expect(page).to_not have_content(@doctor2.specialty)
        expect(page).to_not have_content(@doctor2.university)

        visit doctor_path(@doctor2)

        expect(page).to have_content(@doctor2.name)
        expect(page).to have_content(@doctor2.specialty)
        expect(page).to have_content(@doctor2.university)
        expect(page).to_not have_content(@doctor1.name)
        expect(page).to_not have_content(@doctor1.specialty)
        expect(page).to_not have_content(@doctor1.university)
      end

      it 'And I see the name of the hospital where this doctor works' do
        visit doctor_path(@doctor1)

        expect(page).to have_content(@hospital.name)
      end

      it 'And I see the names of all of the patients this doctor has' do
        visit doctor_path(@doctor1)

        expect(page).to have_content(@patient1a.name)
        expect(page).to have_content(@patient1b.name)
        expect(page).to_not have_content(@patient2a.name)
        expect(page).to_not have_content(@patient2b.name)
      end
    end
  end
end