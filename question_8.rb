MOVE_TYPES = %i( right left up down )
INITIAL_COORDINATE = { x: 0, y: 0 }.freeze
MOVE_COUNT = 12

patterns = MOVE_TYPES.repeated_permutation(MOVE_COUNT).to_a

exit 1
results = patterns.map { |commands|
  cordinate = INITIAL_COORDINATE.dup
  commands.each_with_object([]) do |command, array|
    case command
    when :up
      cordinate[:y] += 1
    when :down
      cordinate[:y] -= 1
    when :right
      cordinate[:x] += 1
    when :down
      cordinate[:x] -= 1
    end

    break if array.include?(cordinate)
    array << cordinate.dup
  end
}

puts results.compact.count

=begin
総当たり戦法で進めて、時間かかるし答え違うし...
ぱっと他の進め方のイメージわかなかったので、断念。

Ruby - question_8.rb:3
78404
[Finished in 238.019s]

ボトルネックはどこかというと明らかで、
最初のパターン出しの部分だけで、13秒かけて大量のメモリを消費している。 2810696[kb]

次に解答例を写経してみる。
=end

N = 12

def move(log)
  return 1 if log.size == N + 1

  count = 0
  [[0, 1], [1, 0], [0, -1], [-1, 0]].each do |d|
    next_position = [
      log[-1][0] + d[0],
      log[-1][1] + d[1]
    ]

    unless log.include?(next_position)
      count += move(log + [next_position])
    end
  end

  count
end

puts move([[0, 0]])

=begin
ループ中、だいたいメモリ消費量は 9000[kb] を維持している、
そして正しい答えが数秒で出た。

Ruby - question_8.rb:58
324932
[Finished in 2.521s]

再帰の中でのメモリ消費に関しては切り出して深ぼったほうがよさそう。
この問題への振り返りとしてやると規模が大すぎるので、一旦ここまで。
=end
