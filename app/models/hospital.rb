class Hospital < ApplicationRecord
  has_many :doctors
  has_many :patients, through: :doctors

  def doctors_by_patient_count
    self.doctors.left_joins(:patients).select('doctors.*, count(patients.id) as patient_count').group(:id).order('patient_count desc')
  end
end
