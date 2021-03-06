require 'artoo'
require 'artoo/drivers/roomba'

connection :roomba, :adaptor => :roomba, :port => '/dev/ttyUSB0'
device :roomba, :driver => :roomba, :connection => :roomba
  
work do
  roomba.safe_mode
  roomba.nudge_left
  roomba.nudge_right
  roomba.nudge_right
  roomba.nudge_left
  play_jingle_bells
end

def play_jingle_bells
  roomba.song(JingleBells.song0, 0)
  roomba.song(JingleBells.song1, 1)
  roomba.song(JingleBells.song0, 2)
  roomba.song(JingleBells.song2, 3)

  roomba.play(0)
  sleep(7)
  roomba.play(1)
  sleep(7)
  roomba.play(2)
  sleep(7)
  roomba.play(3)
end

class JingleBells
  extend Artoo::Drivers::Roomba::Note

  class << self
    def song0
      [n(B), n(B), n(B, HALF),
       n(B), n(B), n(B, HALF),
       n(B), n(D), n(G), n(A),
       n(B, WHOLE)]
    end

    def song1
      [n(C), n(C), n(C), n(C),
       n(C), n(B), n(B, HALF),
       n(B), n(A), n(A), n(B),
       n(A, HALF), n(D, HALF)]
    end

    def song2
      [n(C), n(C), n(C), n(C),
       n(C), n(B), n(B), n(B),
       n(D), n(D), n(C), n(A),
       n(G, WHOLE)]
    end

    def n(note, duration=QUARTER)
      [note, duration]
    end
  end
end
