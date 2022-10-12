## マイ･リストビューver 0.1.3

* ### たった3行でリストビューを設置できます()

	![mylv2022101102](https://user-images.githubusercontent.com/83401251/195083576-ff66d6e6-fc37-4ec7-a913-543aa6f75d3b.png)<br><br>サンプル 00_mylvsample.hsp より | ![mylv20221011](https://user-images.githubusercontent.com/83401251/195083006-a499adee-a00d-4e33-9066-2b5a7e2ef537.png)<br>同梱サンプルファイル実行の様子
	---: | ---:

今後、アップデートが不定期で行われる予定です。

右のRelease、マイ･リストビューか、右上のcode（緑）からzipをダウンロードしてどうぞ

<br />

## 特徴

* リストビューの設置部分に関してはアイテム数によらず３行で指定レコード（アイテム）全てを設置可能

* 整数、実数、文字列をすべて文字列型の1次元配列変数として扱う

* 複数選択可能、レコード（横一列）まとまって強調表示

* デフォルトでカラムをドラッグ・アンド・ドロップで入れ替え可能

* 内部では文字列型の1次元配列変数として扱っているので、CSVも変換できれば対応可能

* SQLite(SQLele)との連携が可能で、場合によってはデータの情報（アイテム数やカラムの数など）を把握していなくてもリストビューの設置が可能

* SQLeleとの連携により、サブルーチンジャンプで各カラムごとに昇順･降順が切替可能<br>（一旦アイテムを全削除してSQLiteでクエリ文叩いて作り直している。win32APIで実現しようと試みたが挫折。今後改善予定）

* 追加する`mycrelv`命令で設置されるリストビューのウィンドウスタイル

	ウィンドウスタイル| 値 | 機能
	:--- | :--- | ---
	WS_CHILD | 0x40000000 | 子供にする
	WS_VISIBLE | 0x10000000 | 見えるようにする
	LVS_REPORT | 0x0001 | 詳細表示

	拡張ウィンドウスタイル | 値 | 機能
	:--- | :--- | ---
	LVS_EX_HEADERDRAGDROP | 0x00000010 | ヘッダードラッグ・ドロップ
	LVS_EX_FULLROWSELECT | 0x00000020 | 横一列まとめて選択
	LVS_EX_GRIDLINES | 0x00000001 | グリッド線の表示

<br>

## 追加命令

<details>
<summary>追加される命令一覧</summary>


~~~ HSP

//SQLのデータを文字列型1次元配列変数に変換･出力(マクロ)
myindata rec_num, col_num, col_list, rec_data
//p1 : レコードの数
//p2 : カラムの数
//p3 : カラムを格納した文字列型配列変数
//p4 : レコードを受け取る文字列型配列変数

//リストビュー設置(マクロ)
mycrelv X, Y, ObjID, Objhwnd
//p1,p2 : Xサイズ,Yサイズ
//p3 : オブジェクトIDを受け取る変数
//p4 : オブジェクトハンドルを受け取る変数

//リストビューにカラムを個別指定で追加(マクロ)
myincol ObjID, col_list, col_num, col_w, (p5 = 0)
//p1 : リストビューのオブジェクトID
//p2 : カラムを格納した配列変数
//p3 : カラムの数
//p4 : カラムの幅を格納した配列変数
//p5(0) : 0=左揃え / 1=右揃え / 2=中央揃え

//リストビューにカラムを同一指定で追加(マクロ)
myincol2 ObjID, col_list, col_num, (p4 = 75), (p5 = 0)
//p1 : 設置したリストビューのオブジェクトID
//p2 : カラムを格納した配列変数
//p3 : カラムの数
//p4 : カラムの幅(整数)
//p5 : 0=左揃え / 1=右揃え / 2=中央揃え

//リストビューにレコードを追加(マクロ)
myinitem ObjID, rec_data, rec_num, col_num
//p1 : リストビューのオブジェクトID
//p2 : レコードを格納した配列変数
//p3 : レコードの数
//p4 : カラムの数

//リストビューのアイテムの文字列取得
mygetitem ObjID, col_num, gettext
//p1 : リストビューのオブジェクトID
//p2 : カラムの数
//p3 : 取得文字列を格納する文字列型変数

//リストビューアイテムの全削除
mydelitem ObjID
//p1 : リストビューのオブジェクトID
~~~

</details>

<br>

* ### 用意しなければならない変数一覧
![mylv04](https://user-images.githubusercontent.com/83401251/195087503-a21b35ae-8bbe-4cf2-99f7-1ad34fb70cf7.png)| 　ネストしたrepeat文をマクロ登録しているため、どうしても変数が多くなってしまいます。
--- | :---


* ### SQLite(sqlele)連携によるデータの取得（例）

	~~~ HSP
	sql_q "SELECT * FROM MyCPU;"
		rec_cnum = stat                //レコードの数
		col_cnum = length(tmparr)      //カラムの数
		col_clis = sql_collist()       //カラムリスト
		split col_clis, ",", col_clis  //カラムリストを配列変数に

		//全アイテムを文字列型1次元配列として変数cpuに格納
		myindata rec_cnum, col_cnum, col_clis, cpu	//sqLele.hspインクルード時のみ利用可
	~~~

* ### リストビュー設置部分
	~~~ HSP
		mycrelv 400, 430, id_LVcpu, hLVcpu                   //リストビュー設置
			myincol id_LVcpu, col_clis, col_cnum, col_cw //カラムの追加
			myinitem id_LVcpu, cpu, rec_cnum, col_cnum   //全アイテム追加

	oncmd gosub *notify, WM_NOTIFY    //リストビューの並び替え
	~~~

* ### レコードの取得
	~~~ HSP
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
	~~~ HSP
	/***リストビューの昇降順***/
	*notify
		dupptr nmhdr, lparam, 12, 4  :  hLV = nmhdr(0)	// リストビューのオブジェクトハンドル

		if (nmhdr(2) = LVN_COLUMNCLICK) {
			dupptr nmlv, lparam, 40, 4  :  index = nmlv(4)	//クリックされたカラムのインデックス

			gsel WIN_ID

			sql_open db
				sql_q "BEGIN;"

				switch hLV
					case hLVcpu
						sdim cpu, 2048
						swc = swc * -1
						if swc == -1 : sqsc = " DESC;"   :   else : sqsc = " ASC;"	//DESC : 降順 / ASC : 昇順

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

## 更新履歴

### ver 0.1.3
2022/10/12 : カラム幅が同じリストビューの設置に特化した myincol2命令を追加

### ver 0.1.2
2022/10 : 初公開
