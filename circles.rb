# Circles

def setup
  size 800, 600
  background 255
  smooth
  stroke_weight 1
  fill 150, 150
  $circle_ary = []
  draw_circles
end

def draw
  background 255
  $circle_ary.each{|n| n.update_me }
end

def mouse_released
  draw_circles
end

def draw_circles
  10.times do
    $circle_ary << Circle.new
    $circle_ary.last.draw_me
  end
end

class Circle

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
    @x = 0 - @radius if @x > width + @radius
    @x = width + @radius if @x < 0 - @radius
    @y = 0 - @radius if @y > height + @radius
    @y = height + @radius if @y < 0 - @radius

    $circle_ary.each do |n|
      if n != self
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
    end


    draw_me
  end

  def rand_color
    color(rand(256), rand(256), rand(256))
  end

end

