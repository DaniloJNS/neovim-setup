-- TODO: Rerun test using get_line in test falirues display by terminal
-- TODO: Bug-repost: container name can same for diferents services by example: order-serice-app or 
-- charge-service-app

local Buffer = require('libs.buffer')
local DockerTerminal = require('plugins._termtoggle.terminails.docker-compose')

GEMFILE = "Gemfile"

function Get_service_name()
  local status = io.popen("docker container ls | docker.awk", "r"):read("*l")

  if not tonumber(status) then return status else return false end
end

function file_exists(name)
  -- vim.fn.filereadable()
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function hasSetup()
  return file_exists(Buffer.get_cwd() .. "/" .. "spec/spec_helper.rb")
end

function rspec_cmd()
  local current_line_cursor = Buffer.get_line_number()
  local rspec_cmd =  " bundle exec rspec " .. Buffer.relative_path()

  if string.find(Buffer.get_line(), " it ") then
    rspec_cmd = rspec_cmd .. ":" .. current_line_cursor
  end

  return rspec_cmd
end

function Rspec_toogle()
  local Service_name = Get_service_name()
  if not Service_name then return print("Docker-compose failed") end

  if hasSetup() and string.find(Buffer.relative_path(), "_spec.rb") then
    local docker_cmd = "exec " .. Service_name
    local cmd = docker_cmd .. rspec_cmd()

    DockerTerminal(cmd, 'vertical')
    return print(rspec_cmd())
  end

  print("Current buffer is not spec file valid")
end

function Rspec()
  local Service_name = Get_service_name()

  if not Service_name then return print("Docker-compose failed") end

  if hasSetup() then
    local docker_cmd = "exec " .. Service_name
    local rspec_cmd =  " bundle exec rspec "

    DockerTerminal(docker_cmd .. rspec_cmd, 'vertical')
    return print(rspec_cmd)
  end

  print("Dir is not valid")
end

function Console()
  local Service_name = Get_service_name()

  if not Service_name then return print("Docker-compose failed") end

  if hasSetup() then
    local docker_cmd = "exec " .. Service_name
    local cmd =  " bundle exec rails console"

    DockerTerminal(docker_cmd .. cmd, 'vertical')
    return print(cmd)
  end

  print("Dir is not valid")
end


vim.api.nvim_set_keymap("n", "<leader>rs", '<cmd>lua Rspec_toogle()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>rg", '<cmd>lua Rspec()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>rc", '<cmd>lua Console()<CR>', {noremap = true, silent = true})
