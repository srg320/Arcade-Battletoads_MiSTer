
L7FA024:										;main menu screen
	dc.w	0x0003,0x000F 							;normal color = 0x0F
	dc.w	0x0004,0x0006 							;active color = 0x06
	dc.w	0x0001,0x0010 							;y = 0x0010
	dc.w	0x0002,0x005E 							;x = 0x005E
	dc.w	0x0008,0x0005 							;color = 0x05
	dc.w	0x000A 								;draw title center
	dc.l	L7FA3B4 								;"BATTLETOADS MAIN MENU"
	dc.w	0x0008,0x000F 							;draw color = 0x0F
	dc.w	0x0001,0x0030 							;y = 0x0030
	dc.w	0x0002,0x000E 							;x = 0x000E
	dc.w	0x0009 								;add menu item
	dc.l	L7D8E4A								;L7D8E4A
	dc.w	0x0006 								;draw menu left
	dc.l	L7FA3CA								;"GAME SET UP"
	dc.w	0x0007								;next line
	dc.w	0x0007 								;next line
	dc.w	0x0009  								;add menu item
	dc.l	L7D8E9E  								;
	dc.w	0x0006  								;draw menu left
	dc.l	L7FA3D6 								;"GAME DIAGNOSTICS"
	dc.w	0x0007								;next line
	dc.w	0x0007 								;next line
	dc.w	0x0009  								;add menu item
	dc.l	L7D8EA6 								;L
	dc.w	0x0006  								;draw menu left
	dc.l	L7FA3E8 								;"GAME STATISTICS"
	dc.w	0x0007 								;next line
	dc.w	0x0007 								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009  								;add menu item
	dc.l	L7D8CD4 
	dc.w	0x0006  								;draw menu left
	dc.l	L7FA3F8 								;"RESTART GAME"
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0005   								;goto and exit
	dc.l	L7FA024  								;

L7FA098:										;game setup screen
	dc.w	0x0003,0x000F 							;normal color = 0x0F
	dc.w	0x0004,0x0006 							;active color = 0x06
	dc.w	0x0001,0x0010 							;y = 0x0010
	dc.w	0x0002,0x0054 							;x = 0x0054
	dc.w	0x0008,0x0005 							;draw color = 0x05
	dc.w	0x000A 								;draw title center
	dc.l	L7FA3CA								;"GAME SET UP"" 
	dc.w	0x0008,0x000F 							;draw color = 0x0F
	dc.w	0x0001,0x0030 							;y = 0x0030
	dc.w	0x0002,0x000E 							;x = 0x000E
	dc.w	0x0009 								;add menu item
	dc.l	L7D9762 								;func_25_dipswitch_open
	dc.w	0x0006 								;draw menu left
	dc.l	L7FAA8C 								;"DIPSWITCH SETTINGS"
	dc.w	0x0007 								;next line
	dc.w	0x0007 								;next line
	dc.w	0x0009 								;add menu item
	dc.l	L7D97C6 
	dc.w	0x0006 								;draw menu left
	dc.l	L7FAAA0 								;"ON SCREEN OPTIONS"
	dc.w	0x0007 								;next line
	dc.w	0x0007 								;next line
	dc.w	0x0007 								;next line
	dc.w	0x0007 								;next line
	dc.w	0x0009 								;add menu item
	dc.l	L7D8E90 
	dc.w	0x0006 								;draw menu left
	dc.l	L7FA528 								;"RETURN TO MAIN MENU"
	dc.w	0x0005   								;goto and exit
	dc.l	L7FA098 

