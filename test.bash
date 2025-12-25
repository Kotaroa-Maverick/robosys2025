#!/bin/bash
#SPDX-FileCopyrightText: 2025 Kota Iwasaki
#SPDX-License-Identifier:BSD-3-Clause


ng () {
	echo "${1}行目が違うよ"
	res=1
}

res=0

out=$(echo "5" | ./luckynumber)
[ "${out}" = 15 ] || ng "$LINENO"

out=$(echo "あ" | ./luckynumber)
[ "$?" = 1 ]      || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(echo | ./luckynumber)
[ "$?" = 1 ]      || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

[ "${res}" = 0 ] && echo "OK"
exit $res
