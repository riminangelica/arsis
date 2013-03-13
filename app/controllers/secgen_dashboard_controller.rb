class SecgenDashboardController < ApplicationController
	before_filter :authenticate_user, :check_sec_gen
	def index

	end

	def import_dormers

	end

	def import
		dormerlist = params[:file].read

		CSV.parse(dormerlist) do |row|

		end

		

	end
end