L7FA0F4:										;game diagnostics screen
	dc.w	0x0003,0x000F  							;normal color = 0x0F
	dc.w	0x0004,0x0006 							;active color = 0x06
	dc.w	0x0001,0x0010 							;y = 0x0010
	dc.w	0x0002,0x0054 							;x = 0x0054 
	dc.w	0x0008,0x0005  							;draw color = 0x05
	dc.w	0x000A 								;draw title center
	dc.l	L7FA3D6 								;"GAME DIAGNOSTICS""
	dc.w	0x0008,0x000F   							;draw color = 0x0F
	dc.w	0x0001,0x0030 							;y = 0x0030
	dc.w	0x0002,0x000E 							;x = 0x000E
	dc.w	0x0009 								;add menu item
	dc.l	L7D96CC 
	dc.w	0x0006 								;draw menu left
	dc.l	L7FA9DE								;"SOUND CHECK"
	dc.w	0x0007								;next line 
	dc.w	0x0007								;next line 
	dc.w	0x0009 								;add menu item
	dc.l	L7D99A6
	dc.w	0x0006 								;draw menu left
	dc.l	L7FAA1A								;"RAM/ROM CHECK"
	dc.w	0x0007 								;next line
	dc.w	0x0007 								;next line
	dc.w	0x0009 								;add menu item
	dc.l	L7D90FA 
	dc.w	0x0006 								;draw menu left
	dc.l	L7FA53C								;"JOYSTICK & BUTTON CHECK"
	dc.w	0x0007 								;next line
	dc.w	0x0007 								;next line
	dc.w	0x0009 								;add menu item
	dc.l	0xFFEC88D0 
	dc.w	0x0006 								;draw menu left
	dc.l	L7FA5A0								;"VIDEO ALIGNMENT CHECK"
	dc.w	0x0007 								;next line
	dc.w	0x0007 								;next line
	dc.w	0x0007 								;next line
	dc.w	0x0007 								;next line
	dc.w	0x0009 								;add menu item
	dc.l	0xFFEC7480 
	dc.w	0x0006 								;draw menu left
	dc.l	L7FA528								;"RETURN TO MAIN MENU"
	dc.w	0x0005   								;goto and exit
	dc.l	L7FA0F4
 
L7FA170:										;game statistics screen
	dc.w	0x0003,0x000F   							;normal color = 0x0F
	dc.w	0x0004,0x0006  							;active color = 0x06
	dc.w	0x0001,0x0010  							;y = 0x0010
	dc.w	0x0002,0x0054  							;x = 0x0054 
	dc.w	0x0008,0x0005   							;draw color = 0x05
	dc.w	0x000A 								;draw title center
	dc.l	L7FA3E8 								;"GAME STATISTICS"
	dc.w	0x0008,0x000F    							;draw color = 0x0F
	dc.w	0x0001,0x0030 							;y = 0x0030
	dc.w	0x0002,0x000E 							;x = 0x000E
	dc.w	0x0009 								;add menu item
	dc.l	0xFFEC77B0 
	dc.w	0x0006 								;draw menu left
	dc.l	L7FA5B6								;"BOOKKEEPING REPORT"
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009 								;add menu item
	dc.l	0xFFEC76E0 
	dc.w	0x0006 								;draw menu left
	dc.l	L7FA5CA								;"CREDIT USAGE REPORT" 
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009 								;add menu item
	dc.l	0xFFEC7570 
	dc.w	0x0006 								;draw menu left
	dc.l	L7FA5DE								;"DURATIONS REPORT"
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009 								;add menu item
	dc.l	0xFFEC7380 
	dc.w	0x0006 								;draw menu left
	dc.l	L7FA5F0								;"ERASE PERIODICAL STATISTICS"
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009 								;add menu item
	dc.l	0xFFEC7480 
	dc.w	0x0006 								;draw menu left
	dc.l	L7FA528								;"RETURN TO MAIN MENU"
	dc.w	0x0005    								;goto and exit
	dc.l	L7FA170
 
L7FA1EE:										;bookkeeping screen
	dc.w	0x0003,0x000F    							;normal color = 0x0F
	dc.w	0x0004,0x0006   							;active color = 0x06
	dc.w	0x0001,0x0010  							;y = 0x0010
	dc.w	0x0002,0x0054   							;x = 0x0054 
	dc.w	0x0008,0x0005    							;draw color = 0x05
	dc.w	0x000A 								;draw title center
	dc.l	L7FA5B6								;"BOOKKEEPING REPORT"
	dc.w	0x0008,0x000F     						;draw color = 0x0F
	dc.w	0x0001,0x00B0 							;y = 0x00B0 
	dc.w	0x0002,0x000E  							;x = 0x000E
	dc.w	0x0009  								;add menu item
	dc.l	0xFFEC7530 
	dc.w	0x0006  								;draw menu left
	dc.l	L7FA60C								;"RETURN TO STATISTICS MENU"
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009  								;add menu item
	dc.l	0xFFEC7480 
	dc.w	0x0006  								;draw menu left
	dc.l	L7FA528								;"RETURN TO MAIN MENU"
	dc.w	0x0005    								;goto and exit
	dc.l	L7FA1EE
 
