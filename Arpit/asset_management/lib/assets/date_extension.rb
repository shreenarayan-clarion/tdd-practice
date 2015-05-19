class Date

  def to_s(format = "%d/%m/%Y")
    format == :db ? self.strftime("%Y-%m-%d") : self.strftime(format)
  end

end

class ActiveSupport::TimeWithZone

  def to_s(format = "%d/%m/%Y %I:%M %p")
    format == :db ? self.strftime("%Y-%m-%d %H:%M") : self.strftime(format)
  end

end

class DateTime

  def to_s(format = "%d/%m/%Y %I:%M %p")
    format == :db ? self.strftime("%Y-%m-%d %H:%M") : self.strftime(format)
  end

end

class Time

  def to_s(format = "%d/%m/%Y %I:%M %p")
    format == :db ? self.strftime("%Y-%m-%d %H:%M") : self.strftime(format)
  end

end