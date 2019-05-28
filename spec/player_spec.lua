require 'spec/harness'
require 'tmp/castle'

describe('the player', function()
  before_each(function()
    _init()
  end)

  it('should stand still after init', function()
    assert.is.equal(0, player.dx)
    assert.is.equal(player_start_x, player.x)
  end)

  it('should stand still after one update', function()
    player:update()

    assert.is.equal(0, player.dx)
    assert.is.equal(player_start_x, player.x)
  end)

  it('should stand still after two updates', function()
    player:update()
    player:update()

    assert.is.equal(0, player.dx)
    assert.is.equal(player_start_x, player.x)
  end)

  describe('facing right', function()
    it('should have a negative speed', function()
      player:bounce_back()

      assert.is_true(player.dx < 0)
    end)

    it('should bounce back left', function()
      player:bounce_back()
      player:update()

      assert.is.equal(player_start_x-x_bounce_back, player.x)
      assert.is.equal(-x_bounce_back+1, player.dx)
    end)
  end)

  describe('facing left', function()
    before_each(function()
      player.direction = joy_left
    end)

    it('should have a positive speed', function()
      player:bounce_back()

      assert.is_true(player.dx > 0)
    end)

    it('should bounce back right', function()
      player:bounce_back()
      player:update()

      assert.is.equal(player_start_x+x_bounce_back, player.x)
      assert.is.equal(x_bounce_back-1, player.dx)
    end)
  end)
end)
