class Comment < ActiveRecord::Base
  belongs_to :user

  validates :body, presence: true, length: {maximum: 2000}

  class << self
    def remove_excessive!
      if all.count > 100
        order('created_at ASC').limit(all.count - 50).destroy_all
      end
    end
  end

  def time_since_written
    time_elapsed = ((Time.now - created_at.to_time) / (60*60*24)).round
      if time_elapsed < 1
        return "today."
      else
        return "#{time_elapsed} days ago."
      end
  end

end
