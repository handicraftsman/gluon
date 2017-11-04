module Gluon
  class Logger
    property level : Gluon::LogLevel
    property colored : Bool

    @@main_log_level = Gluon::LogLevel::INFO
    class_property main_log_level : Gluon::LogLevel

    def initialize(@level : Gluon::LogLevel = Gluon::LogLevel::INFO, @colored : Bool = true)
    end

    def write(msg : String, level : Gluon::LogLevel = @level, colored : Bool = @colored)
      self.write(Gluon::LogMessage.new(msg, level, Time.now), colored)
    end

    def write(msg : Gluon::LogMessage, colored : Bool = @colored)
      if msg.level >= @level && msg.level >= @@main_log_level
        puts self.format(msg, colored)
      end
    end

    def debug(msg : String, colored : Bool = @colored)
      self.write(msg, Gluon::LogLevel::DEBUG, colored)
    end

    def info(msg : String, colored : Bool = @colored)
      self.write(msg, Gluon::LogLevel::INFO, colored)
    end

    def warning(msg : String, colored : Bool = @colored)
      self.write(msg, Gluon::LogLevel::WARNING, colored)
    end

    def error(msg : String, colored : Bool = @colored)
      self.write(msg, Gluon::LogLevel::ERROR, colored)
    end

    def critical(msg : String, colored : Bool = @colored)
      self.write(msg, Gluon::LogLevel::CRITICAL, colored)
    end

    def format(msg : Gluon::LogMessage, colored : Bool) : String
      str = ""

      lvl_chars = {
        Gluon::LogLevel::DEBUG    => "DBG",
        Gluon::LogLevel::INFO     => "INF",
        Gluon::LogLevel::WARNING  => "WRN",
        Gluon::LogLevel::ERROR    => "ERR",
        Gluon::LogLevel::CRITICAL => "CRT",
      }[msg.level]

      lvl_color = {
        Gluon::LogLevel::DEBUG    => "\x1b[32m",
        Gluon::LogLevel::INFO     => "\x1b[36m",
        Gluon::LogLevel::WARNING  => "\x1b[33m",
        Gluon::LogLevel::ERROR    => "\x1b[31m",
        Gluon::LogLevel::CRITICAL => "\x1b[35m",
      }[msg.level]

      c_bold = "\x1b[1m"
      c_reset = "\x1b[0m"
      c_creset = "\x1b[39m"

      str += lvl_color + c_bold if colored
      str += "["
      str += c_creset if colored

      str += msg.time.to_s

      str += lvl_color if colored
      str += " | "
      str += c_creset if colored

      str += lvl_chars

      str += lvl_color if colored
      str += "] "
      str += c_reset if colored

      str += msg.message

      str
    end
  end
end
