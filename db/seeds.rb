# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Profile.delete_all
Topic.delete_all
TopicVote.delete_all
Judge.delete_all
Debater.delete_all
Debate.delete_all
Verdict.delete_all
Round.delete_all
Message.delete_all
DebateVote.delete_all
CivilityVote.delete_all

#CREATE LIST OF OPTIONS TO RANDOMLY SELECT FROM
age_array = (18...65).to_a
political_affiliation_array = ['Democrat','Democrat','Republican','Republican','Independent']

User.create!({
      email: "citizen.debate.16@gmail.com",
      password: 'password'
    })
  Profile.create!({
      user_id: User.last.id,
      first_name: "Brian",
      last_name: "Bensch",
      city: "San Francisco",
      state: "CA",
      age: 29,
      about_me: Faker::Hacker.say_something_smart,
      display_name: "sf_skier2016",
      political_affiliation: political_affiliation_array.sample,
      snippets: Faker::Hacker.say_something_smart,
      nps: rand(1..10),
      pmf: ["Very disappointed", "Somewhat disappointed", "Not disappointed", "N/A - I don't know since I haven't used it yet."].sample,
      linkedin_profile: "https://www.linkedin.com/in/bbensch09",
      verification_status: ["not yet verified","verified"].sample
    })

5.times do
  number = User.count + 1
  User.create!({
      email: "citizen.debate.16+test#{number}@gmail.com",
      password: 'password'
    })
  Profile.create!({
      user_id: User.last.id,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      age: age_array.sample,
      about_me: Faker::Hacker.say_something_smart,
      display_name: "seed_user_#{number}",
      political_affiliation: political_affiliation_array.sample,
      snippets: Faker::Hacker.say_something_smart,
      nps: rand(1..10),
      pmf: ["Very disappointed", "Somewhat disappointed", "Not disappointed", "I don't know"].sample,
      linkedin_profile: "https://www.linkedin.com/in/example",
      verification_status: ["not yet verified","verified"].sample
    })
  Profile.last.update_points
end

# Rank all profiles after last one is created.
Profile.last.update_rank

topics_array = [
  "Should wealthy Americans earning >$250k per year pay more in tax?",
  "Should Bernie Sanders supporters in California register for the Republican primary to vote against Trump?",
  "Should the Senate hold confirmation hearings for Merrick Garland as the next Supreme Court justice?",
  "Would raising the minimum wage to $15 have a positive impact on GDP?",
  "Has the affordable care act caused measurable harm to small businesses?",
  "Does the incidence of mass shootings decline in countries that have passed gun control legislation?",
  "Has the NAFTA free trade agreement been harmful to the US employment rate?",
  "Should the US build a wall along the Mexican border?",
]

topics_array.each do |topic|
  Topic.create!({
    title: topic
    })
  TopicVote.create!({
    value: rand(0..15),
    voter_id: 1,
    topic_id: Topic.last.id
    })
end

puts "Seed file users & profiles complete!"

# #Seed Judges
# Judge.create!({
#   id:1,
#   user_id:1,
#   slant_profile: "Liberal",
#   slant_historical: "None"
#   })

# Judge.create!({
#   id:2,
#   user_id:2,
#   slant_profile: "Conservative",
#   slant_historical: "None"
#   })

# #Seed debaters
# Debater.create!({
#   id:1,
#   user_id:3
#   })
# Debater.create!({
#   id:2,
#   user_id:4
#   })

# #Seed debate #1
# Debate.create!({
#   affirmative_id: 1,
#   negative_id: 2,
#   judge_left_id: 1,
#   judge_right_id: 2,
#   status: "Completed",
#   topic_id: 1
#   })

# Round.create!({
#   debate_id: 1,
#   round_number: 1,
#   start_time: Time.now,
#   status: "Completed"
#   })

# Round.create!({
#   debate_id: 1,
#   round_number: 2,
#   start_time: Time.now,
#   status: "Completed"
#   })

# Round.create!({
#   debate_id: 1,
#   round_number: 3,
#   start_time: Time.now,
#   status: "Completed"
#   })

# Message.create!({
#   author_id:1,
#   message_content: "TO-DO: INSERT seed args from http://debatewise.org/debates/1013-we-should-dramatically-increase-the-rate-of-income-tax-paid-by-the-rich/",
#   round_id: 1
#   })

# Message.create!({
#   author_id:2,
#   message_content: "TO-DO: INSERT seed args from http://debatewise.org/debates/1013-we-should-dramatically-increase-the-rate-of-income-tax-paid-by-the-rich/",
#   round_id: 2
#   })

# Message.create!({
#   author_id:1,
#   message_content: "TO-DO: INSERT seed args from http://debatewise.org/debates/1013-we-should-dramatically-increase-the-rate-of-income-tax-paid-by-the-rich/",
#   round_id: 3
#   })

# Verdict.create!({
#   debate_id: 1,
#   status: "Unanimous, pending voter confirmation.",
#   opinion_left: "The affirmative was great!",
#   opinion_right: "The affirmative was civil, but didn't make many compelling points.",
#   winner_id: 1
#   })

# #Civility votes for debater #1 (from judges and debate participants)
# CivilityVote.create!({
#   debate_id: 1,
#   debater_id: 1,
#   voter_id: 2,
#   rating: 4
#   })
# CivilityVote.create!({
#   debate_id: 1,
#   debater_id: 1,
#   voter_id: 3,
#   rating: 5
#   })
# CivilityVote.create!({
#   debate_id: 1,
#   debater_id: 1,
#   voter_id: 4,
#   rating: 4
#   })
# #Civility votes for debater #2 (from judges and debate participants)
# CivilityVote.create!({
#   debate_id: 1,
#   debater_id: 2,
#   voter_id: 1,
#   rating: 3
#   })
# CivilityVote.create!({
#   debate_id: 1,
#   debater_id: 2,
#   voter_id: 3,
#   rating: 4
#   })
# CivilityVote.create!({
#   debate_id: 1,
#   debater_id: 2,
#   voter_id: 4,
#   rating: 3
#   })

# #Debate votes (from non-participant users)
# DebateVote.create!({
#   user_id: 5,
#   debate_id: 1,
#   vote_for: 1
#   })
# DebateVote.create!({
#   user_id: 6,
#   debate_id: 1,
#   vote_for: 1
#   })

# puts "Sample debate #1 complete with judges, debaters, rounds, verdict created."
