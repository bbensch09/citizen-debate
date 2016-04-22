class OpeningStatement < ActiveRecord::Base
  include ActionView::Helpers::SanitizeHelper
  belongs_to :round
  belongs_to :debate
  belongs_to :author, class_name: "Debater", foreign_key: "author_id"
  validate :check_word_count, on: [:update, :create]
  after_create :send_opponent_notification

  def send_opponent_notification
      @opening_statement = OpeningStatement.last
      UserMailer.opening_statement_complete(@opening_statement).deliver_now
      puts "opponent has been sent notification of statement submission."
  end

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

  def check_word_count
    raw_text = strip_tags(self.content)
    word_count = raw_text.split(" ").length
    puts "word_count is #{word_count}"
    errors.add(:status,"Please shorten your statement to no more than 250 words. The current word count is #{word_count}.") unless (word_count <=250)
  end

end
