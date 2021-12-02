# frozen_string_literal: true

require 'etc'
require 'date'

class Entry
  PERMISSIONS = { 0 => '---',
                  1 => '--x',
                  2 => '-w-',
                  3 => '-wx',
                  4 => 'r--',
                  5 => 'r-x',
                  6 => 'rw-',
                  7 => 'rwx' }.freeze

  FTYPE = { 'file' => '-',
            'directory' => 'd',
            'characterSpecial' => 'c',
            'blockSpecial' => 'b',
            'fifo' => 'p',
            'link' => 'l',
            'socket' => 's' }.freeze

  def initialize(path)
    @path = path
    @stat = File::Stat.new(path)
  end

  def blocks
    @stat.blocks
  end

  def type
    full_type = @stat.ftype
    FTYPE[full_type]
  end

  def permission
    permission_numbers = @stat.mode.to_s(8)[-3, 3].chars.map(&:to_i)
    permission_numbers.map { |number| PERMISSIONS[number] }.join
  end

  def nlink
    @stat.nlink.to_s
  end

  def owner
    Etc.getpwuid(@stat.uid).name
  end

  def group
    Etc.getgrgid(@stat.gid).name
  end

  def size
    @stat.size.to_s
  end

  def month_and_day
    @stat.mtime.strftime('%b %d')
  end

  def year_or_time
    mtime = @stat.mtime
    if mtime < Date.today.prev_month(6).to_time
      mtime.strftime('%Y')
    else
      mtime.strftime('%H:%M')
    end
  end

  def basename
    File.basename(@path)
  end

  def to_s
    output = type
    output += permission
    output += nlink.rjust(5)
    output += owner.center(8)
    output += group.center(8)
    output += size.rjust(8)
    output += " #{month_and_day} #{year_or_time.rjust(5)} "
    output + basename
  end
end
