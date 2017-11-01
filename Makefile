# このMakefileはtexのタイプセットを行います。
# platexとdvipdfmxが動く事を前提としています。
# これらのコマンドは変更することができます。

# 画像のパス
IMG_DIR=./img

# 拡張子.texのファイルの拡張子を省略した文字列を取得
TEXFILES=$(shell \ls|grep .tex|sed -e 's/.tex//g')
TEX=$(FILENAME).tex
IDX=$(FILENAME).idx
DVI=$(FILENAME).dvi
PDF=$(FILENAME).pdf
OUTPUT=output_$(FILENAME).pdf

############################
# OS毎に使うコマンドを設定 #
############################
ifeq ($(OS),Windows_NT)
	OS_CHECK=Windows

	####### for Windows #######
	# pdfを開くコマンド
	PDF_VIEWER=
	# xbbファイルを生成するコマンド
	MAKE_XBB=extractbb
else
	UNAME = ${shell uname}
	ifeq ($(UNAME),Linux)
		OS_CHECK=Linux

		####### for Linux ##########
		# pdfを開くコマンド
		PDF_VIEWER=evince
		# xbbファイルを生成するコマンド
		MAKE_XBB=extractbb
		endif
	ifeq ($(UNAME),Darwin)
		OS_CHECK=macOS

		####### for macOS ##########
		# pdfを開くコマンド
		PDF_VIEWER=open
		# xbbファイルを生成するコマンド
		MAKE_XBB=extractbb
	endif
endif
############################


all:
	@echo $(OS_CHECK)
#	make img
	$(foreach tex,$(TEXFILES),make makePDF FILENAME=$(tex); )

.PHONY: img clean makePDF
makePDF:
	@echo $(file)
	make tex
	make tex
	make dvi2pdf
	make clean
	mv $(PDF) $(OUTPUT)
	make openPDF

# xbbファイルの生成
img:
	$(MAKE_XBB) $(IMG_DIR)/*

tex:
	platex $(TEX)
dvi2pdf:
	dvipdfmx $(DVI)
clean:
	rm -rf *.aux *.dvi *.idx *.ilg *.ind *.log *.out *.toc *.swp *.tex~ *.py~ .nfs*

# 生成したPDFを開く
openPDF:
	$(PDF_VIEWER) $(OUTPUT) &



