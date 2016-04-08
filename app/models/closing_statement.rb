class ClosingStatement < ActiveRecord::Base
  belongs_to :round
  belongs_to :debate
  belongs_to :author, class_name: "Debater", foreign_key: "author_id"

  def time_since_written
    days_elapsed = ((Time.now - created_at.to_time) / (60*60*24)).round
    hours_elapsed = ((Time.now - created_at.to_time) / (60*60)).round
    minutes_elapsed = ((Time.now - created_at.to_time) / (60)).round
      if minutes_elapsed < 60
        return "#{minutes_elapsed} minutes ago."
      elsif hours_elapsed < 24
        return "#{hours_elapsed} hours ago."
      else
        return "#{days_elapsed} days ago."
      end
  end


end
