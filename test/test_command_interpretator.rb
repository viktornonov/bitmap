require_relative "../command_interpretator"
require "test/unit"

class TestCommandInterpretator < Test::Unit::TestCase
  def test_interpret_line_exiting_command
    assert_equal({:status => :success}, CommandInterpretator.new.interpret_line("I 1 2"))
  end

  def test_interpret_line_non_exiting_command
    assert_equal({:status => :failed,
                  :msg => "not recognized command"}, CommandInterpretator.new.interpret_line("W 1 2"))
  end

  def test_interpret_line_wrong_params_count
    assert_equal({:status => :failed,
                  :msg => "Command I has 2 parameters"}, CommandInterpretator.new.interpret_line("I 1 2 2"))
  end

  def test_interpret_line_wrong_type_params
    assert_equal({:status => :failed,
                  :msg => "Command I doesn't match parameters type"}, CommandInterpretator.new.interpret_line("I 1 S"))
  end
end
