local mock = require('luassert.mock')
local stub = require('luassert.stub')
local assert = require 'luassert'
local match = require 'luassert.match'
local spy = require 'luassert.spy'

describe('docker compose', function()
    local Docker = require('plugins._termtoggle.terminails.docker-compose')
    local Terminal = require('plugins._termtoggle.terminails.default')

    it('Should be create an terminal docker', function()
        local terminal = spy.new(Terminal)
        local io = mock(io, true)

        io.open.returns("file")
        io.close.returns("file")

        Docker("rspec", "vertical")

        assert.spy(terminal).was.called()
        assert.has_no.errors(function ()
            Docker("rspec", "vertical")
        end)
    end)

    it('Should be not create an terminal when not exits docker-compose file', function()
        local io = mock(io, true)

        io.open.returns(nil)

        assert.has.errors(function ()
            Docker("rspec", "vertical")
        end, "docker-compose file not found in woorking dir")
    end)
end)
