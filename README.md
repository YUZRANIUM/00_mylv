## マイ･リストビューver 0.1.2

* ### たった3行でリストビューを設置できます()


	| --- | --- |

今後、アップデートが不定期で行われる予定です。

右上のCode（緑色）から、zipをダウンロードしてどうぞ

## 概要

00_mylv はあらゆるデータや値を比較的簡単にリストビューとして配置するモジュールです。

CSV や SQL などのデータを文字列型の1次元配列変数に変換することでリストビューを設置することが可能です。

また、HSP の SQLite 支援モジュールである SQLele を利用する場合は、専用のマクロ形式の変換命令である myindata命令 を利用することで比較的簡単にリストビューを設置することができます。

リストビューの設置には#include "user32.as" をインクルードすることが必要です。

## 特徴
* ### 用意しなければならない変数一覧
	~~~ hsp
	sdim cpu, 2048		// 全アイテム格納用
	sdim col_clis, 64	// カラムリスト格納用
	dim rec_cnum		// レコードの数
	dim col_cnum		// カラムの数

	col_cw = 50, 50, 80, 60, 60, 60		//各カラムの幅
	swc = 1								//昇降順切り替え
	~~~

* ### SQLite(sqlele)連携によるデータの取得（例）
	~~~ hsp
	sql_q "SELECT * FROM MyCPU;"
		rec_cnum = stat					//レコードの数
		col_cnum = length(tmparr)		//カラムの数
		col_clis = sql_collist()		//カラムリスト
		split col_clis, ",", col_clis	//カラムリストを配列変数に

		//全アイテムを文字列型1次元配列として変数cpuに格納
		myindata rec_cnum, col_cnum, col_clis, cpu	//sqLele.hspインクルード時のみ利用可
	~~~

* ### リストビュー設置部分
	~~~ hsp
		mycrelv 400, 430, id_LVcpu, hLVcpu				//リストビュー設置
			myincol id_LVcpu, col_clis, col_cnum, col_cw	//カラムの追加
			myinitem id_LVcpu, cpu, rec_cnum, col_cnum		//全アイテム追加

	oncmd gosub *notify, WM_NOTIFY		//リストビューの並び替え
	~~~

* ### レコードの取得
	~~~ hsp
	/***レコードの取得***/
	*getitem
		gsel WIN_ID
		sdim getlist, 1024
		//※注意リストビューからフォーカス外しても前回の選択状態を維持しています
		mygetitem id_LVcpu, col_cnum, getlist
		dialog getlist, 0, "GetItem"
		return
	~~~

* ### リストビューの並べ替え
	~~~ hsp
	/***リストビューの昇降順***/
	*notify
		dupptr nmhdr, lparam, 12, 4   :   hLV = nmhdr(0)	 // リストビューのオブジェクトハンドル

		if (nmhdr(2) = LVN_COLUMNCLICK) {
			dupptr nmlv, lparam, 40, 4   :   index = nmlv(4) //クリックされたカラムのインデックス

			gsel WIN_ID

			sql_open db
				sql_q "BEGIN;"

				switch hLV
					case hLVcpu
						sdim cpu, 2048
						swc = swc * -1
						if swc == -1 : sqsc = " DESC;"   :   else : sqsc = " ASC;"  //DESC : 降順 / ASC : 昇順

						sql_q "SELECT * FROM MyCPU ORDER BY " + col_clis(index) + sqsc
							col_clis = sql_collist()   :   split col_clis, ",", col_clis
							myindata rec_cnum, col_cnum, col_clis, cpu

						mydelitem id_LVcpu	//現在のリストビューの全レコードを削除
						myinitem id_LVcpu, cpu, rec_cnum, col_cnum
						swbreak
				swend

				sql_q "COMMIT;"
			sql_close
		}
		return
	~~~

## 使用方法

~~~
├ common
│   └ 00_mylv.hsp
├ doclib
│   └ 00_mylv
│       ├ 00_mylv.txt
│       └ 08_myhelp.hs
├ sample
│   └ 00_mylv
│       ├ 00_mylvsample
│       └ Syouhin.db
└ README.md
~~~
* 00_mylv.hsp をユーザースクリプトのディレクトリか、HSP のインストールディレクトリ下の commonフォルダ内において、00_mylv.hspをインクルードしてください。

* doclib下の 00_mylvフォルダは、HSPのインストールディレクトリ下にある同じ名前のdoclibフォルダ内に、00_mylvフォルダごと置いてください。

* sample下の 00_mylvフォルダは、HSPのインストールディレクトリ下にある同じ名前のsampleフォルダ内に、00_mylvフォルダごと置いてください。

---
<br />

本ソフトウェアおよび関連文書のファイル（以下「ソフトウェア」）の複製を取得するすべての人に対し、ソフトウェアを無制限に扱うことを無償で許可します。
これには、ソフトウェアの複製を使用、複写、変更、結合、掲載、頒布、サブライセンス、および/または販売する権利、およびソフトウェアを提供する相手に同じことを許可する権利も無制限に含まれます。

ソフトウェアは「現状のまま」で、明示であるか暗黙であるかを問わず、何らの保証もなく提供されます。ここでいう保証とは、商品性、特定の目的への適合性、および権利非侵害についての保証も含みますが、それに限定されるものではありません。

作者または著作権者は、契約行為、不法行為、またはそれ以外であろうと、ソフトウェアに起因または関連し、あるいはソフトウェアの使用またはその他の扱いによって生じる一切の請求、損害、その他の義務について何らの責任も負わないものとします。