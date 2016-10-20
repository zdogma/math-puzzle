COIN_TYPES = [10, 50, 100, 500].map(&:freeze).freeze

INPUT_MONEY = 1_000
MAX_COIN_NUM = 15

coin_types = COIN_TYPES.dup.select { |coin| coin < INPUT_MONEY }
patterns = coin_types.map do |coin_type|
  (0..[INPUT_MONEY / coin_type, MAX_COIN_NUM].min).map { |coin_num| [ coin_num * coin_type, coin_num ] }
end
combinations = patterns.shift.product(*patterns)
sums = combinations.map { |array| array.shift.zip(*array).map { |combi| combi.reduce(:+) } }

puts sums.select {|array| array[0] == INPUT_MONEY && array[1] <= MAX_COIN_NUM }.count

=begin
正解したものの、デバッグしながらこねくり回した結果なので、時間もかかったし見通しも悪い。
発想が「対象のパターン（=配列）」を作る、しかなかったので、"合計金額" と "枚数" の二次元配列でもゴリ押す感じでつらかった。

■ 回答例1
条件を満たす配列を作り上げ、その数を数えるのではなく、外で定義した count などの変数を、
ループを回す過程でインクリメントしていく。
repeated_combination なのでパフォーマンス面ではイマイチだが、見通しは良いし適切に絞りは足せそう。

count = 0
(2..15).each do |num|
  COIN_TYPES.dup.repeated_combination(num).each do |coin_set|
    count += 1 if coin_set.inject(:+) == 1000
  end
end
puts count


■ 回答例2
あまり経験のない再起系コード。
インスタンス変数にすることで、再起の中でのメソッドのスコープをまたいだカウントを実現している。
このタイプ、最初に脳内に浮かんだがコードにできなかったので鍛錬したい。

@count = 0
def change(target, coins, usable)
  coin = coins.shift
  if coins.size == 0
    @count += 1 if target/coin <= usable
  else
    (0..target/coin).each do |i|
      change(target - coin * i, coins.clone, usable - i)
    end
  end
end
change(1000, [500, 100, 50, 10], 15)
puts @count

=end
