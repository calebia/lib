#!/bin/bash

# Provide default values
: ${TEAMNAME:="L_Dies"}
: ${MEMBERS:="Nivea"}
: ${UNIVERSITY:="UFCG"}

cat > env.tex <<EOF
\def\teamname{$TEAMNAME}
\def\teammembers{$MEMBERS}
\def\teamuni{$UNIVERSITY}
EOF

g++ -std=c++17 -o getlatex getlatex.cpp -O2
./getlatex $1 > lib.tex
rubber -d lib
mv lib.pdf ../pdf
rm tmp.cpp
rm getlatex lib.aux lib.toc lib.out
rm -f lib.rubbercache

pushd ../theoretical
latexmk -pdf theoretical -outdir=../pdf
latexmk -pdf theoretical -outdir=../pdf -c
popd

rm env.tex
