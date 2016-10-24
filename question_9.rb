# 男を-1, 女を1とし、配列内の要素を掛け合わせて 1なら同数、-1なら異なるとみなす

GENDERS = {
  man: -1,
  woman: 1
}
MEN_NUM = 15
WOMEN_NUM = 10
TOTAL_NUM = MEN_NUM + WOMEN_NUM

@count = 0

def arrival(current_members, total_num)
  return if current_members.count >= 2 && current_members.count(GENDERS[:man]) == current_members.count(GENDERS[:woman])

  if current_members.count == total_num
    @count += 1
    return
  end

  rest_members = current_members.count(GENDERS[:man]) < MEN_NUM ? GENDERS.values : [GENDERS[:woman]]
  rest_members.each do |new_member|
    arrival(current_members.clone + [new_member], TOTAL_NUM)
  end
end

arrival([], TOTAL_NUM)
puts @count

=begin
またも間違える。
Ruby - question_9.rb:14
4100808
[Finished in 19.829s]

上記もいろいろ試行錯誤のうえだったが、単純に再帰に持ち込むと stack level too deep で死ぬ。
解答例が最短経路問題のように2次元表に落とし込んで解いていたので、まずは写経する。
=end
# 0人のパターンも考えるため、+1 する
boy = 20 + 1
girl = 10 + 1

# 2次元表をつくる
array = Array.new(boy * girl){0}
array[0] = 1

girl.times do |g|
  boy.times do |b|
    if (b != g) && (boy - b != girl - g)
      array[b + boy * g] += array[b - 1 + boy * g] if b > 0
      array[b + boy * g] += array[b + boy * (g - 1)] if g > 0
    end
  end
end

puts array[-2] + array[- boy - 1]

=begin
Ruby - question_9.rb:48
2417416
[Finished in 0.403s]

結局問題文を最短経路問題に落とし込めるかどうかだと思う。
一旦数学として捉え、それをコードに落とし込むという思考フローの方が良い気がする。
=end
