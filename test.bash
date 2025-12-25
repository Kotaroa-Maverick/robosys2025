#!/bin/bash
#SPDX-FileCopyrightText: 2025 Kota Iwasaki
#SPDX-License-Identifier:BSD-3-Clause

ng () {
	echo "${1}行目が違うよ"
	res=1
}

res=0

out=$(seq "21120903" | ./luckynumber)
[ "${out}" = 9] || ng "$LINENO"

out=$(echo "あ" | ./luckynumber)
[ "$?" = 1 ]      || ng "$LINENO"
[ "${out}" = "0" ] || ng "$LINENO"

out=$(echo "" | ./luckynumber)
[ "$?" = 1 ]      || ng "$LINENO"
[ "${out}" = "0" ] || ng "$LINENO"

out=$(echo "9999" | ./luckynumber)
[ "${out}" = "9" ] || ng "$LINENO"

[ "${res}" = 0 ] && echo "OK"
exit $res
