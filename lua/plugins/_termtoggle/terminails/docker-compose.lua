local Terminal = require('plugins._termtoggle.terminails.default')
DOCKER_FILE = "docker-compose.yml"

function Woorking_dir()
  return vim.fn.getcwd()
end

function file_exists(name)
  -- vim.fn.filereadable()
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

-- TODO: Check containers

return function(cmd, direction)
  if file_exists(Woorking_dir() .. "/" .. DOCKER_FILE ) then
    Terminal("docker-compose " .. cmd, direction)
  else
    print("docker-compose file not found in woorking dir")
  end
end
