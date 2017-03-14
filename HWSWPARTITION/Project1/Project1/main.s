	cpu LMM
	.module main.c
	.area text(rom, con, rel)
	.dbfile ./main.c
	.area data(ram, con, rel)
	.dbfile ./main.c
_data_re::
	.word 0x0,0x0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0
	.byte 0,0
	.dbfile C:\Users\Anirudh\Desktop\EMBEDD~1\FINALP~1\Project1\Project1\fft.h
	.dbsym e data_re _data_re A[256:64]D
	.area data(ram, con, rel)
	.dbfile C:\Users\Anirudh\Desktop\EMBEDD~1\FINALP~1\Project1\Project1\fft.h
	.area data(ram, con, rel)
	.dbfile C:\Users\Anirudh\Desktop\EMBEDD~1\FINALP~1\Project1\Project1\fft.h
_data_imm::
	.word 0x0,0x0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0
	.byte 0,0
	.dbsym e data_imm _data_imm A[256:64]D
	.area data(ram, con, rel)
	.dbfile C:\Users\Anirudh\Desktop\EMBEDD~1\FINALP~1\Project1\Project1\fft.h
	.area data(ram, con, rel)
	.dbfile C:\Users\Anirudh\Desktop\EMBEDD~1\FINALP~1\Project1\Project1\fft.h
_maxAmp::
	.word 0
	.dbsym e maxAmp _maxAmp I
	.area data(ram, con, rel)
	.dbfile C:\Users\Anirudh\Desktop\EMBEDD~1\FINALP~1\Project1\Project1\fft.h
	.area data(ram, con, rel)
	.dbfile C:\Users\Anirudh\Desktop\EMBEDD~1\FINALP~1\Project1\Project1\fft.h
_maxFreq::
	.word 0
	.dbsym e maxFreq _maxFreq I
	.area data(ram, con, rel)
	.dbfile C:\Users\Anirudh\Desktop\EMBEDD~1\FINALP~1\Project1\Project1\fft.h
	.area data(ram, con, rel)
	.dbfile C:\Users\Anirudh\Desktop\EMBEDD~1\FINALP~1\Project1\Project1\fft.h
_points::
	.word 0,1
	.dbsym e points _points L
	.area data(ram, con, rel)
	.dbfile C:\Users\Anirudh\Desktop\EMBEDD~1\FINALP~1\Project1\Project1\fft.h
	.area data(ram, con, rel)
	.dbfile C:\Users\Anirudh\Desktop\EMBEDD~1\FINALP~1\Project1\Project1\fft.h
_count::
	.word 0
	.dbsym e count _count I
	.area data(ram, con, rel)
	.dbfile C:\Users\Anirudh\Desktop\EMBEDD~1\FINALP~1\Project1\Project1\fft.h
