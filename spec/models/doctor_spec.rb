require 'rails_helper'

RSpec.describe Doctor do
  it {should belong_to :hospital}
  it { should have_many :doctor_patients }
  it { should have_many(:patients).through :doctor_patients }

  describe 'instance methods' do
    describe '#patient_count' do
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
      end
      it 'returns an integer of the number of patients a doctor has' do
        expect(@doctor1.patient_count).to eq(2)
        expect(@doctor2.patient_count).to eq(3)
        expect(@doctor3.patient_count).to eq(0)
      end
    end
  end
end
