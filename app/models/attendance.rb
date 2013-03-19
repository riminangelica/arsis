class Attendance < ActiveRecord::Base
	attr_accessible :event_id, :user_id, :points, :role
	belongs_to :event
	belongs_to :user

	validates :user_id, :uniqueness => { :scope => :event_id }
	validates :points, :presence => true, :numericality => true
	validates :role, :presence => true
	validates :event_id, :presence => true

	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			attendance = find_by_user_id_and_event_id(row["user_id"], row["event_id"]) || new
			attendance.attributes = row.to_hash.slice(*accessible_attributes)
			attendance.save! :validate => false
		end
	end
end
