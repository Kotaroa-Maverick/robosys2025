#!/bin/bash
#SPDX-FileCopyrightText: 2025 Kota Iwasaki
#SPDX-License-Identifier:BSD-3-Clause

PROG="python3 luckynumber"

ng () {
	echo "${1}行目が違うよ"
	res=1
}

res=0

chmod +x luckynumber

# 正常な入力（成功）テスト
test_normal_input() {
    local input=$1
    local expected_output_part=$2
    local line=$3

    # printfで入力をプログラムに渡す
    out=$(printf "%s\n" "$input" | $PROG)
    
    # 期待される出力の一部（ラッキーナンバーの行）が含まれているか確認
    # 'ラッキーナンバーは [数字] です！' の形式をチェック
    if ! echo "$out" | grep -q "**あなたのラッキーナンバーは ${expected_output_part} です！**"; then
        ng "$line"
        echo "   -> 期待: ラッキーナンバー ${expected_output_part} を含む"
        echo "   -> 実際: ${out}"
    fi
}

# 異常な入力（失敗）テスト
# 現在のPythonスクリプトは、エラーがあってもループで再入力を促すため、
# 終了ステータスではなく、出力されるエラーメッセージをチェックします。
test_error_input() {
    local input=$1
    local expected_error_part=$2
    local line=$3

    # printfで入力をプログラムに渡し、その後EOFで終了させる
    # ループ内で再入力を求められると、EOFでプログラムが終了します。
    out=$(printf "%s\n" "$input" | $PROG)
    
    # 期待されるエラーメッセージの一部が含まれているか確認
    if ! echo "$out" | grep -q "${expected_error_part}"; then
        ng "$line"
        echo "   -> 期待: エラーメッセージ '${expected_error_part}' を含む"
        echo "   -> 実際: ${out}"
    fi
}

# テストケース実行

## NORMAL INPUT (生年月日 19901231 の場合、ラッキーナンバーは 8)
# 1+9+9+0+1+2+3+1 = 26 -> 2+6 = 8
test_normal_input "19901231" "8" "$LINENO"

## BORDERLINE INPUT (すべて9の場合: 99999999 -> 72 -> 9)
test_normal_input "99999999" "9" "$LINENO"

## STRANGE INPUT 1 (数字ではない)
# エラーメッセージは '8桁の数字で入力してください。'
test_error_input "あいうえおかきく" "8桁の数字で入力してください" "$LINENO"

## STRANGE INPUT 2 (8桁ではない)
# エラーメッセージは '8桁の数字で入力してください。'
test_error_input "12345" "8桁の数字で入力してください" "$LINENO"

## STRANGE INPUT 3 (無効な日付)
# エラーメッセージは '無効な日付形式です。'
test_error_input "20250230" "無効な日付形式です" "$LINENO"


# 結果出力

[ "${res}" = 0 ] && echo "OK" || echo "NG"
exit $res
