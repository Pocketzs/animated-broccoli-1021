class PatientsController < ApplicationController
  def index
    @patients = Patient.adults_by_alpha_name
  end
end