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
  content: "<p dir=\"ltr\">With their 2015 tax returns officially in the books, most Americans have now digested the painful&nbsp;annual reminder that their inflation-adjusted incomes have remained stagnant for yet another year. Despite living in&nbsp;the strongest economy in the world, whose stock market has more than doubled since 2009, the median American&rsquo;s income has remained&nbsp;below pre-recession levels at just $53,657 in 2014 vs. $57,357 in 2007(<a href=\"https://research.stlouisfed.org/fred2/series/MEHOINUSA672N\">source</a>). Meanwhile, the top 1% of income earners in the country now earn a whopping 20% of total income (<a href=\"https://upload.wikimedia.org/wikipedia/commons/e/e7/U.S._Income_Shares_of_Top_1%25_and_0.1%25_1913-2013.png\">source</a>). This concentration of wealth at the top&nbsp;gives&nbsp;the U.S. the second-worst level of income inequality among the 31 developed economies in the OECD (<a href=\"http://www.pewresearch.org/fact-tank/2013/12/19/global-inequality-how-the-u-s-compares/\">source</a>). As a final important piece of context, the federal debt has doubled from $9 trillion to over $18 trillion since 2007, representing a long-term financial burden for future generations that will continue to worsen until we reach a balanced budget. It is in this context that I support the resolution: taxes should be raised on wealthy Americans earning at least $250,000 per year.</p>\r\n\r\n<p dir=\"ltr\"><img alt=\"\" src=\"http://citizen-debate.s3-us-west-2.amazonaws.com/ckeditor/pictures/data/000/000/001/content/historical-tax-rates.gif\" style=\"float: right; margin-left: 10px; margin-right: 10px; height: 306px; width: 500px;\" />Not only is raising taxes on the wealthy a prudent path toward a balanced budget, historical precedent also suggests that the there are minimal if any negative effects of such tax increases on the greater economy. Unfortunately, Americans have been told a different story ever since George W. Bush took office in 2000. Talk of supply-side, trick-down economics have misled many Americans into the belief that tax cuts for the wealthy incentivize growth and better economic outcomes for everyone. Unfortunately, not only do the last fifteen years suggest otherwise, a further look back at tax rates since the beginning of the 20th century reveals that the American economy did quite well with taxes 2-3 times higher than we have today. In the chart at right, we see that throughout the majority of the 20th century (from 1936 until 1980), the top marginal tax rate was over 70%. Even during the entirety of Reagan&rsquo;s first term, tax rates on top incomes remained at 50%.&nbsp;</p>\r\n\r\n<p>Additionally, if we go all the way back to the last time that marginal tax rates were below 28%, we find ourselves in the &ldquo;roaring 20s&rdquo;, where drastic tax cuts helped spark an unsustainable boom that also saw economic inequality also spike, before collapsing into the Great Depression. <img alt=\"jobs-report.png\" src=\"https://lh4.googleusercontent.com/Y7W4N4m0zK3MkMVVbgbb9lUDmKai1jOFKiCZeJC2DdNFEvuIazGYV7vabvh4HHNygH6KB_65pL55dAd6avQ_N6rldA6wU6fPD5sO6c3mOp7AYs7reqNmOrhXx9eFPOLgQWHg4WcY\" style=\"float: left; margin-left: 10px; margin-right: 10px; height: 363px; width: 500px;\" />Sounds eerily familiar to 2008. Finally, let us recall the late 2012 dire predictions of a pending economic recession due to the fiscal cliff, when the Bush tax cuts were set to expire just as spending cuts also went into effect. We ultimately sailed over this &ldquo;cliff&rdquo; in January 2013, when the top capital gains rate increased from 15% to 20%, and the top income tax rate jumped from 35% to 39.6%. As we can see in the employment&nbsp;numbers at left, the 3+ years since have proven all of those fears unwarranted, as we&#39;ve enjoyed nearly 6 years of job growth.</p>\r\n\r\n<p dir=\"ltr\">In conclusion, while the last hundred years of U.S. history is by no means sufficient to prove that tax increases are always a good thing, I hope readers will agree that it is sufficient to prove that the opposite is also not true. Tax increase do not always harm economic growth. Often times, in fact, the best climate for economic growth in this country has occurred in times of high taxes on the wealthy. Therefore, I urge readers to vote affirmative.</p>\r\n",
  round_id: 1,
  debate_id: 1
  })

