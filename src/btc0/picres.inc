L000000:
	dc.l	0xFC000400								;0
	dc.l	0xFC070420								;
	dc.l	0xFC0E0440								;
	dc.l	0xFC150460								;
	dc.l	0xFC1C0480								;
	dc.l	0xFC1E5280								;
	dc.l	0xFC1FCFE0								;
	dc.l	0xFC215040								;
	dc.l	0xFC21B260 								;
	dc.l	0xFC221480								;
	dc.l	0xFC2276A0								;
	dc.l	0xFC22B7C0 								;
	dc.l	0xFC22F8E0								;
	dc.l	0xFC233A00								;L046740	//13
	dc.l	0xFC285AA0								;L050B54	//14

L100000:
	dc.l	0xFC800400,0xFC9C1C00  
	dc.l	0xFCA01C00,0xFCC33C00  
	dc.l	0xFCD33C00,0xFCE36C00  
	dc.l	0xFCE76C00,0xFCE76C20  
	dc.l	0xFCE76C40,0xFD039C40  
	dc.l	0xFD081C40,0xFD0FBC40  
	dc.l	0xFD0FDC40,0xFD0FDC60 
	dc.l	0xFD0FDC80,0xFD229480  
	dc.l	0xFD269480,0xFD28D480  
	dc.l	0xFD29D480,0xFD34CC80  
	dc.l	0xFD350C80,0xFD3BBC80  
	dc.l	0xFD3C3C80,0xFD3C3CA0  
	dc.l	0xFD3C3CC0,0xFD41E4C0  


L360000:
	dc.l	0xFC800000  							;L100000
L360004:
	dc.l	0xFF100000  							;L620000

L046740:
	.include "btc0_img13.bin"						;500x84 8bpp
L050B54:
	.include "btc0_img14.bin"						;30x174 8bpp


L620000:
	dc.l	0xFF100600  
	dc.l	0xFF1E0620  
	dc.l	0xFF220640 
	dc.l	L645CCC 
	dc.l	0xFF2AE680  
	dc.l	0xFF2AEAA0  
	dc.l	0xFF3AEAC0  
	dc.l	0xFF3B9BD8  
	dc.l	0xFF4B9BF8  
	dc.l	0xFF51EB38  
	dc.l	0xFF52E518  
	dc.l	0xFF53DEF8  
	dc.l	0xFF54D8D8  
	dc.l	0xFF55D2B8  
	dc.l	0xFF56CC98  
	dc.l	0xFF57C678  
	dc.l	0xFF58C058  
	dc.l	0xFF59BA38  
	dc.l	0xFF5AC7F0  
	dc.l	0xFF5C2C00  
	dc.l	0xFF5E3F50  
	dc.l	0xFF5FE688  
	dc.l	0xFF5FF6D0  
	dc.l	0xFF6147B0  
	dc.l	0xFF631FF0  
	dc.l	0xFF632D40  
	dc.l	0xFF6483D0  
	dc.l	0xFF67A930  
	dc.l	L6CF734								;  
	dc.l	0xFF6D2AD0  
	dc.l	0xFF73B520  
	dc.l	0xFF7A12C0  
	dc.l	0xFF7C6850  
	dc.l	0xFF822080  
	dc.l	0xFF86AFE0  
	dc.l	0xFF88BB10  
	dc.l	0xFF8D9370  

L6CF734:




L77E4B4:
	.include "font8x8.bin"

L77EC64:										;void* player_avatar_list[9]
	dc.l	0xFFBF72C8  
	dc.l	0xFFBF7828								;L77EF05
	dc.l	0xFFBF7C08
	dc.l	0xFFBF7FE8
	dc.l	0xFFBF8548
	dc.l	0xFFBF8928
	dc.l	0xFFBF6440
	dc.l	0xFFBF6918
	dc.l	0xFFBF6DF0