L7FA236:										;credit screen
	dc.w	0x0003,0x000F     						;normal color = 0x0F
	dc.w	0x0004,0x0006   							;active color = 0x06
	dc.w	0x0001,0x0010  							;y = 0x0010
	dc.w	0x0002,0x0054   							;x = 0x0054 
	dc.w	0x0008,0x0005     						;draw color = 0x05
	dc.w	0x000A 								;draw title center
	dc.l	L7FA5CA								;"CREDIT USAGE REPORT"
	dc.w	0x0008,0x000F      						;draw color = 0x0F
	dc.w	0x0001,0x00B0 							;y = 0x00B0 
	dc.w	0x0002,0x000E   							;x = 0x000E
	dc.w	0x0009  								;add menu item
	dc.l	0xFFEC7530 
	dc.w	0x0006  								;draw menu left
	dc.l	L7FA60C								;"RETURN TO STATISTICS MENU"
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009  								;add menu item
	dc.l	0xFFEC7480 
	dc.w	0x0006  								;draw menu left
	dc.l	L7FA528								;"RETURN TO MAIN MENU"
	dc.w	0x0005 
	dc.l	L7FA236

L7FA27E:										;durations screen
	dc.w	0x0003,0x000F     						;normal color = 0x0F
	dc.w	0x0004,0x0006    							;active color = 0x06
	dc.w	0x0001,0x0010   							;y = 0x0010
	dc.w	0x0002,0x0054   							;x = 0x0054 
	dc.w	0x0008,0x0005 
	dc.w	0x000A  								;draw title center
	dc.l	L7FA5DE								;"DURATIONS REPORT"
	dc.w	0x0008,0x000F      						;draw color = 0x0F
	dc.w	0x0001,0x00B0   							;y = 0x00B0
	dc.w	0x0002,0x000E   							;x = 0x000E
	dc.w	0x0009  								;add menu item
	dc.l	0xFFEC7530 
	dc.w	0x0006  								;draw menu left
	dc.l	L7FA60C								;"RETURN TO STATISTICS MENU"
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009  								;add menu item
	dc.l	0xFFEC7480 
	dc.w	0x0006  								;draw menu left
	dc.l	L7FA528								;"RETURN TO MAIN MENU"
	dc.w	0x0005     								;goto and exit
	dc.l	L7FA27E
 
L7FA2C6:										;erase statistics screen
	dc.w	0x0003,0x000F     						;normal color = 0x0F
	dc.w	0x0004,0x0006    							;active color = 0x06
	dc.w	0x0001,0x0010 							;y = 0x0010 
	dc.w	0x0002,0x0054   							;x = 0x0054
	dc.w	0x0008,0x0005      						;draw color = 0x05
	dc.w	0x000A 								;draw title center
	dc.l	0xFFFD2F80 								;"ERASE PERIODICAL STATISTICS"
	dc.w	0x0008,0x000C      						;draw color = 0x0C
	dc.w	0x0001,0x0030 							;y = 0x0030 
	dc.w	0x000A 								;draw title center
	dc.l	L7FA86C 								;"WARNING!"
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x000A 								;draw title center
	dc.l	L7FA876								;"Selecting YES will clear"
	dc.w	0x0007  								;next line
	dc.w	0x000A 								;draw title center
	dc.l	L7FA890								;"all bookkeeping, credit usage"
	dc.w	0x0007  								;next line
	dc.w	0x000A 								;draw title center
	dc.l	L7FA8AE								;"and statistics information."
	dc.w	0x0001,0x00B0  							;y = 0x00B0 
	dc.w	0x0002,0x000E   							;x = 0x000E
	dc.w	0x0009  								;add menu item
	dc.l	0xFFEC7480 
	dc.w	0x0006  								;draw menu left
	dc.l	L7FA8CA								;"NO (RETURN TO MAIN MENU)"
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009  								;add menu item
	dc.l	0xFFEC66D0 
	dc.w	0x0006  								;draw menu left
	dc.l	L7FA8E4								;"YES (ERASE STATISTICS)"
	dc.w	0x000E 
	dc.l	0xFFEC6940 
	dc.w	0x0005     								;goto and exit
	dc.l	L7FA2C6
 
