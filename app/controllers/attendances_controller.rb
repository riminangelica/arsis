class AttendancesController < ApplicationController
  # Generate Dormer Database Page
  # Imports CSV File to the database
  def import
    Attendance.import(params[:file])
    flash[:notice] = "Attendances imported."
    flash[:color] = "valid"
    redirect_to regfile_path
  end
end
