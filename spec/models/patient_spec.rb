require 'rails_helper'

RSpec.describe Patient do
  it { should have_many :doctor_patients }
  it { should have_many(:doctors).through :doctor_patients }

  describe "class methods" do
    describe ".adults_by_alpha_name" do
      before :each do
        @hospital = Hospital.create!(name: 'Grey Sloan Memorial Hospital')

        @doctor1 = @hospital.doctors.create!(name: 'Meredith Grey', specialty: 'General Surgery', university: 'Harvard University')
        @patient1a = @doctor1.patients.create!(name: 'Katie Bryce', age: 24)
        @patient1b = @doctor1.patients.create!(name: 'Denny Duquette', age: 39)

        @doctor2 = @hospital.doctors.create!(name: 'Alex Karev', specialty: 'Pediatric Surgery', university: 'Johns Hopkins University')
        @patient2a = @doctor2.patients.create!(name: 'Rebecca Pope', age: 32)
        @patient2b = @doctor2.patients.create!(name: 'Zola Shepherd', age: 2)
        @patient2c = @doctor2.patients.create!(name: 'Dean Winchester', age: 18)
      end
      it 'returns all patients over the age of 18 in alphabetical order' do
        expect(Patient.adults_by_alpha_name).to eq([@patient1b, @patient1a, @patient2a])
      end
    end
  end
end