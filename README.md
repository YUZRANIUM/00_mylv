## 00_mylv
今後、アップデートが不定期で行われる予定です。  ver 0.1.2

右上のCode（緑色）から zipをダウンロードしてどうぞ

## 概要

00_mylv はあらゆるデータや値をリストビューとして配置するモジュールです。

CSV や SQL などのデータを文字列型の1次元配列変数に変換することでリストビューを設置することが可能です。

また、HSP の SQLite 支援モジュールである SQLele を利用する場合は、専用のマクロ形式の変換命令である myindata命令 を利用することで比較的簡単にリストビューを設置することができます。

リストビューの設置にはuser32.asをインクルードすることが必要です。


## 使用方法
~~~
00_mylv-hsp3
      ├ 00_mylv.hsp  //ユーザースクリプトディレクトリかcommonへ
      ├ 00_mylv.txt
      └ 08_myhelp.hs  //HSPのインストールディレクトリ下のhsphelpへ
~~~

00_mylv.hsp をユーザースクリプトのディレクトリか、HSP のインストールディレクトリ下の commonフォルダ内において、00_mylv.hspをインクルードしてください。

各命令の詳細は、ヘルプファイル 08_myhelp.hs に記載されています。
このファイルを HSP のインストールディレクトリ下の hsphelpフォルダ内に置くことでヘルプマネージャーから参照できます。

---
<br />

本ソフトウェアおよび関連文書のファイル（以下「ソフトウェア」）の複製を取得するすべての人に対し、ソフトウェアを無制限に扱うことを無償で許可します。
これには、ソフトウェアの複製を使用、複写、変更、結合、掲載、頒布、サブライセンス、および/または販売する権利、およびソフトウェアを提供する相手に同じことを許可する権利も無制限に含まれます。

ソフトウェアは「現状のまま」で、明示であるか暗黙であるかを問わず、何らの保証もなく提供されます。ここでいう保証とは、商品性、特定の目的への適合性、および権利非侵害についての保証も含みますが、それに限定されるものではありません。

作者または著作権者は、契約行為、不法行為、またはそれ以外であろうと、ソフトウェアに起因または関連し、あるいはソフトウェアの使用またはその他の扱いによって生じる一切の請求、損害、その他の義務について何らの責任も負わないものとします。