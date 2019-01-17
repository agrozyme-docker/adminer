#!/usr/bin/lua
local core = require("docker-core")

local function main()
  local url = "https://github.com/vrana/adminer/releases/download"
  local version = "4.7.0"
  local file = "source.tar.gz"

  core.run("apk add --no-cache php7-session php7-curl php7-mongodb $(apk search --no-cache -xq php7-pdo*)")
  core.run("wget -qO adminer.php %s/v%s/adminer-%s.php", url, version, version)
  core.run("wget -qO %s %s/v%s/adminer-%s.tar.gz", file, url, version, version)
  core.run("tar xzf %s --strip-components=1 'adminer-%s/designs/' 'adminer-%s/plugins/' ", file, version, version)
  core.run("rm -f %s", file)
end

main()
