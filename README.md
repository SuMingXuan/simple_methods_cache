# SimpleMethodsCache

简单的缓存方法

在一个地方单独控制缓存

#### 使用说明

```ruby
class Test
  include SimpleMethodsCache

  cache_methods :one, :two, expires_in: 1.hour
  cache_methods :three, expires_in: 1.day

  def one
    xxx
  end

  def two
    xxx
  end

  def three
    xxx
  end
end

```

申明缓存的方法，会自动在一定时间内被缓存