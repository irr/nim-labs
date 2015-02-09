import strutils, math, threadpool

proc term(k: float): float = 4 * math.pow(-1, k) / (2*k + 1)

proc pi(n: int): float =
    var ch = newSeq[float](n+1)
    parallel:
      for k in 0..ch.high:
        ch[k] = spawn term(float(k))
    for k in 0..ch.high:
      result += ch[k]

echo formatFloat(pi(5000))