L7FA338:										;full reset screen
	dc.w	0x0003,0x000F      						;normal color = 0x0F
	dc.w	0x0004,0x0006    							;active color = 0x06
	dc.w	0x0001,0x0010 							;y = 0x0010 
	dc.w	0x0002,0x0054   							;x = 0x0054
	dc.w	0x0008,0x0005      						;draw color = 0x05
	dc.w	0x000A 								;draw title center
	dc.l	L7FAB00								;"PERFORM FULL SYSTEM RESET"
	dc.w	0x0008,0x000C      						;draw color = 0x0C
	dc.w	0x0001,0x0030 							;y = 0x0030 
	dc.w	0x000A 								;draw title center
	dc.l	L7FA86C								;"WARNING!"
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x000A 								;draw title center
	dc.l	L7FAB1A								;"Selecting YES will perform a"
	dc.w	0x0007  								;next line
	dc.w	0x000A 								;draw title center
	dc.l	L7FAB38  								;"total system reset. All data"
	dc.w	0x0007  								;next line
	dc.w	0x000A 								;draw title center
	dc.l	L7FAB56								;"will be lost and all menu-"
	dc.w	0x0007  								;next line
	dc.w	0x000A 								;draw title center
	dc.l	L7FAB72								;"selected options will be reset"
	dc.w	0x0007  								;next line
	dc.w	0x000A 								;draw title center
	dc.l	L7FAB92								;"to default values."
	dc.w	0x0001,0x00B0 							;y = 0x00B0 
	dc.w	0x0002,0x000E   							;x = 0x000E
	dc.w	0x0009  								;add menu item
	dc.l	0xFFEC7480 
	dc.w	0x0006  								;draw menu left
	dc.l	L7FA8CA  								;"NO (RETURN TO MAIN MENU)"
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009  								;add menu item
	dc.l	0xFFEC6B50 
	dc.w	0x0006  								;draw menu left
	dc.l	L7FABA6  								;"YES (RESET SYSTEM)"
	dc.w	0x0005     								;goto and exit
	dc.l	L7FA338
 

L7FA3B4:
	dc.b	"BATTLETOADS MAIN MENU",0x00
L7FA3CA:
	dc.b	"GAME SET UP",0x00
L7FA3D6:
	dc.b	"GAME DIAGNOSTICS",0x00
	dc.b	" "
7FA3E8:
	dc.b	"GAME STATISTICS",0x00
L7FA3F8:
	dc.b	"RESTART GAME",0x00
 CANCEL CHANGES & RESTART GAME.
L7FA424:
	dc.b	"DIFFICULTY LEVEL  (1-6) :",0x00
ATTRACT MODE SOUND      :.
FREE PLAY               :.
BLOOD-FREE MODE         :.
STEREO SOUND MODE       :.
UNUSED CREDIT RETENTION :.
L7FA4C0:
	dc.b	"COINS PER DOLLAR  (1-10):",0x00
COINS TO START    (1-10):.
COINS TO JOIN IN  (1-10):.
COINS TO CONTINUE (1-10):.
L7FA528:
	dc.b	"RETURN TO MAIN MENU",0x00
L7FA53C:
	dc.b	"JOYSTICK & BUTTON CHECK",0x00
VIEW DIPSWITCH SETTINGS.
AUDIO CHECK.
TEST PROCESSOR MEMORY.
TEST VIDEO MEMORY.
L7FA5A0:
	dc.b	"VIDEO ALIGNMENT CHECK",0x00
L7FA5B6:
	dc.b	"BOOKKEEPING REPORT",0x00
	dc.b	0x69
L7FA5CA:
	dc.b	"CREDIT USAGE REPORT",0x00
L7FA5DE:
	dc.b	"DURATIONS REPORT",0x00
	dc.b	0x65
L7FA5F0:
	dc.b	"ERASE PERIODICAL STATISTICS",0x00
L7FA60C:
	dc.b	"RETURN TO STATISTICS MENU",0x00
             (ZITZ)      (RASH)     (PIMPLE).
 TOTAL        SLOT-1      SLOT-2.
RIGHT.
SLOT-3.
nLIFETIME.
!   COINS:.
PERIOD.
l DOLLARS:.
COINS PER DOLLAR:.
L7FA6BA:
	dc.b	"ON",0x00
	dc.b	"0"
L7FA6BE:
	dc.b	"OFF",0x00
LEFT          MIDDLE          RIGHT.
  ZITZ           RASH          PIMPLE.
START    :.
 ADDED IN :.
