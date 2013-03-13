class Attendance < ActiveRecord::Base
	attr_accessible :event_id, :user_id, :points, :role
	belongs_to :event
	belongs_to :user

	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			attendance = find_by_id(row["id"]) || new
			attendance.attributes = row.to_hash.slice(*accessible_attributes)
			attendance.save! :validate => false
		end
	end
end
