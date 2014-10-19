require_relative "../image"
require "test/unit"
require "minitest/autorun"

class TestImage < Minitest::Test
  def test_create_fill
    i = Image.new
    i.create(1, 1)
    expected = { [0, 0]=>"O" }
                 
    assert_equal(expected, i.canvas)
  end

  def test_create_with_larger_than_max_size
    assert_equal("height must be between 1 and 250, width should be > 1", Image.new.create(251, 251))
  end

  def test_create_with_size_zero
    assert_equal("height must be between 1 and 250, width should be > 1", Image.new.create(42, 0))
  end

  def test_clear
    i = Image.new
    i.canvas = {[0,0] => "C",
                [0,1] => "C",
                [1,0] => "C",
                [1,1] => "C" }
    i.m = 2
    i.n = 2
    expected = {[0,0] => "O",
                [0,1] => "O",
                [1,0] => "O",
                [1,1] => "O" }
    i.clear
    assert_equal(expected, i.canvas)
  end

  def test_color_pixel_top_left
    i = Image.new
    i.create(3,3)
    i.color_pixel(1,1,"C")
    assert_equal("C", i.canvas[[0,0]])
  end

  def test_color_pixel_bottom_right
    i = Image.new
    i.create(3,3)
    i.color_pixel(3,3,"C")
    assert_equal("C", i.canvas[[2,2]])
  end

  def test_color_pixel_out_of_image
    i = Image.new
    i.create(3,3)
    assert_equal("invalid coordinates", i.color_pixel(0,0, "C"))
  end

  def test_draw_vertical_segment
    i = Image.new
    i.create(3, 3)
    i.draw_vertical_segment(1,1,3,"B")
    assert_equal("B", i.canvas[[0,0]])
    assert_equal("B", i.canvas[[1,0]])
    assert_equal("B", i.canvas[[2,0]])
  end

  def test_draw_vertical_segment_with_coords_bigger_than_size
    i = Image.new
    i.create(3, 3)
    assert_equal("invalid coordinates", i.draw_vertical_segment(1,4,3,"B"))
  end

  def test_draw_vertical_segment_with_invalid_column
    i = Image.new
    i.create(3, 3)
    assert_equal("invalid coordinates", i.draw_vertical_segment(4,1,3,"B"))
  end

  def test_draw_vertical_segment_with_end_bigger_than_start
    i = Image.new
    i.create(3, 3)
    assert_equal("invalid coordinates", i.draw_vertical_segment(2,2,1,"B"))
  end

  def test_draw_horizontal_segment
    i = Image.new
    i.create(3, 3)
    i.draw_horizontal_segment(1,3,1,"B")
    assert_equal("B", i.canvas[[0,0]])
    assert_equal("B", i.canvas[[0,1]])
    assert_equal("B", i.canvas[[0,2]])
  end

  def test_draw_horizontal_segment_with_coords_bigger_than_size
    i = Image.new
    i.create(3, 3)
    assert_equal("invalid coordinates", i.draw_horizontal_segment(1,4,3,"B"))
  end

  def test_draw_horizontal_segment_with_invalid_row
    i = Image.new
    i.create(3, 3)
    assert_equal("invalid coordinates", i.draw_horizontal_segment(1,2,4,"B"))
  end

  def test_draw_horizontal_segment_with_end_bigger_than_start
    i = Image.new
    i.create(3, 3)
    assert_equal("invalid coordinates", i.draw_horizontal_segment(2,1,2,"B"))
  end

  def test_show
    i = Image.new
    i.create(3, 3)
    assert_output("OOO\nOOO\nOOO\n") do
      i.show
    end
  end

  def test_show_with_one_cell
    i = Image.new
    i.create(1, 1)
    assert_output("O\n") do
      i.show
    end
  end

  def test_fill_region_when_canvas_empty
    i = Image.new
    i.create(2, 2)
    i.fill_region(1, 1, "C")
    for x in 0..1
      for y in 0..1
        assert_equal("C", i.canvas[[x,y]])
      end
    end
  end

  def test_fill_region_when_center_is_different
    i = Image.new
    i.create(3, 3)
    i.canvas[[1,1]] = "B"
    i.fill_region(1, 2, "C")
    for x in 0..2
      for y in 0..2
        if x == 1 && y == 1
          assert_equal("B", i.canvas[[x,y]])
        else
          assert_equal("C", i.canvas[[x,y]])
        end
      end
    end
  end
end
