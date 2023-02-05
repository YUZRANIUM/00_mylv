; INFO ������������������������������������������������������������������������������
; FileName : 08_myhelp.hs
; Version  : 0.30
; Date     : 2022/11/28
; Author   : YUZRANIUM�i�䂸��ɂ��ށj
; Twitter  : https://twitter.com/YUZRANIUM
; GitHub   : https://github.com/YUZRANIUM/00_mylv
;������������������������������������������������������������������������������������
; Description
; 00_mylv.hsp�̃w���v�t�@�C���ł��B
;������������������������������������������������������������������������������������

%date
2022/11/28
%author
YUZRANIUM
%url
https://twitter.com/YUZRANIUM
https://github.com/YUZRANIUM/00_mylv
HSP�̗��Z??http://chokuto.ifdef.jp/urawaza/index.html
%dll
00_mylv
%ver
0.30
%port
Win
%note
00_mylv.hsp��user32.as���C���N���[�h���邱��


;===============================================================================


%index
mylv
���X�g�r���[�ݒu
%prm
p1,p2,p3
p1,p2 : ���X�g�r���[��X�T�C�Y�AY�T�C�Y
p3 : �I�u�W�F�N�g�n���h�����󂯎��ϐ�
%inst
���̖��߂̓��X�g�r���[���J�����g�|�W�V�����ɐݒu������̂ł��B
^
p1,p2�Ń��X�g�r���[��X�T�C�Y�AY�T�C�Y���w�肵�܂��B
p3�͂����g�Ő����^�ϐ���p�ӂ���K�v������܂��B
^
���X�g�r���[�ݒu��A�V�X�e���ϐ�stat�ɃI�u�W�F�N�gID���������܂��B
���̌�ɗ�i�J�����j��ݒu���閽�߂ƃA�C�e����ݒu���閽�߂��s���K�v������܂��B
%sample
...
column_w = 60, 60, 110, 85, 80, 80  ; �J�����̕�

sql_open db
    sql_q "SELECT * FROM MyCPU;", cpu
sql_close

col_clis = sql_collist(",", cpu)    ; �J�������X�g
split col_clis, ",", col_clis       ; �J�����̃��X�g��z��ϐ���

mylv 550, 280, hLVcpu                           ; ���X�g�r���[�ݒu
incolm LVcpu, col_clis, length(cpu), column_w   ; ��i�J�����j�̐ݒu
insqlitem LVcpu, cpu                            ; �A�C�e���̐ݒu

%href
incolm
incolm2
insqlitem
getlvitem
dellv
%group
�I�u�W�F�N�g���䖽��
%type
���[�U�[��`����


;===============================================================================


%index
dellv
���X�g�r���[����
%prm
p1,p2,p3
p1    : ���X�g�r���[�̃I�u�W�F�N�g�n���h��
p2(0) : �폜����^�C�v(0 = �A�C�e��, 1 = �J����, 2 = �A�C�e���̑S�폜)
p3    : �폜����A�C�e��,�J�����̃C���f�b�N�X
%inst
�w�肳�ꂽ���X�g�r���[�Ɋւ���v�f�̍폜���s���܂��B
^
p1�ɂ̓��X�g�r���[�̃I�u�W�F�N�g�n���h�����w�肵�ĉ������B
p2�ɂ͍폜�^�C�v���w�肵�ĉ������B
p3�ɂ͍폜�������A�C�e���������̓J�����̃C���f�b�N�X�i0�`�j���w�肵�ĉ������B
^
p2�Ɏw��ł���폜�^�C�v�͈ȉ��ɂȂ�܂�
�^�C�v |    �폜�Ώ�
------------------------
    0  | �A�C�e��
    1  | �J����
    2  | �A�C�e���̑S�폜
^
p2�̍폜�^�C�v��2�i�A�C�e���̑S�����j���w�肵���ꍇ�Ap3�ɃC���f�b�N�X���w�肷��K�v�͂���܂���B


%sample
//���X�g�r���[���~���̏���
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
�I�u�W�F�N�g���䖽��
%type
���[�U�[��`����


;===============================================================================


%index
getlvitem
���X�g�r���[�̃A�C�e���擾
%prm
p1,p2,p3,p4,p5
p1      : ���X�g�r���[�̃I�u�W�F�N�g�n���h��
p2      : �J�����̐�
p3      : �擾��������󂯎��z��ϐ�
p4      : �z��ϐ��̃o�b�t�@�T�C�Y
p5(",") : ��؂蕶��
%inst
�I�����ꂽ���X�g�r���[�̃A�C�e���𕶎���Ƃ��Ď擾���A1�����z��ϐ��Ƃ��ďo�͂��閽�߂ł��B
^
p1�ɂ̓��X�g�r���[�̃I�u�W�F�N�g�n���h�����w�肵�ĉ������B
p2�ɂ̓J�����̐����w�肵�ĉ������Bsqlele���p����length()�֐��Ƀ��R�[�h�Z�b�g�ϐ����w�肷�邱�ƂŃJ�����̐����擾�ł��܂��B
p3�ɂ͕�����^�̔z��ϐ����w�肵�ĉ������B
p4�ɂ�p3�Ŏw�肵���z��ϐ��̃o�b�t�@�T�C�Y���w�肵�ĉ������B
p5�ɂ͎擾�������R�[�h���J�������Ƃɋ�؂邽�߂̋�؂�p�̕�������w�肵�ĉ������B�����l�ł�","�ƂȂ��Ă��܂��B

^
�܂��A�����I���ɂ��Ή����Ă��邽�ߋK�͂ɂ����܂����A�擾��������󂯎��z��ϐ��͂��̃o�b�t�@�T�C�Y��傫�߂Ɋm�ۂ��Ă��������B
%sample

//�I���������X�g�A�C�e���̎擾
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

    dialog "�w�����X�g" + syowlist1 + syowlist2 + syowlist3, 0, "�w���m�F"

    return
%href
mylv
incolm
incolm2
insqlitem
length
%group
�I�u�W�F�N�g���䖽��
%type
���[�U�[��`����


;===============================================================================


%index
incolm
�J�������ʎw��ǉ�
%prm
p1,p2,p3,p4,p5
p1    : �ݒu�������X�g�r���[�̃I�u�W�F�N�g�n���h��
p2    : �J�������i�[�����z��ϐ�
p3    : �J�����̐�
p4    : �J�����̕����i�[�����z��ϐ�
p5(0) : �X�^�C��
%inst
���̖��߂́A�J���������ʎw�肵�ă��X�g�r���[��ݒu������̂ł��B
^
p1�Ŏw�肵�����X�g�r���[�ɃJ������ݒu���܂��B
p2�͕�����^�A
p4�͐����^��1�����z��ϐ��łȂ���΂Ȃ�܂���B
p5�͍������A�E�����A�����������w�肷�邱�Ƃ��o���܂��B�ȗ����͍������ƂȂ�܂��B
^
    �l  :   ����
    -----------------------
    0   :   ������
    1   :   �E����
    2   :   ��������
^
���̖��߂́A�J�����̐������Ȃ��A�e�A�C�e�����̍����傫���ꍇ�ɗL���ł��B
^
%sample
...
    column_w = 60, 60, 110, 85, 80, 80  ; �J�����̕�

    sql_open db
    sql_q "SELECT * FROM MyCPU;", cpu
    sql_close

    col_clis = sql_collist(",", cpu)    ; �J�������X�g
    split col_clis, ",", col_clis       ; �J�����̃��X�g��z��ϐ���


    mylv 550, 280, hLVcpu                           ; ���X�g�r���[�ݒu
    incolm hLVcpu, col_clis, length(cpu), column_w  ; ��i�J�����j�̐ݒu
    insqlitem hLVcpu, cpu                           ; �A�C�e���̐ݒu

%href
mylv
incolm
incolm2
insqlitem
dellv
%group
�I�u�W�F�N�g���䖽��
%type
���[�U�[��`����


;===============================================================================


%index
incolm2
�J�����𓯈�w��ǉ�
%prm
p1,p2,p3,p4,p5
p1     : �ݒu�������X�g�r���[�̃I�u�W�F�N�g�n���h��
p2     : �J�������i�[�����z��ϐ�
p3     : �J�����̐�
p4(75) : �J�����̕�(�����l)
p5(0)  : �X�^�C��
%inst
�J���������ʎw��incolm���߂̃f�����b�g��₤���߂̂��̂ł��B
^
p1�Ŏw�肵�����X�g�r���[�ɃJ������ݒu���܂��B
p2�͕�����^��1�����z��ϐ��łȂ���΂Ȃ�܂���B
^
���̖��߂�p4�ɐ����l�𒼐ڎw�肷�邱�ƂŃ��X�g�r���[�̑S�ẴJ�������𓯂��l�ɂ��邱�Ƃ��ł��܂��B
�ȗ��\�ŁA�ȗ�����75�ƂȂ�܂��B
^
p5�͍������A�E�����A�����������w�肷�邱�Ƃ��o���܂��B�ȗ����͍������ƂȂ�܂��B
    �l  :   ����
    -----------------------
    0   :   ������
    1   :   �E����
    2   :   ��������
^
���̖��߂́A�J�����̐��������A�e�A�C�e�����̍����قƂ�ǂȂ��ꍇ�ɗL���ł��B
^
%sample
...
    sql_open db
    sql_q "SELECT * FROM MyCPU;", cpu
    sql_close

    col_clis = sql_collist(",", cpu)    ; �J�������X�g
    split col_clis, ",", col_clis       ; �J�����̃��X�g��z��ϐ���


    mylv 550, 280, hLVcpu                     ; ���X�g�r���[�ݒu
    incolm2 hLVcpu, col_clis, length(cpu), 75 ; ��i�J�����j�̐ݒu
    insqlitem hLVcpu, cpu                     ; �A�C�e���̐ݒu
%href
mylv
incolm
insqlitem
dellv
%group
�I�u�W�F�N�g���䖽��
%type
���[�U�[��`����


;===============================================================================


%index
inlvitem
�A�C�e���ǉ�
%prm
p1,p2,p3,p4
p1 : �ݒu�������X�g�r���[�̃I�u�W�F�N�g�n���h��
p2 : ���R�[�h���i�[�����ϐ��i1�����z��ϐ��j
p3 : ���R�[�h�̐�
p4 : �J�����̐�
%inst
p1�ɂ̓��X�g�r���[�̃I�u�W�F�N�g�n���h�����w�肵�ĉ������B



%sample

%group
�I�u�W�F�N�g���䖽��
%type
���[�U�[��`����
%href
insqlitem
incolm
incolm2


;===============================================================================


%index
insqlitem
�A�C�e���ǉ�2
%prm
p1,p2
p1 : �ݒu�������X�g�r���[�̃I�u�W�F�N�g�n���h��
p2 : ���R�[�h�Z�b�g�ϐ��i2�����z��ϐ��j
%inst
���̖��߂�sqlele�̃��R�[�h�Z�b�g�ϐ��̃f�[�^�����X�g�r���[�ɃA�C�e���Ƃ��Ēǉ�������̂ł��B
^
p1�ɂ̓��X�g�r���[�̃I�u�W�F�N�g�n���h�����w�肵�ĉ������B
p2�ɂ�sqlele�̃��R�[�h�Z�b�g�ϐ����w�肵�ĉ������B
^

^
%sample
...
    column_w = 60, 60, 110, 85, 80, 80  ; �J�����̕�

    sql_open db
    sql_q "SELECT * FROM MyCPU;", cpu
    sql_close

    col_clis = sql_collist(",", cpu)    ; �J�������X�g
    split col_clis, ",", col_clis       ; �J�����̃��X�g��z��ϐ���

    mylv 550, 280, hLVcpu                           ; ���X�g�r���[�ݒu
    incolm hLVcpu, col_clis, length(cpu), column_w  ; ��i�J�����j�̐ݒu
    insqlitem hLVcpu, cpu                           ; �A�C�e���̐ݒu

%href
inlvitem
incolm
incolm2
%group
�I�u�W�F�N�g���䖽��
%type
���[�U�[��`����


;===============================================================================