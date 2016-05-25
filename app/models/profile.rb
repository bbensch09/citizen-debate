class Profile < ActiveRecord::Base
  belongs_to :user
  has_attached_file :avatar, styles: { large: "400x400>", thumb: "80x80>" },  default_url: "https://s3-us-west-2.amazonaws.com/citizen-debate/static_images/profile-blank.jpg",
          :storage => :s3,
           :url => ':s3_domain_url',
           :path => '/:class/:attachment/:id_partition/:style/:filename',
           :s3_host_name => 's3-us-west-2.amazonaws.com',
           :bucket => 'citizen-debate'

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates  :display_name,
    presence: true #:linkedin_profile, :first_name, :last_name, :city, :state, :age, :about_me, :political_affiliation,
  after_update :send_admin_profile_notification

  def send_admin_profile_notification
      @profile = Profile.last
      UserMailer.new_profile_created(@profile).deliver_now
      puts "an admin profile notification has been sent."
  end

  def self.to_csv
    attributes = %w{id first_name last_name display_name email city state age political_affiliation points snippets nps pmf created_at}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |profile|
        csv << attributes.map{ |attr| profile.send(attr)}
      end
    end
  end

  def email
    self.user.email
  end

  def liberal_score
        case self.political_affiliation
        when 'Very liberal'
            return 5
        when 'Lean liberal'
            return 4
        when 'Moderate'
            return 3
        when 'Lean conservative'
            return 2
        when 'Very conservative'
            return 1
        end
  end

  def profile_bonus
    profile_bonus = 0
    if self.about_me.length > 75
      profile_bonus = 5
    end
    if self.verification_status == 'verified'
      profile_bonus +=5
    end
    profile_bonus
  end

  def feedback_bonus
    feedback_bonus = 0
    if self.snippets && self.snippets.length > 50
      feedback_bonus = 5
    end
    if self.nps && self.pmf
      feedback_bonus +=5
    end
    feedback_bonus
  end

  def topic_bonus
    topic_bonus = 0
    if self.user.topic_votes.count >= 1
      topic_bonus = [4,self.user.topic_votes.count*2].min
    end
    topic_bonus
  end

  def referral_bonus
    return self.extra_info
  end

  def debate_points

  end

  def civility_points
      #affirmative debate ratings
      aff_ratings = CivilityVote.where("affirmative_id = ?",self.user.debater.id)
      #negative debate ratings
      neg_ratings = CivilityVote.where("negative_id = ?",self.user.debater.id)
      civility_points = 0
      if aff_ratings.count >= 1
        aff_ratings.each do |rating|
          civility_points += rating.affirmative_rating.to_f
        end
      end
      if neg_ratings.count >= 1
        neg_ratings.each do |rating|
          civility_points += rating.negative_rating.to_f
        end
      end
      return civility_points
  end

  def civility_rating
      #affirmative debate ratings
      aff_ratings = CivilityVote.where("affirmative_id = ?",self.user.debater.id)
      #negative debate ratings
      neg_ratings = CivilityVote.where("negative_id = ?",self.user.debater.id)
      civility_points = 0
      aff_ratings.each do |rating|
        if rating.affirmative_rating
          civility_points += rating.affirmative_rating
        end
      end
      neg_ratings.each do |rating|
        if rating.negative_rating
          civility_points += rating.negative_rating
        end
      end
      debate_count = aff_ratings.count + neg_ratings.count
      civility_rating = (civility_points.to_f / debate_count.to_f).round(2)
      # returns the average star rating for a given user
      return civility_rating
  end

  def debate_points
    # identify debates in which user was affirmative
    participated_aff_debates = Debate.where("affirmative_id = ?",self.user.debater.id)
    aff_debate_votes = []
    participated_aff_debates.each do |debate|
       each_aff_debates_votes = DebateVote.where("debate_id = ?",debate.id)
       each_aff_debates_votes.each do |vote|
        aff_debate_votes << vote
       end
    end
    puts "user has received #{aff_debate_votes.count} votes in #{participated_aff_debates.count} affirmative debates."

    # identify debates in which user was negative
    participated_neg_debates = Debate.where("negative_id = ?",self.user.debater.id)
    neg_debate_votes = []
    participated_neg_debates.each do |debate|
       each_neg_debates_votes = DebateVote.where("debate_id = ?",debate.id)
       each_neg_debates_votes.each do |vote|
        neg_debate_votes << vote
       end
     end
    puts "user has received #{neg_debate_votes.count} votes in #{participated_neg_debates.count} affirmative debates."

    #calculate aff points based on delta between before and after
    aff_points = 0
    aff_debate_votes.each do |vote|
      if vote.vote_before == "I am not sure"
          case vote.vote_after
          when "I agree"
            aff_points += 5
          when "I am not sure"
            aff_points += 0
          end
      elsif vote.vote_before == "I disagree"
          case vote.vote_after
          when "I agree"
            aff_points += 10
          when "I am not sure"
            aff_points += 5
          end
      else
        aff_points += 0
      end
    end
    #calculate neg points based on delta between before and after
    neg_points = 0
    neg_debate_votes.each do |vote|
      if vote.vote_before == "I am not sure"
          case vote.vote_after
          when "I disagree"
            neg_points += 5
          when "I am not sure"
            neg_points += 0
          end
      elsif vote.vote_before == "I agree"
          case vote.vote_after
          when "I disagree"
            neg_points += 10
          when "I am not sure"
            neg_points += 5
          end
      else
        neg_points += 0
      end
    end

  # calculate total points as sum of aff + neg points
  debate_points = (aff_points + neg_points)/5
  end

  def minds_changed
    return self.debate_points
  end

  def update_points
    puts "updating points"
    # original formula for pre-launch phase
    # self.points = self.profile_bonus + self.feedback_bonus + self.topic_bonus + self.referral_bonus + self.civility_points + self.debate_points
    # Alternative = points = minds changed + civility rating
    # self.points = (self.civility_rating * self.user.debater.debates.count) + self.debate_points
    self.points = self.debate_points
    self.save
    puts "points updated and saved. Profile ID #{self.id} has #{self.points}"
  end

  def update_rank
    #sort users by most points to least points
    sorted = Profile.all.sort { |a,b| b.points <=> a.points}
    sorted.each do |profile|
      profile.rank = sorted.index(profile) + 1
      profile.save
    puts "profile rank saved.  Profile ID #{profile.id} is ranked #{profile.rank}."
    end
    # self.rank = sorted.index(self) + 1
    # self.save
  end
end
