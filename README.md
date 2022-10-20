## マイ･リストビューver 0.1.4

* ### たった3行でリストビューを設置できます()

 | ![mylv09](https://user-images.githubusercontent.com/83401251/195272530-d8e14629-fb4e-4794-82a1-b06937b9c067.png)<br><br>サンプル 00_mylvsample.hsp より | ![mylv20221011](https://user-images.githubusercontent.com/83401251/195083006-a499adee-a00d-4e33-9066-2b5a7e2ef537.png)<br>同梱サンプルファイル実行の様子 |
 | ------------------------------------------------------------------------------------------------------------------------------------------------------: | -------------------------------------------------------------------------------------------------------------------------------------------------------: |

**今後、アップデートが不定期で行われる予定です。**

右のRelease、マイ･リストビューか、右上のcode（緑）からzipをダウンロードしてどうぞ

## 特徴

* リストビューの設置部分に関しては**アイテム数によらず３行で指定レコード（アイテム）全てを設置可能**

* 整数、実数、文字列をすべて**文字列型の1次元配列変数**として扱う

* 内部では文字列型の1次元配列変数として扱っているので、**CSVも変換することで対応可能**

* SQLite(SQLele)との連携が可能で、**場合によってはアイテム数やカラムの数などを把握していなくても設置が可能**

* SQLiteのデータベース（以下DB）操作により、**各カラムごとにレコードの昇順･降順が切替可能**<br>（実際は、アイテムを全削除しSQLでクエリ叩いてリストビューを作り直している。win32APIでアイテムの並び替えを実現しようと試みたが挫折。今後改善予定）


<br>

## 使用方法

~~~
.
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

![mylv11](https://user-images.githubusercontent.com/83401251/195515826-3340f36b-06f3-4b28-acfb-35debe2e14dd.png)

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

* ### 用意しなければならない変数一覧
| ![mylv04](https://user-images.githubusercontent.com/83401251/195087503-a21b35ae-8bbe-4cf2-99f7-1ad34fb70cf7.png) | ネストしたrepeat文をマクロ登録しているため、どうしても変数が多くなってしまいます。<br>`myincol2`命令を使用すればカラムの幅を個別指定せずに済みます。 |
| ---------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------- |

* ### SQLite(sqlele)連携によるデータの取得（例）

	![mylv05](https://user-images.githubusercontent.com/83401251/195269325-391d6fef-6487-4901-886e-87942e5e50c0.png)

* ### リストビュー設置部分

	![mylv06](https://user-images.githubusercontent.com/83401251/195269809-71fb2901-e363-45cb-add4-ba08379503cf.png)

* ### レコードの取得

	![mylv07](https://user-images.githubusercontent.com/83401251/195270442-530d382c-0796-4e5a-af5d-603a8bf2f56f.png)

* ### リストビューの並べ替え（SQLiteによるDB操作を利用）

	![mylv08](https://user-images.githubusercontent.com/83401251/195272012-384d142b-6de9-4237-a3a1-e46587d02ca6.png)

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
* Visual Studio Code
* HSP3.7beta3

***


本ソフトウェアおよび関連文書のファイル（以下「ソフトウェア」）の複製を取得するすべての人に対し、ソフトウェアを無制限に扱うことを無償で許可します。

これには、ソフトウェアの複製を使用、複写、変更、結合、掲載、頒布、サブライセンス、および/または販売する権利、およびソフトウェアを提供する相手に同じことを許可する権利も無制限に含まれます。

ソフトウェアは「現状のまま」で、明示であるか暗黙であるかを問わず、何らの保証もなく提供されます。ここでいう保証とは、商品性、特定の目的への適合性、および権利非侵害についての保証も含みますが、それに限定されるものではありません。

作者または著作権者は、契約行為、不法行為、またはそれ以外であろうと、ソフトウェアに起因または関連し、あるいはソフトウェアの使用またはその他の扱いによって生じる一切の請求、損害、その他の義務について何らの責任も負わないものとします。


## 更新履歴

### ver 0.1.4
2022/10/20 : 一部表示情報の微修正

### ver 0.1.3
2022/10/12 : カラム幅が同じリストビューの設置に特化した myincol2命令を追加

### ver 0.1.2
2022/10 : 初公開