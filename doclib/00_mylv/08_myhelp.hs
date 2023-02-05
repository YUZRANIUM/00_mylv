; INFO ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; FileName : 08_myhelp.hs
; Version  : 0.30
; Date     : 2022/11/28
; Author   : YUZRANIUM（ゆずらにうむ）
; Twitter  : https://twitter.com/YUZRANIUM
; GitHub   : https://github.com/YUZRANIUM/00_mylv
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
; Description
; 00_mylv.hspのヘルプファイルです。
;━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

%date
2022/11/28
%author
YUZRANIUM
%url
https://twitter.com/YUZRANIUM
https://github.com/YUZRANIUM/00_mylv
HSPの裏技??http://chokuto.ifdef.jp/urawaza/index.html
%dll
00_mylv
%ver
0.30
%port
Win
%note
00_mylv.hspとuser32.asをインクルードすること


;===============================================================================


%index
mylv
リストビュー設置
%prm
p1,p2,p3
p1,p2 : リストビューのXサイズ、Yサイズ
p3 : オブジェクトハンドルを受け取る変数
%inst
この命令はリストビューをカレントポジションに設置するものです。
^
p1,p2でリストビューのXサイズ、Yサイズを指定します。
p3はご自身で整数型変数を用意する必要があります。
^
リストビュー設置後、システム変数statにオブジェクトIDが代入されます。
この後に列（カラム）を設置する命令とアイテムを設置する命令を行う必要があります。
%sample
...
column_w = 60, 60, 110, 85, 80, 80  ; カラムの幅

sql_open db
    sql_q "SELECT * FROM MyCPU;", cpu
sql_close

col_clis = sql_collist(",", cpu)    ; カラムリスト
split col_clis, ",", col_clis       ; カラムのリストを配列変数に

mylv 550, 280, hLVcpu                           ; リストビュー設置
incolm LVcpu, col_clis, length(cpu), column_w   ; 列（カラム）の設置
insqlitem LVcpu, cpu                            ; アイテムの設置

%href
incolm
incolm2
insqlitem
getlvitem
dellv
%group
オブジェクト制御命令
%type
ユーザー定義命令


;===============================================================================


%index
dellv
リストビュー消去
%prm
p1,p2,p3
p1    : リストビューのオブジェクトハンドル
p2(0) : 削除するタイプ(0 = アイテム, 1 = カラム, 2 = アイテムの全削除)
p3    : 削除するアイテム,カラムのインデックス
%inst
指定されたリストビューに関する要素の削除を行います。
^
p1にはリストビューのオブジェクトハンドルを指定して下さい。
p2には削除タイプを指定して下さい。
p3には削除したいアイテムもしくはカラムのインデックス（0～）を指定して下さい。
^
p2に指定できる削除タイプは以下になります
タイプ |    削除対象
------------------------
    0  | アイテム
    1  | カラム
    2  | アイテムの全削除
^
p2の削除タイプで2（アイテムの全消去）を指定した場合、p3にインデックスを指定する必要はありません。


