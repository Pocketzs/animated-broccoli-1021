require 'rails_helper'
# Extension, Hospital Show Page
# ​
# As a visitor
# When I visit a hospital's show page
# I see the hospital's name
# And I see the names of all doctors that work at this hospital,
# And next to each doctor I see the number of patients associated with the doctor,
# And I see the list of doctors is ordered from most number of patients to least number of patients
# (Doctor patient counts should be a single query)
RSpec.describe 'hospital show page' do
  describe 'As a visitor' do
    describe 'When I visit a hospitals show page' do
      before :each do
        @hospital1 = Hospital.create!(name: 'Grey Sloan Memorial Hospital')
        @hospital2 = Hospital.create!(name: 'Murderville Hospital of Horrors')

        @doctor1 = @hospital1.doctors.create!(name: 'Meredith Grey', specialty: 'General Surgery', university: 'Harvard University')
        @patient1a = @doctor1.patients.create!(name: 'Katie Bryce', age: 24)
        @patient1b = @doctor1.patients.create!(name: 'Denny Duquette', age: 39)

        @doctor2 = @hospital1.doctors.create!(name: 'Alex Karev', specialty: 'Pediatric Surgery', university: 'Johns Hopkins University')
        @patient2a = @doctor2.patients.create!(name: 'Rebecca Pope', age: 32)
        @patient2b = @doctor2.patients.create!(name: 'Zola Shepherd', age: 2)
        @patient2c = @doctor2.patients.create!(name: 'Dean Winchester', age: 18)

        @doctor3 = @hospital1.doctors.create!(name: "Freddy Krueger", specialty: 'Dreams', university: 'Bloody Screams University')
        visit hospital_path(@hospital1)
      end
      it 'I see the hospitals name' do
        expect(page).to have_content(@hospital1.name)
      end

      it 'And I see the names of all doctors that work at this hospital' do
        expect(page).to have_content(@doctor1.name)
        expect(page).to have_content(@doctor2.name)
        expect(page).to have_content(@doctor3.name)
      end

      it 'And next to each doctor I see the number of patients associated with the doctor' do
        within "#doctor-#{@doctor1.id}" do
          expect(page).to have_content("Patient Count: 2")
        end
        within "#doctor-#{@doctor2.id}" do
          expect(page).to have_content("Patient Count: 3")
        end
        within "#doctor-#{@doctor3.id}" do
          expect(page).to have_content("Patient Count: 0")
        end
      end

      it 'And I see the list of doctors is ordered from most number of patients to least number of patients' do
        expect(@doctor2.name).to appear_before(@doctor1.name)
        expect(@doctor1.name).to appear_before(@doctor3.name)
      end
    end
  end
end