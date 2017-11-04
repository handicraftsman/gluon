require "./src/gluon"

Gluon::Logger.main_log_level = Gluon::LogLevel::DEBUG
l = Gluon::Logger.new(Gluon::LogLevel::DEBUG)
l.write("Hello!")
l.debug("debug")
l.info("info")
l.warning("warning")
l.error("error")
l.critical("critical")
