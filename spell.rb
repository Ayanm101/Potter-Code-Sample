require 'json'

class Spell

  def initialize(params)
    @classification = params["Classification"]
    @effect = params["Effect"]
    @name = params["Spell(Lower)"]
    @formatted_name = params["Spell"]
  end

  attr_reader :classification, :effect, :name, :formatted_name

  def self.data
    path = 'data/spells.json'
    file = File.read(path)
    JSON.parse(file)
  end

  def self.random
    new(data.sample)
  end

  def self.effects
    data.map{|el| el["Effect"]}
  end

  # These two methods are used to validate answers
  def self.is_spell_name?(str)
    data.index { |el| el["Spell(Lower)"] == (str.downcase) }
  end

  def self.is_spell_name_for_effect?(name, effect)
    data.index { |el| el["Spell(Lower)"] == name && el["Effect"] == effect }
  end

  # To get access to the collaborative repository, complete the methods below.

  # Spell 1: Reverse
  # This instance method should return the reversed name of a spell
  # Tests: `bundle exec rspec -t reverse .`
  def reverse_name
    @name.reverse
  end

  # Spell 2: Counter
  # This instance method should return the number
  # (integer) of mentions of the spell.
  # Tests: `bundle exec rspec -t counter .`
  def mention_count
    mentions = Mention.data
    i = 0
    for mention in mentions
      if mention["Spell"] == @name
        i = i + 1
      end
    end
    return i
  end

  # Spell 3: Letter
  # This instance method should return an array of all spell names
  # which start with the same first letter as the spell's name
  # Tests: `bundle exec rspec -t letter .`
  def names_with_same_first_letter
    allSpells = Spell.data
    a =[]
    first = name[0]
    allSpells.each{ |spell|
      if spell["Spell(Lower)"] [0] == first
        a << spell["Spell(lower)"]
     end
   }
   return a
  end

  # Spell 4: Lookup
  # This class method takes a Mention object and
  # returns a Spell object with the same name.
  # If none are found it should return nil.
  # Tests: `bundle exec rspec -t lookup .`
  def self.find_by_mention(mention)
    Spell.new({"Classification" => 'write this method',
               "Effect" => 'write this method',
               "Spell(Lower)" => 'write this method',
               "Spell" => 'write this method'})
    allSpells = Spell.data
    x = mention.name

    for spell in allSpells
        if spell["Spell(Lower)"] == x
          return Spell.new(spell)
        end
    end
   return nil
  end
end