%sample
//リストビュー昇降順の処理
*notify
dupptr nmhdr, lparam, 12, 4 : tabhwnd = nmhdr(0)
if (nmhdr(2) == LVN_COLUMNCLICK) {
    dupptr nmlv, lparam, 40, 4 : index = nmlv(4)

    sql_open db
    switch tabhwnd

        case hLVcpu
            sdim cpu, 2048
            swc = swc * -1
            if (swc == -1) {sqsc = " DESC;"} else {sqsc = " ASC;"}

            sql_q "SELECT * FROM MyCPU ORDER BY " + col_clis(index) + sqsc, cpu
            dellv id_LVcpu, 2
            insqlitem id_LVcpu, cpu
            swbreak
%href
incolm
incolm2
insqlitem
%group
オブジェクト制御命令
%type
ユーザー定義命令


;===============================================================================


%index
getlvitem
リストビューのアイテム取得
%prm
p1,p2,p3,p4,p5
p1      : リストビューのオブジェクトハンドル
p2      : カラムの数
p3      : 取得文字列を受け取る配列変数
p4      : 配列変数のバッファサイズ
p5(",") : 区切り文字
%inst
選択されたリストビューのアイテムを文字列として取得し、1次元配列変数として出力する命令です。
^
p1にはリストビューのオブジェクトハンドルを指定して下さい。
p2にはカラムの数を指定して下さい。sqlele併用時はlength()関数にレコードセット変数を指定することでカラムの数を取得できます。
p3には文字列型の配列変数を指定して下さい。
p4にはp3で指定した配列変数のバッファサイズを指定して下さい。
p5には取得したレコードをカラムごとに区切るための区切り用の文字列を指定して下さい。初期値では","となっています。

^
また、複数選択にも対応しているため規模にもよりますが、取得文字列を受け取る配列変数はそのバッファサイズを大きめに確保してください。
%sample

//選択したリストアイテムの取得
*getitem
    gsel 1

    sdim getlistC, 1024  :  sdim syowlist1, 1024
    sdim getlistG, 1024  :  sdim syowlist2, 1024
    sdim getlistR, 1024  :  sdim syowlist3, 1024

    getlvitem hLVcpu, length(cpu), getlistC, 1024
    getlvitem hLVgpu, 6, getlistG, 1024
    getlvitem hLVrom, 6, getlistR, 1024

    array2note syowlist1, getlistC
    array2note syowlist2, getlistG
    array2note syowlist3, getlistR

    dialog "購入リスト" + syowlist1 + syowlist2 + syowlist3, 0, "購入確認"

    return
%href
mylv
incolm
incolm2
insqlitem
length
%group
オブジェクト制御命令
%type
ユーザー定義命令


;===============================================================================


%index
incolm
カラムを個別指定追加
%prm
p1,p2,p3,p4,p5
p1    : 設置したリストビューのオブジェクトハンドル
p2    : カラムを格納した配列変数
p3    : カラムの数
p4    : カラムの幅を格納した配列変数
p5(0) : スタイル
%inst
この命令は、カラム幅を個別指定してリストビューを設置するものです。
^
p1で指定したリストビューにカラムを設置します。
p2は文字列型、
p4は整数型の1次元配列変数でなければなりません。
p5は左揃え、右揃え、中央揃えを指定することが出来ます。省略時は左揃えとなります。
^
    値  :   動作
    -----------------------
    0   :   左揃え
    1   :   右揃え
    2   :   中央揃え
^
この命令は、カラムの数が少なく、各アイテム幅の差が大きい場合に有効です。
^
%sample
...
    column_w = 60, 60, 110, 85, 80, 80  ; カラムの幅

    sql_open db
    sql_q "SELECT * FROM MyCPU;", cpu
    sql_close

    col_clis = sql_collist(",", cpu)    ; カラムリスト
    split col_clis, ",", col_clis       ; カラムのリストを配列変数に


    mylv 550, 280, hLVcpu                           ; リストビュー設置
    incolm hLVcpu, col_clis, length(cpu), column_w  ; 列（カラム）の設置
    insqlitem hLVcpu, cpu                           ; アイテムの設置

%href
mylv
incolm
incolm2
insqlitem
dellv
%group
オブジェクト制御命令
%type
ユーザー定義命令


;===============================================================================


%index
incolm2
カラムを同一指定追加
%prm
p1,p2,p3,p4,p5
p1     : 設置したリストビューのオブジェクトハンドル
p2     : カラムを格納した配列変数
p3     : カラムの数
p4(75) : カラムの幅(整数値)
p5(0)  : スタイル
%inst
カラム幅を個別指定incolm命令のデメリットを補うためのものです。
^
p1で指定したリストビューにカラムを設置します。
p2は文字列型の1次元配列変数でなければなりません。
^
この命令はp4に整数値を直接指定することでリストビューの全てのカラム幅を同じ値にすることができます。
省略可能で、省略時は75となります。
^
p5は左揃え、右揃え、中央揃えを指定することが出来ます。省略時は左揃えとなります。
    値  :   動作
    -----------------------
    0   :   左揃え
    1   :   右揃え
    2   :   中央揃え
^
この命令は、カラムの数が多く、各アイテム幅の差がほとんどない場合に有効です。
^
%sample
...
    sql_open db
    sql_q "SELECT * FROM MyCPU;", cpu
    sql_close

    col_clis = sql_collist(",", cpu)    ; カラムリスト
    split col_clis, ",", col_clis       ; カラムのリストを配列変数に


    mylv 550, 280, hLVcpu                     ; リストビュー設置
    incolm2 hLVcpu, col_clis, length(cpu), 75 ; 列（カラム）の設置
    insqlitem hLVcpu, cpu                     ; アイテムの設置
%href
mylv
incolm
insqlitem
dellv
%group
オブジェクト制御命令
%type
ユーザー定義命令


;===============================================================================


%index
inlvitem
アイテム追加
%prm
p1,p2,p3,p4
p1 : 設置したリストビューのオブジェクトハンドル
p2 : レコードを格納した変数（1次元配列変数）
p3 : レコードの数
p4 : カラムの数
%inst
p1にはリストビューのオブジェクトハンドルを指定して下さい。



%sample

%group
オブジェクト制御命令
%type
ユーザー定義命令
%href
insqlitem
incolm
incolm2


;===============================================================================


%index
insqlitem
アイテム追加2
%prm
p1,p2
p1 : 設置したリストビューのオブジェクトハンドル
p2 : レコードセット変数（2次元配列変数）
%inst
この命令はsqleleのレコードセット変数のデータをリストビューにアイテムとして追加するものです。
^
p1にはリストビューのオブジェクトハンドルを指定して下さい。
p2にはsqleleのレコードセット変数を指定して下さい。
^

^
%sample
...
    column_w = 60, 60, 110, 85, 80, 80  ; カラムの幅

    sql_open db
    sql_q "SELECT * FROM MyCPU;", cpu
    sql_close

    col_clis = sql_collist(",", cpu)    ; カラムリスト
    split col_clis, ",", col_clis       ; カラムのリストを配列変数に

    mylv 550, 280, hLVcpu                           ; リストビュー設置
    incolm hLVcpu, col_clis, length(cpu), column_w  ; 列（カラム）の設置
    insqlitem hLVcpu, cpu                           ; アイテムの設置

%href
inlvitem
incolm
incolm2
%group
オブジェクト制御命令
%type
ユーザー定義命令


;===============================================================================