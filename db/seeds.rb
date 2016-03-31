# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Profile.delete_all
Snippet.delete_all
Topic.delete_all
TopicVote.delete_all

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
  User.create!({
      email: Faker::Internet.safe_email,
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
      display_name: Faker::Internet.user_name,
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

puts "Seed file complete!"
