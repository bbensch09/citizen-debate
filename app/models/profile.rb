class Profile < ActiveRecord::Base
  belongs_to :user
  has_attached_file :avatar, styles: { large: "400x400>", thumb: "80x80>" },  default_url: "/images/:style/missing.png",
          :storage => :s3,
           :url => ':s3_domain_url',
           :path => '/:class/:attachment/:id_partition/:style/:filename',
           :s3_host_name => 's3-us-west-2.amazonaws.com'

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  # before_save :update_points

  def profile_bonus
    profile_bonus = 0
    if self.about_me.length > 75
      profile_bonus = 10
    end
    profile_bonus
  end

  def snippet_bonus
    snippet_bonus = 0
    if self.snippets && self.snippets.length > 40
      snippet_bonus = 5
    end
    snippet_bonus
  end

  def update_points
    #free points
    #users get more points for being earlier to sign up; how it works: all users get a point for every user that signs up after them, so with 10 users, the 1st user gets 10 points, and the last user gets zero. when 11th user signs up, each of those users gets one more point.
    puts "updating points"
    free_points = 51 - self.id
    self.points = free_points + self.profile_bonus + self.snippet_bonus
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
