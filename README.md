# tex_template
---

このファイル群は、通常texを分割した際に、
それぞれのtexでタイプセットできない問題を解決するために、
各章毎にフォルダ分けしてフォルダ毎に各章でタイプセットできるようにしたものです。
各texのプリアンブルそのままで、main.texとサブディレクトリの中のsub.texを編集します。

sub.texのあるディレクトリでmakeすれば、各章のsub.tex毎にでタイプセットできます。
main.texのあるディレクトリでmakeすれば、すべてまとめてタイプセットできます。

## Makefileについて
MakefileはOS毎に依存しているコマンドが違います。
もちろんこれらは自由に置き換えることができます。
基本的にtexをタイプセットできて、PDFが閲覧できる環境なら問題ありません。
 - 全OS共通 : platex, dvipdfmx, extractbb
 - Windows : 未調査
 - Linux : texlive, evince
 - macOS : texlive

Makefileでやっていることは、
1.	OS毎にタイプセットに使うコマンドを設定 (platex, dvipdfmxなど)
2.	pngやjpgの画像ファイルについて.xbbファイルを生成 (extractbb)
3.	カレントディレクトリから拡張子が.texのファイルを取得
4.	.texのファイルをファイル毎にタイプセット、ゴミ掃除、PDF表示 (evinceなど)
です。

## プリアンブルについて
main.texやsub.texのプリアンブルには特殊な処理を書いています。
これは各章のsub.tex単体でタイプセットできるようにするためです。
