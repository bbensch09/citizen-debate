class Profile < ActiveRecord::Base
  belongs_to :user
  has_attached_file :avatar, styles: { large: "400x400>", thumb: "80x80>" },  default_url: "/images/:style/missing.png",
          :storage => :s3,
           :url => ':s3_domain_url',
           :path => '/:class/:attachment/:id_partition/:style/:filename',
           :s3_host_name => 's3-us-west-2.amazonaws.com',
           :bucket => 'citizen-debate'

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :first_name, :last_name, :city, :state, :age, :about_me, :display_name, :political_affiliation, :linkedin_profile,
    presence: true

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

  def profile_bonus
    profile_bonus = 0
    if self.about_me.length > 75
      profile_bonus = 10
    end
    if self.verification_status == 'verified'
      profile_bonus +=10
    end
    if self.nps && self.pmf
      profile_bonus +=5
    end
    profile_bonus
  end

  def snippet_bonus
    snippet_bonus = 0
    if self.snippets && self.snippets.length > 50
      snippet_bonus = 10
    end
    snippet_bonus
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

  def update_points
    #free points
    #users get more points for being earlier to sign up; how it works: all users get a point for every user that signs up after them, so with 10 users, the 1st user gets 10 points, and the last user gets zero. when 11th user signs up, each of those users gets one more point.
    puts "updating points"
    if self.id <= 51
      free_points = 51 - self.id
    else
      free_points = 0
    end
    self.points = free_points + self.profile_bonus + self.snippet_bonus + self.topic_bonus + self.referral_bonus
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
