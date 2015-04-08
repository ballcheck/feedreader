#NOTE: Thinking composition over inheritance.
# Probably use mixins instead of < inheritance.

class User
end

class Publisher < User
  has_many :channels
end

class Narrator < User
  has_many :dictations
  has_one :queue

  # Narrator could have a Queue OR could subscribe to Channels
  # Queue - would mean having to manage queue, item due dates etc.

end



# NOTE: this is really just a flex point between
# Publisher and Feed. Try not to add too much extra
# functionality here.
class Channel
  # feeds mostly of the same type. Often only have 1 feed.
  has_many :feeds
  has_many :items, :through => :feeds

  # to make matters simple, all feeds in the channel
  # have the same instruction.
  has_one :instruction

  # describes how to get items
  def queue
    # > self.feeds.map( &:queue ).flatten
  end

  # describes how to publish items, in conjunction with feed

  # Narrator "subscribes" to Channel
  # Use Observer pattern when new items arrive.
  has_many :subscriptions

  # TODO: how to deal with unique subscriptions.
end

# Flex point between Narrator and Channel
class Subscription
  has_one :narrator
  has_one :channel
end

class Instruction
  belongs_to :channel
  # where and how to publish Items
  # regularity, voice type, same voice only etc.
end

class Feed
  # feed details e.g. RSS url.
  has_many :items

  # only one channel per feed.
  belongs_to :channel

  # types
  #RSSFeed
  #EmailFeed
  #ManualFeed

  # NOTE: although different types of feeds contain different
  # information, the objects should be duck-typed and 
  # interchangable.

  # handle getting feed items
  # determining already seen items.

  # Use Observer pattern when new items arrive.
end


# Narrator accepts items before processing them. This means
# another Narrator can't pick up the item.
# Will have to be done atomically to pop off the list.
class Item
  belongs_to :feed

  has_one :progress

  def in_progress?
    progress.present?
  end

  # Should only have one good dictation
  has_many :dictations

  # types
  #RSS
  #Email
  #Manual
end

class ApiItem # ManualItem
  # need a db table of items created manually or using api.
end

class Progress
  belongs_to :narrator
  belongs_to :item

  # A contract between the Narrator and the Item.
  # Describes the state of the Item's Progress.
end


class Dictation
  belongs_to :narrator
  belongs_to :item
  belongs_to :progress

  has_many :publications
end

class Publication
  # record of the publication of an item on e.g. Soundcloud
  has_one :narrator
  has_one :dictation
  has_one :item
  #has_one :channel
  #has_one :instruction

  # types
  #Soundcloud
  #RSS
  #Email
  #Audioboom
end


# Have a REST api for Publisher / Narrator interaction.


# storyboard - Publisher
# creates a channel
# adds feeds to channel
# adds publication instruction to channel
