# Copyright (C) 2012  Kouhei Sutou <kou@clear-code.com>
#
# License: GPLv3+, GFDL and/or CC BY-SA 3.0
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require "time"
require "yaml"
require "rabbit/task/theme"

config = YAML.load(File.read("config.yaml"))

theme_id = config["id"]

version = "1.0.1"

name = config["name"]
email = config["email"]
rubygems_user = config["rubygems_user"]

readme = File.read(Dir.glob("README*")[0])

readme_blocks = readme.split(/(?:\r?\n){2,}/)
summary = (readme_blocks[0] || "TODO").gsub(/\A(?:[=*!]+|h\d\.) */, "")
description = readme_blocks[1] || "TODO"

specification = Gem::Specification.new do |spec|
  prefix = "rabbit-theme"
  spec.name = "#{prefix}-#{theme_id}"
  spec.version = version
  spec.homepage = "http://theme.rabbit-shockers.org/#{theme_id}/"
  spec.authors = [name]
  spec.email = [email]
  spec.summary = summary
  spec.description = description
  spec.licenses = ["GPLv3+", "GFDL", "CC BY-SA 3.0"]

  spec.files = ["config.yaml", "Rakefile"]
  spec.files += Dir.glob("{theme.rb,COPYING,GPL,GFDL,README*}")
  spec.files += Dir.glob("data/**/*.{svg,png,jpg,jpeg,gif,eps,pdf}")
  spec.files += Dir.glob("locale/**/*.mo")
  spec.files += Dir.glob("po/*/*.po")

  spec.add_runtime_dependency("rabbit")
end

Rabbit::Task::Theme.new(specification) do |task|
  task.rubygems_user = rubygems_user
end
