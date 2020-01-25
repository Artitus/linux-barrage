#!/bin/bash

media() {
	mkdir recon

    echo "--- Log all the bad media files!"
	cp_home_ext=(
        ico
        svg
        svgz
        qt
        abs
        jpeg
        jpg
        png
        gif
		php
    )
	touch ./recon/bad_files.log
    for x in ${cp_home_ext[*]}; do
		while IFS= read -r -d '' file; do
			echo $file >> ./recon/bad_files.log
		done < <(find /home/ -type f -name *.$x -print0)
	done

	cp_os_ext=(
		3g2
		3gp2
		3gp
		3gpp
		aac
		adt
		adts
		aif
		aifc
		aiff
		art
		asf
		asm
		asr
		asx
		au
		avi
		bas
		bmp
		c
		cmx
		cnf
		cod
		cpp
		css
		dib
		disco
		dll config
		dlm
		doc
		docm
		docx
		dot
		dotm
		dotx
		dtd
		dvr-ms
		dwf
		etx
		exe
		config
		flv
		gif
		gtar
		gz
		h
		hdml
		hta
		htc
		htm
		html
		htt
		hxt
		ico
		ics
		ief
		IVF
		jar
		java
		jfif
		jpb
		jpe
		jpeg
		jpg
		js
		json
		jsx
		less
		lsf
		lsx
		m1v
		m2ts
		m3u
		m4a
		m4v
		map
		mid
		midi
		mno
		mov
		movie
		mp2
		mp3
		mp4
		mp4v
		mpa
		mpe
		mpeg
		mpg
		mpv2
		nsc
		odc
		oga
		ogg
		ogv
		otf
		pbm
		pdf
		pgm
		png
		pnm
		pnz
		ppm
		pps
		ppsm
		ppsx
		ppt
		pptm
		pptx
		prf
		ps
		qt
		qtl
		qxd
		ra
		ram
		rar
		ras
		rf
		rgb
		rmi
		rpm
		rtf
		rtx
		sct
		sh
		sldm
		sldx
		smd
		smx
		smz
		snd
		spx
		svg
		svgz
		swf
		tar
		tgz
		thn
		tif
		tiff
		ts
		ttf
		tts
		txt
		vml
		wav
		wax
		wbmp
		webm
		wm
		wma
		wml
		wmls
		wmp
		wmv
		wmx
		wtv
		wvx
		xaml
		xap
		xbap
		xbm
		xdr
		xla
		xlam
		xlc
		xlm
		xls
		xlsb
		xlsm
		xlsx
		xlt
		xltm
		xltx
		xlw
		xml
		xpm
		xsd
		xsf
		xsl
		xslt
		xwd
		zip
		pcx
		flac
		mod
		mpega
		sid
		dl
		movi
		mv
		iff
		anim5
		anim3
		anim7
		vfw
		avx
		fli
		flc
		spl
		dcr
		dxr
		rm
		smi
		rv
		im1
    )

	for x in ${cp_os_ext[*]}; do
		#Explanations
		#Find (in "/") of type file, names matching '*.$x', printing as null terminated strings into the while loop
		#which reads raw input delimited by '' (a null character) into the variable $file
		#Then for each file, pipe into xargs to remove!
		while IFS= read -r -d $'\0' file; do
			echo $file >> ./recon/bad_files.log
		done < <(find / -type f \( -path /run -o -path /proc \) -prune -o -name *$x -print0)
	done

	cp_bad_perms=(
		777
		776
		775
		774
		773
		772
		771
		770
		767
		766
		765
		764
		763
		762
		761
		760
		757
		756
		755
		754
		753
		752
		751
		750
		747
		746
		745
		744
		743
		742
		741
		740
		737
		736
		735
		734
		733
		732
		731
		730
		727
		726
		725
		724
		723
		722
		721
		720
		717
		716
		715
		714
		713
		712
		711
		710
		707
		706
		705
		704
		703
		702
		701
		700
	)

	for x in ${cp_bad_perms[*]}; do
		while IFS= read -r -d '' file; do
			echo $file >> ./recon/bad_files.log
		done < <(find / -type f \( -path /run -o -path /proc \) -prune -o -perm $x -print0)
		
	done

	touch ./recon/hacks.log
	dpkg -l | egrep "crack|hack" >> ./recon/hacks.log

	ls -laR /  | grep rwxrwxrwx | grep -v "lrwx" &> ./recon/bad_files.log

	touch ./recon/hidden_files.log
	find / -name ".*" -print0 >> ./recon/hidden_files.log

	touch ./recon/hidden_root_users.log
	hUSER=`cut -d: -f1,3 /etc/passwd | egrep ':[0]{1}$' | cut -d: -f1`
	echo "$hUSER" >> ./recon/hidden_root_users.log
}

users() {
    ##Look for valid users that have different UID that not 1000+
	cut -d: -f1,3 /etc/passwd | egrep ':[0-9]{4}$' | cut -d: -f1 > users.log
}

processes() {
	lsof -Pnl +M -i > ./recon/runningProcesses.log
	##Removing the default running processes
	sed -i '/avahi-dae/ d' ./recon/runningProcesses.log
	sed -i '/cups-brow/ d' ./recon/runningProcesses.log
	sed -i '/dhclient/ d' ./recon/runningProcesses.log
	sed -i '/dnsmasq/ d' ./recon/runningProcesses.log
	sed -i '/cupsd/ d' ./recon/runningProcesses.log
}

media
users
processes