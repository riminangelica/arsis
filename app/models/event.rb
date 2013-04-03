class Event < ActiveRecord::Base
	attr_accessible :id, :eventclass_id, :name, :starts_at, :ends_at, :venue, :is_open, :user_id
	has_many :attendances
	has_many :users, :through => :attendances
	belongs_to :eventclass

  validates :name, :presence => true, :uniqueness => true
  validates :venue, :presence => true
  validates :starts_at, :presence => true
  validates :ends_at, :presence => true
  validate :valid_date

  def valid_date
    if self.starts_at && self.ends_at
      if self.starts_at > self.ends_at
        errors.add(:start_date, 'must be earlier than end date')
      end
    end
  end

  scope :before, lambda {|end_time| {:conditions => ["ends_at < ?", Event.format_date(end_time)] }}
  scope :after, lambda {|start_time| {:conditions => ["starts_at > ?", Event.format_date(start_time)] }}

  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  
  def self.format_date(date_time)
  	Time.at(date_time.to_i).to_formatted_s(:db)
  end
end
