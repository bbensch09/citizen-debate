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
      display_name: "LiberalLeader",
      political_affiliation: "Lean liberal",
      linkedin_profile: "https://www.linkedin.com/in/bbensch09",
      verification_status: "verified"
    })

  User.create!({
      email: "pucktimes@gmail.com",
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

# #Seed debate #1
Debate.create!({
  affirmative_id: 2,
  status: "Completed",
  topic_id: 1,
  creator_id: 2,
  challenger_id: 3,
  challenge_accepted: true,
  challenger_email: "",
  status: "Completed",
  })

Debate.last.update!({
  negative_id: 3,
  })

#first round should be created by default
Round.create!({
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
  author_id:2,
  content: "<p dir=\"ltr\">With their 2015 tax returns officially in the books, most Americans have now digested the painful&nbsp;annual reminder that their inflation-adjusted incomes have remained stagnant for yet another year. Despite living in&nbsp;the strongest economy in the world, whose stock market has more than doubled since 2009, the median American&rsquo;s income has remained&nbsp;below pre-recession levels at just $53,657 in 2014 vs. $57,357 in 2007(<a href=\"https://research.stlouisfed.org/fred2/series/MEHOINUSA672N\">source</a>). Meanwhile, the top 1% of income earners in the country now earn a whopping 20% of total income (<a href=\"https://upload.wikimedia.org/wikipedia/commons/e/e7/U.S._Income_Shares_of_Top_1%25_and_0.1%25_1913-2013.png\">source</a>). This concentration of wealth at the top&nbsp;gives&nbsp;the U.S. the second-worst level of income inequality among the 31 developed economies in the OECD (<a href=\"http://www.pewresearch.org/fact-tank/2013/12/19/global-inequality-how-the-u-s-compares/\">source</a>). As a final important piece of context, the federal debt has doubled from $9 trillion to over $18 trillion since 2007, representing a long-term financial burden for future generations that will continue to worsen until we reach a balanced budget. It is in this context that I support the resolution: taxes should be raised on wealthy Americans earning at least $250,000 per year.</p>\r\n\r\n<p dir=\"ltr\"><img alt=\"\" src=\"http://citizen-debate.s3-us-west-2.amazonaws.com/ckeditor/pictures/data/000/000/001/content/historical-tax-rates.gif\" style=\"float: right; margin-left: 10px; margin-right: 10px; height: 306px; width: 500px;\" />Not only is raising taxes on the wealthy a prudent path toward a balanced budget, historical precedent also suggests that the there are minimal if any negative effects of such tax increases on the greater economy. </p>\r\n",
  round_id: 1,
  debate_id: 1
  })

OpeningStatement.create!({
  author_id:3,
  content: "<p dir=\"ltr\">Unlike the mass media would have you believe, the wealthy top few percent of income earners in this country are not the root cause of the anemic economic recovery we have seen over the past seven years. I will demonstrate the negative case for why taxes should not be raised on wealthy Americans in two ways. First, the academic research on the topic overwhelmingly agrees that tax increases hamper economic growth. Next, we will look at the current distribution of taxes and see that the wealthy are already paying more than their fair share. Finally, I will propose a few alternative mechanisms of fiscal responsibility that get us closer to a balanced budget without handcuffing the dynamic strength of our economy.</p>\r\n\r\n<p dir=\"ltr\">As happens all too often in discussions of taxes in the mainstream media, each side sticks to their talking points without really identifying any substantive research to support their position. As neither myself nor my opposition have advanced degrees in economics, I&rsquo;d instead urge that we trust the deep body of academic research that exists on the topic. I presume that&nbsp;we&nbsp;share the same&nbsp;objective of maximizing growth in our economy. The core question is, what types of tax policies actually promote the most growth? William McBride of the Tax Foundation performed a meta-analysis of 26 studies on the empirical relationship between taxes and economic growth since 1983, and found that all but 3 of those studies found a negative impact of taxes on growth (<a href=\"http://taxfoundation.org/article/what-evidence-taxes-and-growth\">source</a>). The majority of these studies demonstrated that a 1% increase in the effective tax base (as a % of GDP) produced at least a 1% decrease in GDP output. </p>\r\n",
  round_id: 1,
  debate_id: 1,
  })

Message.create!({
  author_id:2,
  message_content: "Is the Tax Foundation really a credible source? This Forbes article (http://www.forbes.com/sites/peterjreilly/2016/02/16/how-valid-is-tax-foundation-dynamic-scoring/#265ba47b71b9) points out that their “dynamic” scoring model assumes zero positive impact on the economy from government spending. Their model therefore by definition assumes all tax cuts are good, and all tax increases are bad. How can such an absolutist view be objective?",
  round_id: 2,
  debate_id: 1
  })

Message.create!({
  author_id:3,
  message_content: "I could make the same argument that Forbes is just as biased on the liberal side. Many studies have shown that the mainstream media has a liberal bias. (http://www.nydailynews.com/news/politics/journalists-gop-party-affiliations-decline-study-article-1.1781826)",
  round_id: 2,
  debate_id: 1
  })

Message.create!({
  author_id:2,
  message_content: "Agreed. I guess that’s probably the point of this site -- let's try and let our arguments & facts speak for themselves, and not to rely exclusively on a single media source.",
  round_id: 2,
  debate_id: 1
  })

Message.create!({
  author_id:2,
  message_content: "I understand you don’t think marginal rates should be raised on the wealthy, but what about the capital gains tax? Would removing the preferential treatment of capital gains be a suitable alternative for closing the federal deficit?",
  round_id: 2,
  debate_id: 1
  })

Message.create!({
  author_id:3,
  message_content: "Not at all, it would be even worse than raising income taxes. Capital investment is the fundamental driver of economic growth. While I agree that the capital gains tax should continue to be progressive, as it is today, taking capital gains at the same rate of ordinary income would be disastrous. First, capital gains is double-taxation. Corporations must already pay income tax on profits. So once they pay their 35% corporate tax, when you as an investor decide to sell that share of stock, you get hit with another 20% tax, meaning that $1 of corporate profit gets taxed at 55% just at the federal level, and then states get their crack at it.",
  round_id: 2,
  debate_id: 1
  })
Message.create!({
  author_id:2,
  message_content: "But would investors really stop investing if there were a slightly higher capital gains rate? So long as savings interest rates are so low, people with investable assets are always going to put that money to work rather than put it in the couch (or a bank that gives them 0.2% interest). Aren’t they?",
  round_id: 2,
  debate_id: 1
  })

Message.create!({
  author_id:3,
  message_content: "Yes that’s likely true, but if we want to fairly tax capital gains, we need to first recognize that inflation often eats up a huge portion of the nominal capital gain, and so we should really just be taxing the inflation-adjusted gain. For example, say I invest $10,000 and it doubles to $20,000 over 10 years. If inflation also rose 40% in that time, then my original $10k really represents $14k of current purchasing power, and so the real gain is only $6,000. Paying tax on the nominal gain means I’m being taxed an extra 40% over what the real gain was.",
  round_id: 2,
  debate_id: 1
  })
Message.create!({
  author_id:2,
  message_content: "I’d actually agree with that. If capital gains were indexed to inflation and thus only the real gains were taxed, would you agree that it would then be reasonable to tax them as ordinary income?",
  round_id: 2,
  debate_id: 1
  })
Message.create!({
  author_id:3,
  message_content: "Seems reasonable to me.",
  round_id: 2,
  debate_id: 1
  })

ClosingStatement.create!({
  author_id:2,
  content: "<p dir=\"ltr\">I will first respond to the negative&rsquo;s core argument that tax increases hinder economic growth. I will then review a hypothetical scenario to demonstrate the futility of supply-side theory, before recapping the historical evidence that suggests tax increases on the wealthy have not and will not have negative consequences on our economy.</p>\r\n\r\n<p dir=\"ltr\">First, when we evaluate the body of academic research on tax policy and growth, it is not nearly as black and white as the negative would have you review. The Center on Budget and Policy Priorities authored a response to the Tax Foundation meta-study, and found that the Tax Foundation misrepresented 9 of their cited 26 studies, and in fact 12 of the 26 studies do not support the assertion that all tax increases harm growth (<a href=\"http://www.cbpp.org/research/what-really-is-the-evidence-on-taxes-and-growth\">source</a>). In thoroughly evaluating these same studies, the CBPP concludes &ldquo;there is simply no consensus that, as a general proposition, cutting taxes is a good strategy to boost economic growth.&rdquo; Additionally, even the Tax Foundation explicitly acknowledges that its models do not &ldquo;currently estimate the effects of changes in private and government spending policies&rdquo;, which is as if to say that when the government extracts more money from citizens, that money simply goes down the toilet and has no possible positive impact on the economy. Instead, I believe that the preponderance of evidence suggests that the contrary is more likely to be true, and thus urge readers to vote for the affirmative: taxes should be raised on wealthy Americans earning at least $250,000 a year.</p>\r\n",
  round_id: 3,
  debate_id: 1,
  })

ClosingStatement.create!({
  author_id:3,
  content: "<p dir=\"ltr\">I will close by responding to the affirmative critique of the academic research and address the dangers implicit to tax increases that could wreak havoc on the fragile state of our economy.</p>\r\n\r\n<p dir=\"ltr\">First, with respect to the credibility of the Tax Foundation, it is a registered non-profit organization that has been long-recognized as a non-partisan think-tank since its founding in 1937. It is committed to tax principles of simplicity, neutrality, transparency, and stability, and holds a four-star rating (the highest possible) from Charity Navigator, a third party evaluator of charities. Understandably, tax policies can quickly become partisan in today&rsquo;s world, and the tax foundation makes every attempt to produce objective and insightful research. Their current Tax and Growth model has acknowledge limitations, and they are actively working to incorporate government spending into their dynamic scoring model.</p>\r\n\r\n<p dir=\"ltr\"><img alt=\"\" src=\"http://citizen-debate.s3-us-west-2.amazonaws.com/ckeditor/pictures/data/000/000/003/content/tax-foundation-comparison.png\" style=\"margin-left: 10px; margin-right: 10px; width: 500px; height: 281px; float: left;\" />Next, I would like to remind readers that the current state of our economy is anything but robust. While the official unemployment rate is now under 5%, the alternative U-6 underemployment rate remains elevated at a worrisome 9.7%, near peak levels last seen after the dot-com crash (<a href=\"http://www.macrotrends.net/1377/u6-unemployment-rate\">source</a>). Additionally, the labor force participation rate sits at just 62.7%, a level not seen since the 1970s, when women were still a small fraction of the workforce (<a href=\"http://money.cnn.com/2016/02/06/news/economy/obama-us-jobs/\">source</a>). </p>\r\n",
  round_id: 3,
  debate_id: 1,
  })



=begin

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
