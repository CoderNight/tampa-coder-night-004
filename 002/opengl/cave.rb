require "rubygems"
require "bundler/setup"

require "gosu"

class Cave
  attr_accessor :units
  attr_accessor :atlas
  attr :x, :y

  def initialize(input)
    @atlas = []
    File.open(input) do |file|
      @units = Integer(file.gets)
      file.seek(1, IO::SEEK_CUR)
      file.lines do |line|
        atlas << line.chomp.split(//)
      end
    end
    @x = 0
    @y = 1
  end

  def flow(x, y)
    if units > 0
      fill(x, y)
      if empty?(x, y+1)
        set(x, y+1)
      elsif empty?(x+1, y)
        set(x+1, y)
      else
        # need to start checking backwards here since were
        # not using recursion in this implementation
        atlas[y-1].size.times do |x|
          if empty?(x, y-1)
            set(x, y-1)
            break
          end
        end
      end
    end
  end

  def set(x, y)
    @x = x
    @y = y
  end

  def tick
    flow(x, y)
  end

  def fill(x, y)
    atlas[y][x] = Elements::WATER
    self.units -= 1
  end

  def empty?(x, y)
    atlas[y][x] == Elements::AIR
  end

  def width
    atlas.first.size
  end

  def height
    atlas.size
  end

  module Elements
    EARTH = "#"
    WATER = "~"
    AIR = " "
  end

  class Window < Gosu::Window
    attr :cave
    attr :scale
    attr :images

    def initialize(input, scale = nil)
      @scale = scale || input =~ /simple/ ? 16 : 5
      @cave = Cave.new(input)
      super(cave.width * @scale, cave.height * @scale, false)
      self.caption = "Cave"
      setup_images
    end

    def update
      @elapsed ||= 0
      if @elapsed > 2000
        cave.tick if cave.units > 0
        @elapsed = 0
      end
      @elapsed += Gosu.milliseconds
    end

    def draw
      cave.atlas.each_with_index do |line, y|
         line.each_with_index do |tile, x|
           @images[tile].draw(x * scale, y * scale, 0)
         end
       end
    end

    def button_down(id)
      case id
      when Gosu::KbEscape, Gosu::KbQ
        close
      end
    end

    def setup_images
      @images = {}
      @images[Elements::EARTH] = Gosu::Image.new(self, "assets/earth_#{scale}.png", false)
      @images[Elements::WATER] = Gosu::Image.new(self, "assets/water_#{scale}.png", false)
      @images[Elements::AIR] = Gosu::Image.new(self, "assets/air_#{scale}.png", false)
    end
  end
end

if ARGV[0]
  Cave::Window.new(*ARGV).show
else
  puts "No input given. Usage: `ruby #{$0} filename`.\n"
end
