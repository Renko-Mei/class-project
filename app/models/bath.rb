class Bath < ActiveRecord::Base

belongs_to :user
has_many :reviews

validates :user_id, presence: true
geocoded_by :location

def location
    [address, city, country].compact.join(',')
end

def longlat
    [longitude, latitude]. compact.join(',')
end

before_validation :geocode


ratyrate_rateable "rating"

validates :country, presence: true
validates_inclusion_of :country,  :in => %w(CAN USA), :message => "Country options are either Canada or United States of America"
validates :province, presence: true
validates_inclusion_of :province,  :in => %w(AK KY NY AL LA
OH AR MA OK AZ MD OR CA ME PA CO MI RI CT MN SC DC MO SD	 
DE MS TN FL MT TX GA NC UT HI ND VA	IA NE VT ID NH WA IL NJ WI	
IN NM WV KS NV WY BC AB SA MZ ON QU NF NB NS PE YU NV NT), :message => "Province options are either Canada or United States of America provinces/states"
validates :city, presence: true
validates :address, presence: true
validates :rating, presence: true, inclusion: { in: 0..5, :message => "must be between 0-5" }
validates :latitude, inclusion: { in: 21..84 }, presence: false
validates :longitude, inclusion: { in: -177..-53}, :uniqueness => {:scope => :latitude, :message => "and latitude data show this location is already taken"}, presence: false 
after_validation :id, presence: true


end
