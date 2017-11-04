module Gluon
  struct LogMessage
    property message : String
    property level : Gluon::LogLevel
    property time : Time

    def initialize(@message : String, @level : Gluon::LogLevel, @time : Time)
    end
  end
end
