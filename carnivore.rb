class Carnivore

  DEFAULT_SIZE = 96
  DEFAULT_HUNGER = 25
  MAX_HUNGER = 200
  MAX_SIZE = 384

  attr_reader :eaten, :x, :y


  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @angle = rand(360)
    @speed = 1
    @size = DEFAULT_SIZE
    @hunger = DEFAULT_HUNGER
    @eaten = false

  end

  def color
    Gosu::Color.rgb(redness, 0, 0)
  end

  def move
    @size -= 0.01
    @dead = true if @size < 0
    @angle += rand(10) - 10 if rand(10) > 9
    @x += Gosu::offset_x(@angle, @speed)
    @y += Gosu::offset_y(@angle, @speed)
    @x %= @window.width
    @y %= @window.height
    @hunger += 0.1 unless @hunger >= MAX_HUNGER
  end

  def draw
    @window.draw_rect(@x, @y, quad_size, quad_size, color, ZOrder::HERBIVORE)
  end

  def quad_size
    @size / 5
  end

  def eat(preys)
    preys.each do |prey|
      if (collides?(prey.x, prey.y) && hungry?)
        prey.be_eaten
        @size += 4
        @hunger -= 4
      end
    end
  end

  def dead?
    @dead
  end

  def multiply
    if @size > MAX_SIZE
      [0,1].map { |_i| self.class.new(@window, @x+rand(80), @y+rand(80)) }
    else
      [self]
    end
  end

  def be_eaten
    @eaten = true
  end

  private

  def hungry?
    @hunger >= 25
  end

  def blueness
    255 - redness
  end

  def redness
    [@hunger/100.0, 1.0].min * 255
  end

  def collides?(x, y)
    (((@x - x).abs + (@y - y).abs) < 40 && ((@x - x).abs + (@y - y).abs) > 0)
  end

end
