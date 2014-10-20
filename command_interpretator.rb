require_relative 'image'

class CommandInterpretator
  COMMANDS = [{name: "I", params: [/\d+/, /\d+/], action: :create },
              {name: "C", params: [], action: :clear },
              {name: "L", params: [/\d+/, /\d+/, /\w/],
                          action: :color_pixel },
              {name: "V", params: [/\d+/, /\d+/, /\d+/, /\w/],
                          action: :draw_vertical_segment },
              {name: "H", params: [/\d+/, /\d+/, /\d+/, /\w/],
                          action: :draw_horizontal_segment },
              {name: "F", params: [/\d+/, /\d+/, /\w/],
                          action: :fill_region },
              {name: "S", params: [], action: :show },
              {name: "X", params: [], action: :terminate }]

  def initialize
    @image = Image.new
  end

  def read_lines
    while line = STDIN.gets
      break if line == "X\n"
      interpret_line(line)
    end
  end

  def interpret_line(line)
    chars = line.gsub(/s+/m, ' ').strip.split(' ')
    COMMANDS.each do |command|
      if chars[0] == command[:name]
        if chars.count - 1 == command[:params].count
          command[:params].each_with_index do |param, i|
            return {status: :failed, msg: "Command #{command[:name]} doesn't match parameters type"} unless chars[i+1].match(param)
          end
          parameters = []
          chars[1..chars.count-1].each_with_index do |cmd_param, i|
            if command[:params][i] == /\d+/
              parameters << cmd_param.to_i
            else
              parameters << cmd_param
            end
          end
          @image.send(command[:action], *parameters)
          return { status: :success }
        else
          return {status: :failed, msg: "Command #{command[:name]} has #{command[:params].count} parameters"}
        end
      end
    end
    return { status: :failed, msg: "not recognized command" }
  end
end