`CONTINUE :.
ÀTOTAL    :.
UINTERVALS (MINS)              PLAY CREDIT LIFESPAN.
k 0.00 -> 0.59 :.
 1.00 -> 1.29 :.
 1.30 -> 1.59 :.
 2.00 -> 2.29 :.
 2.30 -> 2.59 :.
 3.00 -> 3.59 :.
 4.00 -> 4.59 :.
 5.00 -> 5.59 :.
 7.00 -> 9.59 :.
10.00 ->  UP  :.
AVG. TIME / GAME   :.
•AVG. TIME / CREDIT :.
-TOTAL TIME IN PLAY :..
OPERATIONAL TIME   :..
n/a.
L7FA86C:
	dc.b	"WARNING!",0x00,0x00
L7FA876:
	dc.b	"Selecting YES will clear",0x00
	dc.b	0x2E
L7FA890:
	dc.b	"all bookkeeping, credit usage",0x00
L7FA8AE:
	dc.b	"and statistics information.",0x00
L7FA8CA:
	dc.b	"NO (RETURN TO MAIN MENU)",0x00
	dc.b	0x4F
L7FA8E4:
	dc.b	"YES (ERASE STATISTICS)",0x00
	dc.b	0x03
LEFT.
aUP..
DOWN.
+ACTION..
JUMP.
‹COIN MECH.
START.
PUSH1.
PUSH2.
TILT..
SERVICE.
TEST..
DIPSWITCH: 0 - ON, 1 - OFF.
‹COUNTER.
ONLY 'TRUE' COIN PULSE TIMES ARE ACCEPTED AS VALID.
	dc.b	0xAE
L7FA9A2:
	dc.b	"RETURN TO DIAGNOSTICS MENU",0x00
	dc.b	0x02
CROSSHATCH PATTERN.
lCOLOR BARS.
	dc.b	0x8F
L7FA9DE:
	dc.b	"SOUND CHECK",0x00
PLAY TUNE (1-9):..
PLAY SFX (1-185):.
REPLAY SFX:.
L7FAA1A:
	dc.b	"RAM/ROM CHECK",0x00
L7FAA28:
	dc.b	"PASS",0x00
	dc.b	0xA0
L7FAA2E:
	dc.b	"FAIL",0x00
	dc.b	0x44
L7FAA34:
	dc.b	"Test result",0x00
Faulty I.C.'s.
System RAM.
UBattery backed RAM.
LVideo display RAM.
Program ROM.
L7FAA8C:
	dc.b	"DIPSWITCH SETTINGS",0x00,0x00
L7FAAA0:
	dc.b	"ON SCREEN OPTIONS",0x00
RETURN TO GAME SETUP MENU.
THREE PLAYER MODE       :.
COMMON COIN-MECH MODE   :.
L7FAB00:
	dc.b	"PERFORM FULL SYSTEM RESET",0x00
L7FAB1A:
	dc.b	"Selecting YES will perform a",0x00,0x00
L7FAB38:
	dc.b	"total system reset. All data",0x00,0x00
L7FAB56:
	dc.b	"will be lost and all menu-",0x00,0x00
L7FAB72:
	dc.b	"selected options will be reset",0x00
	dc.b	0x4D
L7FAB92:
	dc.b	"to default values.",0x00
	dc.b	0x9C
L7FABA6:
	dc.b	"YES (RESET SYSTEM)",0x00,0x00
LIVES ON CONTINUE (2-3) :.
L7FABD4:
	dc.b	"SAVE NEW SETTINGS",0x00
YES (SAVE NEW SETTINGS).
NO (CANCEL CHANGES).
L7FAC12:
	dc.b	"RESET TO FACTORY SETTINGS",0x00
NO (RETURN TO ONSCREEN MENU)..
YES (RESET SETTINGS).
DSAVE AND EXIT.
EXIT WITHOUT SAVING.
PLEASE NOTE!..
Selecting YES will display the..
recommended settings but will.
not save them.
 You must select..
SAVE NEW SETTINGS to make the.
changes permanent!.
FSelecting YES will make the.
Changes have NOT been saved...
L7FAD5A:
	dc.b	"Changes have been saved!",0x00
	dc.b	0x2E
TEST RIG - ACTIVE.




L7FAF4E:										;dipswitch screen
	dc.w	0x0003,0x000F       						;normal color = 0x0F
	dc.w	0x0004,0x0006     						;active color = 0x06
	dc.w	0x000C,0x000B       						;draw color 2 = 0x0B
	dc.w	0x0001,0x0010 							;y = 0x0010 
	dc.w	0x0002,0x0054 							;x = 0x0054 
	dc.w	0x0008,0x0005      						;draw color = 0x05
	dc.w	0x000A 								;draw title center
	dc.l	0xFFFD5460 								;""
	dc.w	0x0008,0x000F      						;draw color = 0x0F
	dc.w	0x0001,0x0030 							;y = 0x0030
	dc.w	0x0002,0x000E 							;x = 0x000E 
	dc.w	0x000E 								;
	dc.l	0xFFECBBF0 
	dc.w	0x0006  								;draw menu left
	dc.l	0xFFFD21F0 								;""
	dc.w	0x000D,0x0000 							;draw switch 0
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x000E 								;
	dc.l	0xFFECBC70 
	dc.w	0x0006  								;draw menu left
	dc.l	0xFFFD2460 								;""
	dc.w	0x000D,0x0001 							;draw switch 1
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x000E 								;
	dc.l	0xFFECBBB0 
	dc.w	0x0006  								;draw menu left
	dc.l	0xFFFD5730 								;""
	dc.w	0x000D,0x0002 							;draw switch 2
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x000E 								;
	dc.l	0xFFECBB70 
	dc.w	0x0006  								;draw menu left
	dc.l	0xFFFD5660 								;""
	dc.w	0x000D,0x0003 							;draw switch 3
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x000E 								;
	dc.l	0xFFECBC30 
	dc.w	0x0006  								;draw menu left
	dc.l	0xFFFD22C0 								;""
	dc.w	0x000D,0x0004 							;draw switch 4
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x000E 								;
	dc.l	0xFFECBCB0 
	dc.w	0x0006  								;draw menu left
	dc.l	0xFFFD2390 								;""
	dc.w	0x000D,0x0005 							;draw switch 5
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x000E 								;
	dc.l	L7D979E
	dc.w	0x0006  								;draw menu left
	dc.l	0xFFFD2530 								;""
	dc.w	0x000D,0x0006 							;draw switch 6
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009  								;add menu item
	dc.l	0xFFEC7250 
	dc.w	0x0006 
	dc.l	0xFFFD5590 								;""
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009  								;add menu item
	dc.l	0xFFEC7480 
	dc.w	0x0006  								;draw menu left
	dc.l	0xFFFD2940 								;""
	dc.w	0x0005     								;goto and exit
	dc.l	L7FAF4E
 
L7FB02A:										;screen
	dc.w	0x0003,0x000F       						;normal color = 0x0F
	dc.w	0x0004,0x0006     						;active color = 0x06
	dc.w	0x0001,0x0010 							;y = 0x0010 
	dc.w	0x0002,0x0054 							;x = 0x0054 
	dc.w	0x0008,0x0005      						;draw color = 0x05
	dc.w	0x000A 								;draw title center
	dc.l	L7FAAA0 								;"ON SCREEN OPTIONS"
	dc.w	0x0008,0x000F      						;draw color = 0x0F
	dc.w	0x0001,0x0030 							;y = 0x0030 
	dc.w	0x0002,0x000E 							;x = 0x000E 
	dc.w	0x0009  								;add menu item
	dc.l	0xFFECC020 
	dc.w	0x0006  								;draw menu left
	dc.l	L7FA424								;"DIFFICULTY LEVEL  (1-6) :"
	dc.w	0x000B 
	dc.l	0x0019F170 
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009  								;add menu item
	dc.l	0xFFECC090 
	dc.w	0x0006  								;draw menu left
	dc.l	L7FA4C0								;"COINS PER DOLLAR  (1-10):"
	dc.w	0x000B 
	dc.l	0x0019F180 
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009  								;add menu item
	dc.l	0xFFECC0E0 
	dc.w	0x0006  								;draw menu left
	dc.l	0xFFFD26D0 								;""
	dc.w	0x000B 
	dc.l	0x0019F190 
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009  								;add menu item
	dc.l	0xFFECC130 
	dc.w	0x0006  								;draw menu left
	dc.l	0xFFFD2870 								;""
	dc.w	0x000B 
	dc.l	0x0019F1A0 
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009  								;add menu item
	dc.l	0xFFECC180 
	dc.w	0x0006  								;draw menu left
	dc.l	0xFFFD5DD0 								;""
	dc.w	0x000B 
	dc.l	0x0019F1B0 
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009  								;add menu item
	dc.l	0xFFECC8F0 
	dc.w	0x0006  								;draw menu left
	dc.l	0xFFFD6090 								;""
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009  								;add menu item
	dc.l	0xFFECC560 
	dc.w	0x0006  								;draw menu left
	dc.l	0xFFFD5EA0 								;""
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009  								;add menu item
	dc.l	0xFFECC1F0 
	dc.w	0x0006  								;draw menu left
	dc.l	0xFFFD5590 								;""
	dc.w	0x0005     								;goto and exit
	dc.l	L7FB02A
 

	dc.w	0x0003,0x000F       						;normal color = 0x0F
	dc.w	0x0004,0x0006     						;active color = 0x06
	dc.w	0x0001,0x0010 							;y = 0x0010
	dc.w	0x0002,0x0054 							;x = 0x0054 
	dc.w	0x0008,0x0005 
	dc.w	0x000A 								;draw title center
	dc.l	L7FABD4 								;"SAVE NEW SETTINGS"
	dc.w	0x0008,0x000C 
	dc.w	0x0001,0x0060 
	dc.w	0x000A 								;draw title center
	dc.l	L7FA86C 								;"WARNING!"
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x000A 								;draw title center
	dc.l	0xFFFD69E0 								;""
	dc.w	0x0008,0x000F 
	dc.w	0x0001,0x00B0 							;y = 0x00B0
	dc.w	0x0002,0x000E 							;x = 0x000E
	dc.w	0x0009  								;add menu item
	dc.l	0xFFECC520 								;""
	dc.w	0x0006  								;draw menu left
	dc.l	0xFFFD6300 
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009  								;add menu item
	dc.l	0xFFECC540 								;""
	dc.w	0x0006  								;draw menu left
	dc.l	0xFFFD6370 
	dc.w	0x0005     								;goto and exit
	dc.l	0xFFFD87C0 
 

	dc.w	0x0003,0x000F       						;normal color = 0x0F
	dc.w	0x0004,0x0006     						;active color = 0x06
	dc.w	0x0001,0x0010 							;y = 0x0010
	dc.w	0x0002,0x0054 							;x = 0x0054 
	dc.w	0x0008,0x0005 
	dc.w	0x000A 								;draw title center
	dc.l	L7FABD4 								;"SAVE NEW SETTINGS"
	dc.w	0x0008,0x000C 
	dc.w	0x0001,0x0058 							;y = 0x0058
	dc.w	0x000A 								;draw title center
	dc.l	L7FA86C 								;"WARNING!"
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x000A 								;draw title center
	dc.l	0xFFFD6900 								;""
	dc.w	0x0007  								;next line
	dc.w	0x000A 								;draw title center
	dc.l	0xFFFD6860 								;""
	dc.w	0x0008,0x000F 
	dc.w	0x0001,0x00B0 							;y = 0x00B0
	dc.w	0x0002,0x000E 							;x = 0x000E
	dc.w	0x0009  								;add menu item
	dc.l	0xFFECC600 								;""
	dc.w	0x0006  								;draw menu left
	dc.l	0xFFFD5FF0 
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009  								;add menu item
	dc.l	0xFFECC5C0 								;""
	dc.w	0x0006  								;draw menu left
	dc.l	0xFFFD5F30 
	dc.w	0x0005     								;goto and exit
	dc.l	0xFFFD8AC0 
 

	dc.w	0x0002,0x0054 
	dc.w	0x0008,0x000C 
	dc.w	0x0001,0x0068 							;y = 0x0068
	dc.w	0x000A 								;draw title center
	dc.l	L7FAD5A 								;"Changes have been saved!"
	dc.w	0x0005     								;goto and exit
	dc.l	0xFFFD8E00 
 

	dc.w	0x0003,0x000F       						;normal color = 0x0F
	dc.w	0x0004,0x0006     						;active color = 0x06
	dc.w	0x0001,0x0010 							;y = 0x0010
	dc.w	0x0002,0x0054 							;x = 0x0054 
	dc.w	0x0008,0x0005 
	dc.w	0x000A 								;draw title center
	dc.l	L7FAC12 								;"RESET TO FACTORY SETTINGS"
	dc.w	0x0008,0x000C 
	dc.w	0x0001,0x0030 							;y = 0x0030
	dc.w	0x000A 								;draw title center
	dc.l	0xFFFD6410 								;""
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x000A 								;draw title center
	dc.l	0xFFFD6480 								;""
	dc.w	0x0007  								;next line
	dc.w	0x000A 								;draw title center
	dc.l	0xFFFD6580 								;""
	dc.w	0x0007  								;next line
	dc.w	0x000A 								;draw title center
	dc.l	0xFFFD6670 								;""
	dc.w	0x0007  								;next line
	dc.w	0x000A 								;draw title center
	dc.l	0xFFFD6770 								;""
	dc.w	0x0007  								;next line
	dc.w	0x000A 								;draw title center
	dc.l	0xFFFD6860 								;""
	dc.w	0x0001,0x00B0 							;y = 0x00B0
	dc.w	0x0002,0x000E 							;x = 0x000E
	dc.w	0x0008,0x000F 
	dc.w	0x0009  								;add menu item
	dc.l	0xFFECCD10 								;""
	dc.w	0x0006  								;draw menu left
	dc.l	0xFFFD6160 
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009  								;add menu item
	dc.l	0xFFECC950 								;""
	dc.w	0x0006  								;draw menu left
	dc.l	0xFFFD6250 
	dc.w	0x0005     								;goto and exit
	dc.l	0xFFFD8EC0 
 

L7FB258:										;ram/rom check screen
	dc.w	0x0003,0x000F       						;normal color = 0x0F
	dc.w	0x0004,0x0006     						;active color = 0x06
	dc.w	0x0001,0x0010 							;y = 0x0010
	dc.w	0x0002,0x0054 							;x = 0x0054 
	dc.w	0x0008,0x0005 
	dc.w	0x000A 								;draw title center
	dc.l	L7FAA1A								;"RAM/ROM CHECK"
	dc.w	0x0007  								;next line
	dc.w	0x0001,0x00B0 							;y = 0x00B0
	dc.w	0x0009  								;add menu item
	dc.l	L7D8E9E 								;
	dc.w	0x0006  								;draw menu left
	dc.l	L7FA9A2								;"RETURN TO DIAGNOSTICS MENU"
	dc.w	0x0007  								;next line
	dc.w	0x0007  								;next line
	dc.w	0x0009  								;add menu item
	dc.l	0xFFEC7480 
	dc.w	0x0006  								;draw menu left
	dc.l	L7FA528								;"RETURN TO MAIN MENU"
	dc.w	0x0005     								;goto and exit
	dc.l	L7FB258

L7FB29A:										;testres_str
	dc.w	0x00D4,0x002C 
	dc.l	L7FAA34    								; "Test result"
 
0154 
002C 
FFFD5200 
 
0024 
003C 
FFFD5400 
 
0024 
004C 
FFFD5270 
 
0024 
005C 
FFFD52D0 
 
0024 
006C 
FFFD5370 

00000000 
 
7FB2CE:
	dc.b	"U38 " 
	dc.l	0x00000000 
	dc.w	0x0200 
	dc.w	0x0000 
	dc.w	0x0810 

	dc.b	"U39 " 
	dc.l	0x00000010 
	dc.w	0x0200 
	dc.w	0x0000 
	dc.w	0x0810 

	dc.b	0xFF 

	dc.b	"U145" 
	dc.l	0x60000000
2000 
0000
0808 
	dc.b	0xFF 

	dc.b	"U46 " 
	dc.l	0xB0000000
	dc.w	0x0100 
	dc.w	0x3000 
	dc.w	0x0404 

	dc.b	"U47 " 
	dc.l	0xB0000004 
0100 
3000 
0404 
3655 
2030 
0008 
B000 
0100 
3000 
0404 
3555 
2039 
000C 
B000 
0100 
3000 
0404 
3355 
2037 
0000 
B400 
0100 
3000 
0404 
3455 
2038 
0004 
B400 
0100 
3000 
0404 
3455 
2039 
0008 
B400 
0100 
3000 
0404 
3555 
2030 
000C 
B400 
0100 
3000 
0404 
3655 
2031 
0000 
A000 
0100 
3000 
0404 
3655 
2032 
0004 
A000 
0100 
3000 
0404 
3655 
2033 
0000 
A400 
0100 
3000 
0404 
3655 
2034 
0004 
A400 
0100 
3000 
0404 
3355 
2034 
0000 
A800 
0200 
0000 
0404 
3155 
2033 
0004 
A800 
0200 
0000 
0404 
3155 
2034 
0008 
A800 
0200 
0000 
0404 
3155 
2035 
000C 
A800 
0200 
0000 
0404 
CCFE 



