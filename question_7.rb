require 'Date'

puts (Date.parse("1964-10-10")..Date.parse("2020-07-24")).map { |date|
  date_str = date.strftime("%Y%m%d")
  date_str == date_str.to_i.to_s(2).reverse.to_i(2).to_s ? date_str : nil
}.compact

=begin
ぱっと見て思いつくやり方で実装し、正解。4分くらい。
模範解答が2種類あって、そのうち前者とほぼ同じだった。
（出力内容を date_str にするために、やや直感的ではない書き方をしている点のみ差分）

Ruby - question_7.rb:6
1966-07-13
1966-09-05
1977-02-17
1995-06-17
2002-05-05
2013-02-01
[Finished in 0.461s]

もう一方の「対称性な2進数が与えられた期間内に存在するか」という観点で実装してみる。

puts 19641010.to_s(2)
puts 20200724.to_s(2)
=>
1001010111011001010110010
1001101000011110100010100

この結果から、この2つの2進数の共通項として下記2点が挙げられる。
* 頭4桁が 1001
* いずれも 25桁

つまり、今回の条件を満たすとしたら下記のようになっているはず。
1001#{left 8文字}{0または1}{left_reverse 8文字}1001

よって、対象期間の left 8文字を抜き出して上記になる候補を洗い出し、
そのうえで日付として成立するものが今回導き出したい答えである。

require 'date'

from_left = 19641919.to_s(2)[4,8].to_i(2)
to_left = 20200724.to_s(2)[4,8].to_i(2)

(from_left..to_left).each do |i|
  l = "%08b" % i # 数値を2進数として表現
  r = l.reverse
  (0..1).each do |m|
    value = "1001#{l}#{m}#{r}1001"
    begin
      puts Date.parse(value.to_i(2).to_s).strftime("%Y%m%d")
    rescue
      next
    end
  end
end

Ruby - question_7.rb:75
19660713
19660905
19770217
19950617
20020505
20130201
[Finished in 0.413s]
=end
