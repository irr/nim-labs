import redis

var red:Redis= redis.open()

red.multi()
red.setk("name", "alessandra")
discard red.get("name")
discard red.del("name")

for v in red.exec():
    echo(v)