OpeningStatement.create!({
  author_id:3,
  content: "<p dir=\"ltr\">Unlike the mass media would have you believe, the wealthy top few percent of income earners in this country are not the root cause of the anemic economic recovery we have seen over the past seven years. I will demonstrate the negative case for why taxes should not be raised on wealthy Americans in two ways. First, the academic research on the topic overwhelmingly agrees that tax increases hamper economic growth. Next, we will look at the current distribution of taxes and see that the wealthy are already paying more than their fair share. Finally, I will propose a few alternative mechanisms of fiscal responsibility that get us closer to a balanced budget without handcuffing the dynamic strength of our economy.</p>\r\n\r\n<p dir=\"ltr\">As happens all too often in discussions of taxes in the mainstream media, each side sticks to their talking points without really identifying any substantive research to support their position. As neither myself nor my opposition have advanced degrees in economics, I&rsquo;d instead urge that we trust the deep body of academic research that exists on the topic. I presume that&nbsp;we&nbsp;share the same&nbsp;objective of maximizing growth in our economy. The core question is, what types of tax policies actually promote the most growth? William McBride of the Tax Foundation performed a meta-analysis of 26 studies on the empirical relationship between taxes and economic growth since 1983, and found that all but 3 of those studies found a negative impact of taxes on growth (<a href=\"http://taxfoundation.org/article/what-evidence-taxes-and-growth\">source</a>). The majority of these studies demonstrated that a 1% increase in the effective tax base (as a % of GDP) produced at least a 1% decrease in GDP output. Additionally, the 3 outlier studies found no evidence to suggest increased taxes are beneficial to growth, but instead concluded that there is not a statistically significant impact of taxes on economic growth. Based on these studies, the academic research leaves no doubt that higher taxes hinder economic growth.</p>\r\n\r\n<p dir=\"ltr\">Next, let us look at the current distribution of taxes in the U.S. and determine if wealthy Americans ought to be paying more. According to the OECD, the U.S. already has the most progressive tax burden in the world, where the top 10 percent of Americans carry 45% of the overall tax burden (<a href=\"https://www.washingtonpost.com/news/wonk/wp/2013/04/05/americas-taxes-are-the-most-progressive-in-the-world-its-government-is-among-the-least/\">source</a>). As you can see below, the effective tax rate increases substantially as you move up the income brackets. Contrary to the oft-hyped stories of Mitt Romney paying less than his housekeeper, the effective tax-rate on the top 1% of earners is 33.4%, nearly triple the middle quintile of earners whose effective rate is just 13.1% (<a href=\"http://www.pgpf.org/Chart-Archive/0102_tax-rates\">source</a>).</p>\r\n\r\n<p dir=\"ltr\"><img src=\"https://lh5.googleusercontent.com/Lk5frMjlIvmzeo75aOeH38v9q9AXWEoyPcPOvh5GQ1VrCXJ7u5CczPlb4wBAKBg17iDNM8sW0LiMqFVitpeFLOs7DMtFtb65g0sySpsevcd7t1ixtmOgzC_Uh3Y1fNoGpD0sZ3rA\" style=\"height: 375px; width: 500px; margin-left: 10px; margin-right: 10px; float: left;\" /></p>\r\n\r\n<p dir=\"ltr\">On the other end of the spectrum, the Tax Policy Center estimated last fall that a whopping 45% of Americans will pay exactly $0 in federal income tax in 2015 (<a href=\"http://www.forbes.com/sites/beltway/2015/10/06/new-estimates-of-how-many-households-pay-no-federal-income-tax/#667fde3c3cf4\">source</a>). When you factor in tax credits, there are in fact millions of Americans who not only don&rsquo;t pay any taxes, but are just given money every year from Uncle Sam, which in actuality comes out of the pockets of our nation&rsquo;s job creators. As this evidence demonstrates, wealthy Americans today are arguably paying more than their fair share already, and thus do not deserve any additional tax increases.</p>\r\n\r\n<p dir=\"ltr\">Finally, I will demonstrate just a few alternative tax provisions that have garnered bipartisan support (at least thus far in the presidential campaign) and would be preferred options for restoring fiscal responsibility in our federal budget. On a high-level, there are simply too many special-interest tax breaks that have worked their way into the tax code over the last century. One such subsidy is the carried interest loophole, which allows private equity funds to categorize their &ldquo;2% carry&rdquo; as capital gains (which are taxed at a lower preferential rate) even though no one would credibly argue that the fee constitutes an actual capital gain. How does this work you ask? When a PE firm raises a $100 million dollar fund, the general terms work as follows. The PE firm invests that money over the course of 5-7 years. When the fund is over, the PE firm gets to keep 20% of the profits (capital gains), and the original investors get the other 80%. However, since running a fund for 5-7 years costs money, the PE firm also takes a 2% &ldquo;carry&rdquo; from the original $100 million, and uses that to pay their employees. This 2% ought to be recognized as ordinary revenue and taxed accordingly, as both Bernie Sanders and Donald Trump have proposed (<a href=\"http://www.nytimes.com/2015/09/18/business/with-trump-as-foe-carried-interest-tax-loophole-is-vulnerable.html\">source</a>). In a similar manner, both Republican presidential candidates as well as Obama have proposed a reduced one-time repatriation fee on foreign-held profits (<a href=\"http://www.wsj.com/articles/firms-back-tax-reformjust-not-obamas-1422924735\">Obama source</a>, <a href=\"http://taxfoundation.org/sites/taxfoundation.org/files/docs/Comparison-NEW.pdf\">Republicans source</a>), which would encourage U.S. corporations to bring their offshore cash back home to reinvest in the American economy. These are just two examples that demonstrate that not only do wealthy Americans already pay their fair share, but there are plentiful options for restoring fiscal prudence to the federal budget without raising income taxes further on any Americans.</p>\r\n",
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
  content: "<p dir=\"ltr\">I will first respond to the negative&rsquo;s core argument that tax increases hinder economic growth. I will then review a hypothetical scenario to demonstrate the futility of supply-side theory, before recapping the historical evidence that suggests tax increases on the wealthy have not and will not have negative consequences on our economy.</p>\r\n\r\n<p dir=\"ltr\">First, when we evaluate the body of academic research on tax policy and growth, it is not nearly as black and white as the negative would have you review. The Center on Budget and Policy Priorities authored a response to the Tax Foundation meta-study, and found that the Tax Foundation misrepresented 9 of their cited 26 studies, and in fact 12 of the 26 studies do not support the assertion that all tax increases harm growth (<a href=\"http://www.cbpp.org/research/what-really-is-the-evidence-on-taxes-and-growth\">source</a>). In thoroughly evaluating these same studies, the CBPP concludes &ldquo;there is simply no consensus that, as a general proposition, cutting taxes is a good strategy to boost economic growth.&rdquo; Additionally, even the Tax Foundation explicitly acknowledges that its models do not &ldquo;currently estimate the effects of changes in private and government spending policies&rdquo;, which is as if to say that when the government extracts more money from citizens, that money simply goes down the toilet and has no possible positive impact on the economy. Altogether, I recommend that readers consider all Tax Foundation evidence with a heavy grain of salt, considering the organization is sponsored by infamous conservatives such as the Koch brothers.</p>\r\n\r\n<p dir=\"ltr\">Regarding the problem that is economic inequality today, my opponent has had no response. The common conservative critique is that inequality is a necessary pill to swallow to preserve capitalism, and better than an anti-capitalist state of socialism where wealth redistribution leads to equal poverty for all. However, let&rsquo;s evaluate a hypothetical solution about supply-side vs. demand-side economics. Let&rsquo;s consider a typical member of the .1%, who earns about $4 million dollars, or 100 times the median American income. <img alt=\"\" src=\"http://citizen-debate.s3-us-west-2.amazonaws.com/ckeditor/pictures/data/000/000/002/content/millionaires-effective-tax-rate.png\" style=\"float: right; width: 500px; height: 293px; margin-left: 10px; margin-right: 10px;\" />As Nick Hanauer points out in this 2012 <a href=\"https://www.youtube.com/watch?v=CKCvf8E7V1g\">Ted talk</a>, it is impossible for him to spend 100 times more than the average American consumer. His family has a nice house and 3 cars, but they don&rsquo;t have 100 houses and cars, nor do they spend 100 times as much on food and shopping. So whereas when middle class Americans spend nearly all of their disposable income, the wealthy end up sitting on the vast majority of their wealth, often investing that money in unproductive activities like campaign contributions aimed at reducing their future tax obligations even further.&nbsp;</p>\r\n\r\n<p dir=\"ltr\">Again, we can revisit the still recent memory of the the Bush tax cuts, which cost the government $1.5 trillion in lost tax revenue over his two terms (<a href=\"https://www.washingtonpost.com/blogs/fact-checker/post/revisiting-the-cost-of-the-bush-tax-cuts/2011/05/09/AFxTFtbG_blog.html\">source</a>). Instead of stable economic growth, we were greeted with a few years of housing-bubble euphoria that ended with the greatest financial crisis since the Depression. While this is admittedly just one example, it should at least serve to prove that cutting taxes does not always work out well, just as the last 3 years since the fiscal cliff prove that that mild tax increases do not always ruin the economy. Instead, I believe that the preponderance of evidence suggests that the contrary is more likely to be true, and thus urge readers to vote for the affirmative: taxes should be raised on wealthy Americans earning at least $250,000 a year.</p>\r\n",
  round_id: 3,
  debate_id: 1,
  })

