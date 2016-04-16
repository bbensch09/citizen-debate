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
political_affiliation_array = ['Very liberal','Lean liberal','Moderate','Lean conservative','Very conservative']

User.create!({
      email: "citizen.debate.16@gmail.com",
      password: 'bb4cd109'
    })
  Profile.create!({
      user_id: User.last.id,
      first_name: "Citizen",
      last_name: "Debate",
      city: "San Francisco",
      state: "CA",
      age: 29,
      about_me: "I believe that there is a fine line between optimism and naivety, and have created this site on the premise that everyday citizens are capable of effectively persuading their peers about politics, and pushing the dialog forward. Personally, I am probably about as much of a SF yuppie as you can find. I worked in ad sales for 5+ years and then learned how to code, and am now relatively obsessed with entrepreneurship and learning what the Lean Startup means in practice. I lean fairly liberal , but love argumentation for its own sake, and often find myself arguing for conservative causes simply to better inform my overall perspective. ",
      display_name: "citizen_debate_16",
      political_affiliation: political_affiliation_array.sample,
      # snippets: Faker::Hacker.say_something_smart,
      nps: 10,
      # pmf: ["Very disappointed", "Somewhat disappointed", "Not disappointed", "N/A - I don't know since I haven't used it yet."].sample,
      pmf: "Very disappointed",
      linkedin_profile: "https://www.linkedin.com/in/bbensch09",
      # verification_status: ["not yet verified","verified"].sample
      verification_status: "verified"
    })

  User.create!({
      email: "bbensch@gmail.com",
      password: 'bb4cd109'
    })
  Profile.create!({
      user_id: User.last.id,
      first_name: "Warren",
      last_name: "Schmidt",
      city: "Salt Lake City",
      state: "UT",
      age: 59,
      about_me: "I have worked across diverse industries ranging from insurance to e-commerce, and have led successful teams from just founders to hundreds of employees. While I am proud of my accomplishments that have landed me among the oft-criticized 1%, I just as readily acknowledge the privileges I enjoyed throughout my life, that many more of my fellow Americans did not enjoy. I believe in fiscal responsibility for both individuals and government, and across all issues, seek to maintain a glass half-full view of the world we live in. Looking forward to a healthy exchange of ideas with other members of the community.",
      display_name: "ProgressNotPartisan",
      political_affiliation: "Lean liberal",
      linkedin_profile: "https://www.linkedin.com/in/bbensch09",
      verification_status: "verified"
    })

  User.create!({
      email: "rentmasters.sf@gmail.com",
      password: 'bb4cd109'
    })
  Profile.create!({
      user_id: User.last.id,
      first_name: "Stephen",
      last_name: "Kelley",
      city: "Greenwich",
      state: "CT",
      age: 48,
      about_me: "Since my first job as a newspaper boy at the age of 16, I've gratefully embraced the opportunities this great country continues to create for its citizens and the world. I believe in the American Dream and the constitution. I began my career as an bond trader in 1988, jumped around to a few firms in Chicago in the 1990s, and have been running the hedge found I founded in 2010 for the last six years. While I do not agree with all of the GOP leaders, particularly on social issues such as gay marriage, I have typically lean conservative and believe that free market capitalism is far preferable to the typical waste and inefficiency that comes with big government programs.",
      display_name: "FreeTheMarkets",
      political_affiliation: "Lean Conservative",
      linkedin_profile: "https://www.linkedin.com/in/bbensch09",
      verification_status: "verified"
    })


topics_array = [
  "Taxes should be raised on Americans who earn at least $250k.",
  "Bernie Sanders supporters in California should register for the Republican primary where their vote matters most.",
  "The Senate should hold confirmation hearings for Merrick Garland as the next Supreme Court justice.",
  "The federal minimum wage should be raised to $15",
  "The affordable care act is harmful to small businesses.",
  "Mass shootings in the United States would be prevented by passing new gun control legislation.",
  "Free trade agreements such as NAFTA are harmful to the US employment rate.",
  "The United States should build a wall along the Mexican border",
  "The United States should temporarily ban Muslims entering the country until the threat from ISIS has been mitigated.",
  "The government should increase environmental regulations on  emissions in order to reduce the impact of global warming."
]

topics_array.each do |topic|
  Topic.create!({
    title: topic
    })
  TopicVote.create!({
    value: rand(1..3),
    voter_id: 1,
    topic_id: Topic.last.id
    })
  TopicVote.create!({
    value: rand(1..3),
    voter_id: 2,
    topic_id: Topic.last.id
    })
end

puts "Seed file users & profiles complete!"

# confirm seed debaters
User.all.each do |user|
  Debater.create!({
      user_id: user.id
    })
end
debater_count = Debater.count
puts "There are now #{debater_count} active debaters in the seed setup."

# Update points & rank all profiles after last one is created.
Profile.last.update_points
Profile.last.update_rank
puts "Sample debate #1 complete with three users."

=begin
# #Seed debate #1
Debate.create!({
  affirmative_id: 2,
  negative_id: 3,
  status: "Completed",
  topic_id: 1,
  creator_id: 2,
  challenger_id: 3,
  challenge_accepted: true,
  status: "Completed",
  start_date: Date.today
  })

