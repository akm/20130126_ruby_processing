# Circles

def setup
  size 800, 600
  background 255
  smooth
  stroke_weight 1
  fill 150, 150
  draw_circles
end

def draw
  background 255
  Circle.instances.each{|n| n.update_me }
end

def mouse_released
  draw_circles
end

def draw_circles
  10.times do
    Circle.new.draw_me
  end
end

class Circle

  def self.instances
    @instances ||= []
  end

  attr_accessor :x, :y, :radius

  def initialize
    @x = rand(width)
    @y = rand(height)
    @radius = rand(100) + 10
    @linecol = rand_color
    @fillcol = rand_color
    @alpha = rand(256)
    @xmove = rand(10) - 5
    @ymove = rand(10) - 5
    @xmoce, @ymove = 1, 1 if @xmove == 0 && @ymove == 0
    self.class.instances << self
  end

  def draw_me
    no_stroke
    fill @fillcol, @alpha
    ellipse @x, @y, @radius * 2, @radius * 2
    stroke @linecol, 150
    no_fill
    ellipse @x, @y, 10, 10
  end

  def update_me
    @x += @xmove
    @y += @ymove
    right = width + @radius
    @x = 0 - @radius if @x > right
    @x = right if @x < 0 - @radius
    bottom = height + @radius
    @y = 0 - @radius if @y > bottom
    @y = bottom if @y < 0 - @radius

    self.class.instances.each do |n|
      next if n == self

        dis = dist @x, @y, n.x, n.y
        overlap = dis - @radius - n.radius
        if overlap < 0
          mid_x = (@x + n.x) / 2
          mid_y = (@y + n.y) / 2
          stroke 0, 100
          no_fill
          overlap *= -1
          ellipse mid_x, mid_y, overlap, overlap
        end
    end


    draw_me
  end

  def rand_color
    color(rand(256), rand(256), rand(256))
  end

end

