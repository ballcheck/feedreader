#NOTE: Thinking composition over inheritance.
#NOTE: Could be done using Audioboom

User
  Publisher
    has_many :channels
  Narrator
    has_many :dictations

Channel
  has_many :feeds

Feed
  has_many :items
  RSSFeed
  EmailFeed
  ManualFeed

Item
  has_many :dictations
  RSS
  Email
  Manual

Dictation
  has_many :submissions
  belongs_to :narrator

  Clip
    # dictations could be time limited. or number of words.

Submission
  Soundcloud
  RSS
  Email
  Audioboom

# Have a REST api for Publisher / Narrator interaction.
