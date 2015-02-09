import strutils, sockets, httpserver

var counter = 0

proc handleRequest(client: Socket, path, query: string): bool {.procvar.} =
  inc(counter)
  client.send("Hello for the $#th time." % $counter & wwwNL)
  return false # do not stop processing

# run(handleRequest, Port(80))

var s: TServer

open(s, Port(80), true)
echo("httpserver running on port ", s.port)
while true:
    next(s)
    if handleRequest(s.client, s.path, s.query): break
    close(s.client)
close(s)

