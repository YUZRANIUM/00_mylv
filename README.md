## マイ･リストビュー ![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/YUZRANIUM/00_mylv?include_prereleases&style=flat-square)

* ### たった3行でリストビューを設置できます()

 | ![mylv09](https://user-images.githubusercontent.com/83401251/195272530-d8e14629-fb4e-4794-82a1-b06937b9c067.png)<br><br>サンプル 00_mylvsample.hsp より | ![mylv20221011](https://user-images.githubusercontent.com/83401251/195083006-a499adee-a00d-4e33-9066-2b5a7e2ef537.png)<br>同梱サンプルファイル実行の様子 |
 | ------------------------------------------------------------------------------------------------------------------------------------------------------: | -------------------------------------------------------------------------------------------------------------------------------------------------------: |

**今後、アップデートが不定期で行われる予定です。**

右のRelease、マイ･リストビューか、右上のcode（緑）からzipをダウンロードしてどうぞ

## 特徴

* リストビューの設置部分に関しては **アイテム数によらず３行で指定レコード（アイテム）全てを設置可能**

* 整数、実数、文字列をすべて **文字列型の1次元配列変数** として扱う<br>（※ver 0.30から2次元配列変数も扱えるようになりました）

* 内部では文字列型の1次元配列変数として扱っているので、**CSVも変換することで対応可能**

* SQLite(SQLele)との連携が可能で、**場合によってはアイテム数やカラムの数などを把握していなくても設置が可能**

* SQLiteのデータベース（以下DB）操作により、**各カラムごとにレコードの昇順･降順が切替可能**<br>（実際は、アイテムを全削除しSQLでクエリ叩いてリストビューを作り直している。win32APIでアイテムの並び替えを実現しようと試みたが挫折。今後改善予定）


<br>

## 使用方法

~~~
├── common
│   └── 00_mylv.hsp
├── doclib
│   └── 00_mylv
│       ├── 00_mylv.txt
│       └── 08_myhelp.hs
├── sample
│   └── 00_mylv
│       ├── 00_mylvsample.hsp
│       └── Syouhin.db
├── README.md
└── README.html
~~~

* common下の 00_mylv.hsp をユーザースクリプトのディレクトリか、HSP のインストールディレクトリ下の commonフォルダ内において、00_mylv.hspをインクルードしてください。

        例） hsp36/common/00_mylv.hsp
<br>

* doclib下の 00_mylvフォルダは、HSPのインストールディレクトリ下にあるdoclibフォルダ内に、00_mylvフォルダごと置いてください。

        例） hsp36/doclib/00_mylv
<br>

* sample下の 00_mylvフォルダは、HSPのインストールディレクトリ下にあるsampleフォルダ内に、00_mylvフォルダごと置いてください。

        例） hsp36/sample/00_mylv
<br>

* リストビュー設置には`#include "user32.as"`をインクルード、SQLiteとの連携には`#include "sqlele.hsp"`をインクルードし、スクリプトディレクトリに`sqlite3.dll`をおいて下さい。**(※`sqlite3.dll`は同梱していません。)**

<br>

## 追加命令

<details>
<summary>追加される命令一覧</summary>

~~~ c

// リストビュー設置
//
// %1,%2 : Xサイズ,Yサイズ
// %3 : オブジェクトハンドルを受け取る変数
    mylv x, y, objhwnd_var


// リストビューにカラム追加1
//
// %1    : 設置したリストビューのオブジェクトハンドル
// %2    : カラムを格納した配列変数
// %3    : カラムの数
// %4    : カラムの幅(整数型の配列変数)
// %5(0) : 0=左揃え / 1=右揃え / 2=中央揃え
    incolm objhwnd_var, colmun_list, colmun_num, colmun_width


// リストビューにカラム追加2
//
// %1     : 設置したリストビューのオブジェクトハンドル
// %2     : カラムを格納した配列変数
// %3     : カラムの数
// %4(75) : カラムの幅(整数)
// %5(0)  : 0=左揃え / 1=右揃え / 2=中央揃え
    incolm2 objhwnd_var, colmun_list, colmun_num, num


// リストビューにレコードを追加 (1次元配列変数)
//
// %1 : 設置したリストビューのオブジェクトハンドル
// %2 : レコードを格納した配列変数
// %3 : レコードの数
// %4 : カラムの数
    inlvitem objhwnd_var, rec_array, rec_num, colmun_num


// リストビューにレコードを追加 (SQLele, 2次元配列変数に対応)
//
// %1 : 設置したリストビューのオブジェクトハンドル
// %2 : レコードを格納した配列変数
    insqlitem objhwnd_var, array

// リストビューのアイテムの文字列取得
//
// p1 : リストビューのオブジェクトハンドル
// p2 : カラムの数
// p3 : 取得文字列を格納する文字列型変数
// p4 : 配列変数のバッファサイズ
// p5 : 区切り文字
    getlvitem objhwnd_var, colmun_num, getvar, baffer_num


// リストビュー削除
//
// p1    : リストビューのオブジェクトハンドル
// p2(0) : 削除するタイプ(0 = アイテム, 1 = カラム, 2 = アイテムの全削除)
// p3    : 削除するアイテム,カラムのインデックス
    dellv objhwnd_var, type, index

~~~

</details>

<br>

<details>
<summary>設置されるリストビューのウィンドウスタイル</summary>

<br>


| ウィンドウスタイル | 値         | 機能             |
| :----------------- | :--------- | ---------------- |
| WS_CHILD           | 0x40000000 | 子供にする       |
| WS_VISIBLE         | 0x10000000 | 見えるようにする |
| LVS_REPORT         | 0x0001     | 詳細表示         |


| 拡張ウィンドウスタイル | 値         | 機能                       |
| :--------------------- | :--------- | -------------------------- |
| LVS_EX_HEADERDRAGDROP  | 0x00000010 | ヘッダードラッグ・ドロップ |
| LVS_EX_FULLROWSELECT   | 0x00000020 | 横一列まとめて選択         |
| LVS_EX_GRIDLINES       | 0x00000001 | グリッド線の表示           |


</details>

<br>

<details>
<summary>サンプルファイル（一部）</summary>

* ### SQLite(sqlele)連携によるデータの取得（例）

~~~ cpp
    sql_open db
    sql_q "SELECT * FROM MyCPU;", cpu   // 全レコードをレコードセット変数で取得
    sql_close


    col_clist = sql_collist(",", cpu)   // カラムの取得
    split col_clist, ",", col_clist     // カラムを配列に
~~~

* ### リストビュー設置部分

~~~ cpp
    mylv 400, 300, hLVcpu                           // リストビュー設置
    incolm hLVcpu, col_clist, length(cpu), col_cw   // カラムの追加
    insqlitem hLVcpu, cpu                           // 全レコードの追加
~~~

* ### レコードの取得

~~~ cpp
*getlvitem
    sdim getlist, 1024
    sdim syowlist, 1024

    getlvitem hLVcpu, length(cpu), getlist, 1024

    array2note syowlist, getlist

    dialog syowlist, 0, "Get items"
    return
~~~


* ### リストビューの並べ替え（SQLiteによるDB操作を利用）

~~~ cpp
*lvnotify
    // リストビューのオブジェクトハンドルとウィンドウメッセージ通知コード取得
    dupptr NMHDR, lparam, 12, 4  :  hLV = NMHDR(0)

    if (NMHDR(2) == LVN_COLUMNCLICK) {  //通知コードがカラムクリックだった場合に並べ替え

        // クリックされたカラムインデックス取得
        dupptr NMLV, lparam, 40, 4  :  index = NMLV(4)

        sql_open db     // DB OPEN

        switch hLV          // オブジェクトハンドルで分岐 -> 複数のリストビュー対応
            case hLVcpu

                sdim cpu, 2048          // レコードセット変数の初期化
                swc = swc * -1          // 昇降順の切り替え
                if (swc == -1) {sqsc = " DESC;"} else {sqsc = " ASC;"}

                sql_q "SELECT * FROM MyCPU ORDER BY " + col_clist(index) + sqsc, cpu

                dellv hLVcpu, 0, 2      // リストビューの全アイテム消去
                insqlitem hLVcpu, cpu   // 全データをリストビューに追加

                swbreak
        swend
        sql_close       // DB CLOSE
    }
    return
~~~

</details>


<br>

## 必要環境
* Windows11
* HSP3.6以上

## 使用言語
* [Hot Soup Processor(HSP3)](https://hsp.tv/)
* [SQLele](https://www.sqlite.org)

## 開発環境
* Windows11 Pro 22H2 x64
* Visual Studio Code 1.73.1
* HSP3.7beta4

***


本ソフトウェアおよび関連文書のファイル（以下「ソフトウェア」）の複製を取得するすべての人に対し、ソフトウェアを無制限に扱うことを無償で許可します。

これには、ソフトウェアの複製を使用、複写、変更、結合、掲載、頒布、サブライセンス、および/または販売する権利、およびソフトウェアを提供する相手に同じことを許可する権利も無制限に含まれます。

ソフトウェアは「現状のまま」で、明示であるか暗黙であるかを問わず、何らの保証もなく提供されます。ここでいう保証とは、商品性、特定の目的への適合性、および権利非侵害についての保証も含みますが、それに限定されるものではありません。

作者または著作権者は、契約行為、不法行為、またはそれ以外であろうと、ソフトウェアに起因または関連し、あるいはソフトウェアの使用またはその他の扱いによって生じる一切の請求、損害、その他の義務について何らの責任も負わないものとします。


## 更新履歴

### ver 0.30
2022/11/28
* オブジェクトIDを廃止. 全てオブジェクトハンドルを指定するようにパラメータの削減.
<!--  -->
* リストビュー設置命令`mylv命令`の設置後、システム変数`stat`にオブジェクトIDが代入されるように
<!--  -->
* リストビューにアイテムを追加する命令 `insqlitem命令`を新規追加
    * 2次元配列変数に対応可能となったのでsqleleのレコードセット変数をそのまま扱える
<!--  -->
* アイテムの文字列取得命令を改良。
    * `getlvitem命令`で区切り文字を選択できるように（初期値は ","）
<!--  -->
* 従来の削除系の命令`mydelitem命令`を削除。
    * `dellv命令`を新規追加し、アイテム、カラム、全アイテムの3つから削除モードを選べるように.


### ver 0.2.0
2022/10/25 : サンプルファイル及びヘルプファイルの修正

### ver 0.1.4
2022/10/20 : 一部表示情報の微修正

### ver 0.1.3
2022/10/12 : カラム幅が同じリストビューの設置に特化した myincol2命令を追加

### ver 0.1.2
2022/10 : 初公開