#first round should be created by default
Round.first.update!({
  debate_id: 1,
  round_number: 1,
  start_time: Time.now,
  status: "Completed"
  })

Round.create!({
  debate_id: 1,
  round_number: 2,
  start_time: Time.now,
  status: "Completed"
  })

Round.create!({
  debate_id: 1,
  round_number: 3,
  start_time: Time.now,
  status: "Completed"
  })

OpeningStatement.create!({
  author_id:1,
  content: "While 'double taxation' sounds like something to be avoided, the reality is that individuals (and corporations) will always have an incentive to invest so long as there are sufficient prospects for a return on their investment. In the housing example given, even with the capital gains tax of 20%, the hypothetical homeowner was still able to double the value of their original $20,000 investment. While turning $20k into $40k may be less desirable than turning $20k into $45k, the reality is that the incentive to invest is still there.
  On a higher-level the debate prompt is not just about whether capital gains should be taxed, but whether they should be taxed at the same rate as ordinary income. Today, there is a substantial difference in the long-term capital gains rate and the ordinary income tax-rates. Because wealthy citizens earn a substantially disproportionate amount of their income from capital gains, this in turn makes the capital gains rate function as a giant tax break for the wealthy. For example, let us consider two hypothetical individuals.
  Harry Hardworker is a general contractor. He works 60 hours a week and gets paid well for his time, earning a handsome $150,000 per year. Given his relatively high income, he has an effective tax rate of 30% and thus pays $45,000 a year in taxes.
  Retired Ralph, a former investment banker, no longer works a 9-5pm job. He has a few million in assets that allowed him to retire at age 45, and earns an identical $150,000 per year in income from his portfolio of stocks and bonds. Ralph does not partake in any short-term trading, since he knows it is disadvantageous tax-wise, and so his effective tax-rate is only 15%. He therefore only pays $22,500 a year in taxes.
  As you can see, two individuals earning the same 'income' end up with grossly different tax obligations. Many would argue that Harry is contributing far more directly to the economy than Ralph, and yet Ralph pays half as much in taxes.",
  round_id: 1,
  debate_id: 1
  })

OpeningStatement.create!({
  author_id:2,
  content: "I will seek to demonstrate the negative case that capital gains should NOT be taxed as ordinary income. There are two primary arguments for treating capital gains differently.
  First, long-term capital gains by definition apply to assets that an individual has purchased with post-tax income, and so the capital gains tax is really a double-taxation on the original source of income.
  Whether those assets are physical by nature (cars, houses, etc.) or whether they are intangible (stocks & bonds, etc.), the income used to purchase those assets was initially taxed when the individual earned that income originally. For example, let's say that I make $100,000 in gross income per year and have a 20% effective tax rate. I use $20,000 of my post-tax dollars to put toward the downpayment on a $200,000 property. Two years later, the housing market has done pretty well and I decide to sell my property for $225,000. Ignoring brokers' commissions and assuming an interest-only mortgage for simplicity, I'd have recorded a capital gain of $25,000, as my $20,000 of equity has become now $45,000 of equity. Even though I already paid $5k in tax on my original $20k of equity, the capital gains tax is going to knock it down further by taxing the appreciation by another 20%, costing me another $5k. When all is said and done, I've paid twice as much tax on my original income because I decided to save & invest it.
  Second and relatedly, this double-taxation effect encourages spending rather than savings and investments, which the government ought to be incentivizing.",
  round_id: 1,
  debate_id: 1,
  })

Message.create!({
  author_id:1,
  message_content: "I have a question for you",
  round_id: 2,
  debate_id: 1
  })

Message.create!({
  author_id:2,
  message_content: "I have an answer",
  round_id: 2,
  debate_id: 1
  })

Message.create!({
  author_id:1,
  message_content: "I have another question for you",
  round_id: 2,
  debate_id: 1
  })

Message.create!({
  author_id:2,
  message_content: "I have another answer",
  round_id: 2,
  debate_id: 1
  })

ClosingStatement.create!({
  author_id:1,
  content: "Finally, we should also keep in mind that there are obvious benefits to the higher tax environment, that come in the form of government spending. In the high tax environment, the government ends up with 20% more funds with which to educate & train the next round of entrepreneurs who are hungry & willing to go out and build businesses. As such, I rest my case that taxing capital gains as ordinary income would be best for the greater economic good.",
  round_id: 3,
  debate_id: 1,
  })

ClosingStatement.create!({
  author_id:2,
  content: "My argument is plain and simple. Business owners create jobs. When we raise capital gains taxes on business owners, they have less incentive to continue investing their time & effort into creating jobs, and are more likely to just sit back and retire. Therefore, if we want to maximize the incentive for business owners to continue working, innovating, and hiring, then we should not raise taxes on them, and if anything should remove the capital gains tax entirely. As a reminder, all capital investments have already been taxed once when the income was earned as personal income, and so capital gains remain a double-tax. Double taxataion that reduces incentives for growth and hiring are bad for the overall economy, and so I urge a no vote on this resolution.",
  round_id: 3,
  debate_id: 1,
  })



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

=end