ClosingStatement.create!({
  author_id:3,
  content: "<p dir=\"ltr\">I will close by responding to the affirmative critique of the academic research and address the dangers implicit to tax increases that could wreak havoc on the fragile state of our economy.</p>\r\n\r\n<p dir=\"ltr\">First, with respect to the credibility of the Tax Foundation, it is a registered non-profit organization that has been long-recognized as a non-partisan think-tank since its founding in 1937. It is committed to tax principles of simplicity, neutrality, transparency, and stability, and holds a four-star rating (the highest possible) from Charity Navigator, a third party evaluator of charities. Understandably, tax policies can quickly become partisan in today&rsquo;s world, and the tax foundation makes every attempt to produce objective and insightful research. Their current Tax and Growth model has acknowledge limitations, and they are actively working to incorporate government spending into their dynamic scoring model.</p>\r\n\r\n<p dir=\"ltr\"><img alt=\"\" src=\"http://citizen-debate.s3-us-west-2.amazonaws.com/ckeditor/pictures/data/000/000/003/content/tax-foundation-comparison.png\" style=\"margin-left: 10px; margin-right: 10px; width: 500px; height: 281px; float: left;\" />Next, I would like to remind readers that the current state of our economy is anything but robust. While the official unemployment rate is now under 5%, the alternative U-6 underemployment rate remains elevated at a worrisome 9.7%, near peak levels last seen after the dot-com crash (<a href=\"http://www.macrotrends.net/1377/u6-unemployment-rate\">source</a>). Additionally, the labor force participation rate sits at just 62.7%, a level not seen since the 1970s, when women were still a small fraction of the workforce (<a href=\"http://money.cnn.com/2016/02/06/news/economy/obama-us-jobs/\">source</a>). Overall, the economy today is simply too fragile to gamble with raising taxes on the wealthy job creators who are funding the country&rsquo;s most promising job opportunities. To underscore the magnitude of risk that increased taxes pose to the economy, we can take a look at the Tax Foundation&rsquo;s projected impact of Bernie Sanders&rsquo; tax plan. While the senator&rsquo;s increased taxes on the wealthy will contribute to nearly $10 trillion dollars of new tax revenue over a 10-year period, the expected impact on GDP growth is an abysmal 9.5% contraction in the economy, which would cause wages to drop 4.3% over 10 years and see 5.9 million jobs disappear (<a href=\"http://taxfoundation.org/sites/taxfoundation.org/files/docs/Comparison-NEW.pdf\">source</a>). While today&rsquo;s slow and steady economic growth is by no means perfect, taking such a reckless risk would be downright irresponsible.</p>\r\n\r\n<p>In conclusion, I recognize and understand that raising taxes midly on the wealth sounds like a perfectly reasonable proposal on the surface. There are indeed millions of wealthy Americans for whom can surely afford an extra $50k, right? Unfortunately, the reality is that those dollars represent crucial investment dollars that fund small businesses and entrepreneurs, which are essential to the ongoing economic recovery. As the preponderance of academic research demonstrates, raising taxes inevitably hinders economic growth. As such, I urge readers to vote against this resolution.</p>\r\n",
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
