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
      # User Story 2, Remove a Patient from a Doctor
      # ​
      # As a visitor
      # When I visit a Doctor's show page
      # Then next to each patient's name, I see a button to remove that patient from that doctor's caseload
      # When I click that button for one patient
      # I'm brought back to the Doctor's show page
      # And I no longer see that patient's name listed
      # And when I visit a different doctor's show page that is caring for the same patient,

      it "Then next to each patient's name, I see a button to remove that patient from that doctor's caseload" do
        visit doctor_path(@doctor1)
        within "#patient-#{@patient1a.id}" do
          expect(page).to have_button("Remove #{@patient1a.name}")
        end
        within "#patient-#{@patient1b.id}" do
          expect(page).to have_button("Remove #{@patient1b.name}")
        end
      end

      describe "When I click that button for one patient" do
        before :each do
          visit doctor_path(@doctor1)
          within "#patient-#{@patient1a.id}" do
            click_button("Remove #{@patient1a.name}")
          end
        end
        it "I'm brought back to the Doctor's show page" do
          expect(current_path).to eq(doctor_path(@doctor1))
        end

        it "And I no longer see that patient's name listed" do
          expect(page).to_not have_content(@patient1a.name)
        end

        describe "And when I visit a different doctor's show page that is caring for the same patient," do
          it "Then I see that the patient is still on the other doctor's caseload" do
            doctor3 = @hospital.doctors.create!(name: "Jack Howard", specialty: 'Love', university: 'Da Streets')
            doctor3.patients << @patient1a

            visit doctor_path(doctor3)

            expect(page).to have_content(@patient1a.name)
          end
        end
      end
    end
  end
end