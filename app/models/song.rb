class Song < ActiveRecord::Base
  # add associations here
  belongs_to :genre
  belongs_to :artist
  has_many :notes

  def artist_name
    self.try(:artist).try(:name)
  end

  def artist_name=(name)
    artist = Artist.find_or_create_by(name: name)
    self.artist = artist
  end

  def genre_name
    self.try(:genre).try(:name)
  end

  def genre_name=(name)
    genre = Genre.find_or_create_by(name: name)
    self.genre = genre
  end

  def note_contents=(notes)
    notes.each do |content|
      if content.length > 0
        self.notes.build(content: content)
      end
    end
  end

  def note_contents
    self.notes.map(&:content)
  end
end
