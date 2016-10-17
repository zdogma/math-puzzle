operators = ["+", "-", "*", "/"].unshift('')
permutations = operators.repeated_permutation(3).to_a
permutations.delete(["","",""])

(1_000..9_999).each do |num|
  chars = num.to_s.chars
  permutations.each do |perm_array|
    formula_str = [
      chars[0],
      perm_array[0],
      chars[1],
      perm_array[1],
      chars[2],
      perm_array[2],
      chars[3]
    ].join

    begin
      calc_result = eval(formula_str)
    rescue ZeroDivisionError, SyntaxError
      next
    end

    puts "#{num}: #{formula_str} => #{calc_result}" if num.to_s.reverse == calc_result.to_s
  end
end

=begin
# 改善ポイント
何度かやり直したが、たとえば product などを使って全パターンを出していたら計算量、メモリ量ともに溢れてしまう。
ぱっと思いつかなかったので、今回は愚直に間に入れる（これで先頭と末尾のパターンを消した）ことでなんとか終わる範囲にとどめた...

いくつか計算を結果を見てみればわかるが、
```
puts "#{num}: #{formula_str} => #{calc_result}" if calc_result > 1000
```
1129: 112*9 => 1008
1139: 113*9 => 1017
1149: 114*9 => 1026
1159: 115*9 => 1035
1169: 116*9 => 1044

このように4桁になる場合は*か''しかありえないので、最初の段階で operators を絞ってあげれば高速化はできる。
こういった部分に気づけるかどうかでパフォーマンス大きく変わるので、愚直ではない方法がないか常に考えられるようにしたい。

# 絞らなかった場合
Ruby - question_2.rb:5
5931: 5*9*31 => 1395
[Finished in 10.358s]

# 絞った場合
Ruby - question_2.rb:1
5931: 5*9*31 => 1395
[Finished in 0.577s]
=end
