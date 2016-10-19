length = 20
member_num = 3

(1..Float::INFINITY).each do |index|
  parallel_num = [index, member_num].min
  length -= parallel_num

  if length - 1 <= 0
    puts index
    break
  end
end

=begin
今回のは 3 分で解にたどり着けた。
length cm の棒を 1 cm のサイズに切り分ける際には (length - 1) 回切る必要があるので、
一度に切れる並列数を 1 2 3 3 3 3 .. のように足しあげて、 length - 1 に到達した時点を終点とする、と解釈。
これに関してはあまり方法に関するブラッシュアップはなさそうなので、あとは書き方だが... あまり余地なさそう。
=end
