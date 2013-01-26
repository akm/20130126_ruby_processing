# Circles

def setup
  size 800, 600
  background 255
  smooth
  stroke_weight 1
  fill 150, 150
  @circle_ary = []
  draw_circles
end

def draw
  background 255
  @circle_ary.eachd{|n| n.update_me }
end

def mouse_released
  draw_circles
end

def draw_circles
  10.times do
    @circle_ary << Circle.new
    @circle_ary.last.draw_me
  end
end

class Circle

  def initialize
    @x = rand(width)
    @y = rand(height)
    @radius = rand(100) + 10
    @linecol = rand_color
    @fillcol = rand_color
    @alpha = rand(256)
  end

  def draw_me
    no_stroke
    fill @fillcol, @alpha
    ellipse @x, @y, @radius * 2, @radius * 2
    stroke @linecol, 150
    no_fill
    ellipse @x, @y, 10, 10
  end

  def rand_color
    color(rand(256), rand(256), rand(256))
  end

end

