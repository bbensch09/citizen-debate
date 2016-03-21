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
      email: "bbensch@gmail.com",
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
      display_name: Faker::Internet.user_name,
      political_affiliation: political_affiliation_array.sample,
      snippets: Faker::Hacker.say_something_smart,
      nps: rand(1..10),
      pmf: ["Very disappointed", "Somewhat disappointed", "Not dissappointed", "N/A - I don't know since I haven't used it yet."].sample
    })

50.times do
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
      rank: User.last.id,
      nps: rand(1..10),
      pmf: ["Very disappointed", "Somewhat disappointed", "Not dissappointed", "N/A - I don't know since I haven't used it yet."].sample
    })
end


topics_array = [
  "Should Apple build a software update to allow FBI access to suspects’ iPhones?",
  "Is Edward Snowden a hero or a traitor?",
  "Should the Senate hold confirmation hearings for Merrick Garland as the next Supreme Court justice?",
  "Should the government increase taxes wealthy citizens who earning > $250K/yr?",
  "Should the government overturn Obamacare?",
  "Should the public tax dollars be used to provide health care for citizens?",
  "Should abortion be legal?",
  "Should background checks be required in order to purchase a gun?",
  "Should Citizens United be repealed and limits placed on individual and corporate campaign contributions?",
  "Should same-sex marriage be legal?",
  "Is free trade goods harmful or beneficial to the creation of jobs in the US?",
  "Should the United States make significant economic sacrifices if doing so is necessary to lessen the impact of climate change?",
  "Is the Black Lives Matter movement helping or hurting racial tensions in the U.S.?",
  "Should the US increase the minimum wage to $15",
  "Should the US build a wall along the Mexican border?",
  "Should marijuana be legalized at the federal level?",
  "Should the US enlist ground troops in the effort to defeat ISIS?",
  "Should the long-term capital gains rate be increased from 15% to an individual's marginal income rate?"
]

topics_array.each do |topic|
  Topic.create!({
    title: topic
    })
end

# 200.times do
# TopicVote.create({
#   value: [1,-1].sample
#   })
# end

puts "Seed file complete!"
