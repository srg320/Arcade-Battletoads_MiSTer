package TMS34020_PKG; 

	typedef enum bit[3:0] {
		ALUOP_MOV   = 4'b0000, 
		ALUOP_ADD   = 4'b0001, 
		ALUOP_ADDXY = 4'b0010,
		ALUOP_CPW   = 4'b0011,
		ALUOP_LOG   = 4'b0100,
		ALUOP_SHIFT = 4'b0101,
		ALUOP_LOC   = 4'b0110,
		ALUOP_MUL   = 4'b0111,
		ALUOP_DIV   = 4'b1000
	} ALUOp_t; 
	
	typedef struct packed
	{
		ALUOp_t     OP;		//ALU operation type
		bit [ 3: 0] CD;		//ALU operation code
		bit         BCOMP;	//ALU B inverted
	} ALU_t; 
	
	//ALU operation code
	//ADD: [0] 0:add,1:sub; [2:1] 00:0->ci,01:1->ci,1X:C->ci;
	//LOG: [1:0] 0:and,1:or,2:xor,3:and bitmask; [2] 0:b,1:not b;
	//Shifter operation code
	//[0] 0:left,1:right; [2:1] 00:logical,01:arithmetic,1X:rotate;
	
	typedef enum bit[1:0] {
		IMM_K    = 2'b00,
		IMM_IW   = 2'b01,
		IMM_IL   = 2'b10,
		IMM_FS   = 2'b11
	} IMMType_t; 
	
	typedef enum bit[2:0] {
		CV_0  = 3'b000,
		CV_1  = 3'b001,
		CV_2  = 3'b010,
		CV_4  = 3'b011,
		CV_8  = 3'b100,
		CV_16 = 3'b101,
		CV_32 = 3'b110
	} Const_t; 
	
	typedef enum bit[3:0] {
		AS_REGA = 4'b0000,
		AS_REGB = 4'b0001,
		AS_IMM  = 4'b0010,
		AS_CONST= 4'b0011,
		AS_STF  = 4'b0100,
		AS_PS   = 4'b0101,
		AS_PPW  = 4'b0110,
		AS_PIX  = 4'b0111,
		AS_MDAL = 4'b1000,
		AS_MDAH = 4'b1001,
		AS_MDQ  = 4'b1010
	} ALUSource_t;
	
	typedef enum bit[1:0] {
		EO_NONE  = 2'b00,
		EO_ZERO  = 2'b01,
		EO_SIGN  = 2'b10
	} ExtOp_t;
	
	typedef struct packed
	{
		IMMType_t   IT;	//Imm type
		Const_t     CV;	//Const value
		ALUSource_t AS;	//ALU source
		ExtOp_t     EO;	//Extend operation
	} ALUInput_t;
	
	typedef enum bit[2:0] {
		SS_NONE = 3'b000,
		SS_REG  = 3'b001,
		SS_IMM  = 3'b010,
		SS_CONST= 3'b011,
		SS_FS   = 3'b100
	} ShiftSrc_t;
	
	typedef struct packed
	{
		ShiftSrc_t  AMS;	//Shift amount	source
		bit [ 2: 0] SHOP;	//Shift operation	
	} Shift_t;
	
	typedef enum bit[3:0] {
		MDO_NOP     = 4'b0000,
		MDO_MULINIT = 4'b0001,
		MDO_MULCHK  = 4'b0010,
		MDO_MULSTEP = 4'b0011,
		MDO_DIVINIT = 4'b0100,
		MDO_DIVDVNT = 4'b0101,
		MDO_DIVDVSR = 4'b0110,
		MDO_DIVSTEP = 4'b0111,
		MDO_DIVQUOT = 4'b1000
	} MulDivOp_t;
	
	typedef enum bit[2:0] {
		MDA_NOP  = 3'b000,
		MDA_ZERO = 3'b001,
		MDA_MULT = 3'b010,
		MDA_DIV  = 3'b011,
		MDA_LDL  = 3'b100,
		MDA_LDH  = 3'b101,
		MDA_NEG  = 3'b110
	} MulDivACC_t;
	
	typedef enum bit[2:0] {
		MDSH_NOP  = 3'b000,
		MDSH_MULT = 3'b001,
		MDSH_DIV  = 3'b010,
		MDSH_LDM  = 3'b011,
		MDSH_LDD  = 3'b100
	} MulDivSh_t;
	
	typedef struct packed
	{
		MulDivOp_t  OP;	//MUL/DIV operation
		MulDivACC_t ACCS;	//MUL/DIV ACC source	
		MulDivSh_t  SHS;	//MUL/DIV shift source	
	} MulDiv_t;
	
	typedef enum bit[2:0] {
		FSI_F  = 3'b000,
		FSI_PS = 3'b001,
		FSI_PW = 3'b010,
		FSI_8  = 3'b011,
		FSI_16 = 3'b100,
		FSI_32 = 3'b101
	} FSImm_t;
	
	typedef struct packed
	{
		FSImm_t     FSI;	//Field size value
		bit         FE;	//Field extend
	} FieldType_t;
	
	typedef enum bit[2:0] {
		MAS_RA   = 3'b000,
		MAS_RB   = 3'b001,
		MAS_RAIW = 3'b010,
		MAS_RBIW = 3'b011,
		MAS_IL   = 3'b100,
		MAS_IO   = 3'b101,
		MAS_VEC  = 3'b110
	} MASource_t;
	
	typedef enum bit[2:0] {
		MDS_REGA = 3'b000,
		MDS_REGB = 3'b001,
		MDS_PC   = 3'b010,
		MDS_ST   = 3'b011,
		MDS_MEM  = 3'b100,
		MDS_PIX  = 3'b101
	} MDSource_t;
	
	typedef enum bit[1:0] {
		MS_LONG  = 2'b00,
		MS_FIELD = 2'b01,
		MS_BYTE  = 2'b10
	} MemSize_t;
	
	typedef enum bit[1:0] {
		MA_NONE  = 2'b00,
		MA_READ  = 2'b01,
		MA_WRITE = 2'b10
	} MemAccess_t;
	
	typedef enum bit[0:0] {
		MT_DATA  = 1'b0,
		MT_PIX   = 1'b1
	} MemType_t;
	
	typedef struct packed
	{
		MASource_t  AS;	//Memory address source
		MDSource_t  DS;	//Memory data source
		MemAccess_t AT;	//Data memory access type
		MemType_t   MT;	//Memory data type
	} Mem_t; 
	
	typedef enum bit[2:0] {
		RS_REGA = 3'b000,
		RS_REGB = 3'b001,
		RS_ALU  = 3'b010,
		RS_MEM  = 3'b011,
//		RS_PIX  = 3'b100,
		RS_PC   = 3'b101,
		RS_ST   = 3'b110,
		RS_REV  = 3'b111
	} RegSrc_t;
	
	typedef struct packed
	{
		RegSrc_t    WS;	//Register write source
		bit         WE;	//Register write enable
	} RegDest_t;
	
	typedef enum bit[2:0] {
		JC_NONE = 3'b000,
		JC_JUMP = 3'b001,
		JC_COND = 3'b010,
		JC_DS   = 3'b011,
		JC_DSZ  = 3'b100,
		JC_DSNZ = 3'b101
	} JumpCond_t;
	
	typedef enum bit[1:0] {
		CNVS_NO = 2'b00,
		CNVS_DP = 2'b01,
		CNVS_SP = 2'b10,
		CNVS_MP = 2'b11
	} ConvSrc_t;
	
	typedef enum bit[3:0] {
		PIXOP_NOP  = 4'b0000,
		PIXOP_PPW  = 4'b0001,
		PIXOP_XYL  = 4'b0010,
		PIXOP_XYS  = 4'b0011,
		PIXOP_MOVX = 4'b0100,
		PIXOP_MOVY = 4'b0101,
		PIXOP_OFFS = 4'b0110,
		PIXOP_LNS  = 4'b0111,
		PIXOP_WSTA = 4'b1000
	} PixALUOp_t;
	
	typedef enum bit[1:0] {
		PIXAS_REGA  = 2'b00,
		PIXAS_REGB  = 2'b01
	} PixALUSrc_t;
	
	typedef struct packed
	{
		PixALUOp_t  AOP;	//ALU operation
		PixALUSrc_t AS;	//ALU source
		ConvSrc_t   CNVS;	//
	} PixALU_t;
	
	
	typedef enum bit[1:0] {
		POFFS_NONE  = 2'b00,
		POFFS_INIT  = 2'b01,
		POFFS_NEXT  = 2'b10
	} PixOffs_t;
	
	typedef enum bit[2:0] {
		PBLT_NONE  = 3'b000,
		PBLT_STRT  = 3'b001,
		PBLT_NEXT  = 3'b010,
		PBLT_BMLD  = 3'b011,
		PBLT_STEP  = 3'b100,
		PBLT_DRAW  = 3'b101
	} PixBlt_t;
	
	typedef enum bit[1:0] {
		WIN_NONE  = 2'b00,
		WIN_INIT  = 2'b01,
		WIN_CHECK = 2'b10,
		WIN_DADJ  = 2'b11
	} PixWin_t;
	
	typedef enum bit[1:0] {
		PLN_NONE  = 2'b00,
		PLN_INIT  = 2'b01,
		PLN_COND  = 2'b10,
		PLN_STEP  = 2'b11
	} PixLine_t;
	
	typedef struct packed
	{
		PixBlt_t    BLT;	//pixblt action 
		PixOffs_t   OFFS; //address offset action
		PixWin_t    WIN;	//Window action 
		PixLine_t   LINE;	//Line action 
	} PixFunc_t;
	
	typedef enum bit[2:0] {
		PATS_NULL = 3'b000,
		PATS_MEM  = 3'b001,
		PATS_REG  = 3'b010,
		PATS_B    = 3'b011,
		PATS_LN   = 3'b100,
		PATS_COL0 = 3'b101,
		PATS_COL1 = 3'b110
	} PixPatt_t;
	
	typedef struct packed
	{
		PixPatt_t   PATS; //Pixel patter source
	} PixOut_t;
	
	typedef enum bit[3:0] {
		STU_NONE = 4'b0000,
		STU_ST   = 4'b0001,
		STU_FS   = 4'b0010,
		STU_EXFS = 4'b0011,
		STU_MEM  = 4'b0100,
		STU_RES  = 4'b0101,
		STU_ALU  = 4'b0110,
		STU_C    = 4'b0111,
		STU_IE   = 4'b1000
	} STUpdate_t;
	
	typedef struct packed
	{
		STUpdate_t  STU;	//STATUS register update
		bit [ 3: 0] AFU;	//ALU flag update
	} StatWrite_t;
	
	typedef enum bit[2:0] {
		PCS_NONE = 3'b000,
		PCS_REG  = 3'b001,
		PCS_MEM  = 3'b010,
		PCS_K    = 3'b011,
		PCS_IB   = 3'b100,
		PCS_IW   = 3'b101,
		PCS_IL   = 3'b110
	} PCSource_t;
	
	typedef struct packed
	{
		bit [ 3: 0] RD;	//Destination register number
		bit [ 3: 0] RS;	//Source register number
		bit         R;		//Register file (0-A,1-B)
		bit         M;		//Register file move
		bit         F;		//Field select	
		ALUInput_t  AIA;	//ALU input A
		ALUInput_t  AIB;	//ALU input B
		ALU_t       ALU;
		Shift_t     SHC;	//Shifter control	
		MulDiv_t    MDC;	//MUL/DIV control	
		bit [ 1: 0] IWL;	//Instruction word load (0-2 words)		
		FieldType_t FT;	//Field type
		Mem_t       MC;	//Memory control ()
		bit         MMS;	//MMxM start
		bit         MMA;	//MMxM access
		RegDest_t   RWA;	//Register write A
		RegDest_t   RWB;	//Register write B
		JumpCond_t  JC;	//Jump condition
		PixALU_t    PALU; //Pixel function ALU
		PixFunc_t   PF;
		PixOut_t    PIXO; //Pixel out
		StatWrite_t STW;	//STATUS write 
		PCSource_t  PCS;	//PC source 
		bit         PCW;	//PC write
		bit [ 4: 0] NST;	//Next state
		bit         LST;	//Last state		
		bit         ILI;	//Illegal instruction 
	} DecInstr_t; 
	
	// Operand-select fields that depend only on (IC,STATE), never on flags.
	typedef struct packed
	{
		ALUInput_t  AIA;
		ALUInput_t  AIB;
		Shift_t     SHC;
		bit         F;
		MASource_t  MAS;
		MDSource_t  MDS;
	} OpSel_t;
	localparam OpSel_t OPSEL_RST_CONST = 35'h000008000; // decode(16'h0900,0)
	localparam OpSel_t OPSEL_INT_CONST = 35'h000008000; // decode(16'h090A,0)
	
	parameter bit [ 1: 0] IW_NONE = 2'b00;
	parameter bit [ 1: 0] IW_WORD = 2'b01;
	parameter bit [ 1: 0] IW_LONG = 2'b11; 
	
	parameter bit [ 3: 0] AFU_NCZV = 4'b1111;
	parameter bit [ 3: 0] AFU_NCZ  = 4'b1110;
	parameter bit [ 3: 0] AFU_NZV  = 4'b1011;
	parameter bit [ 3: 0] AFU_NZ   = 4'b1010;
	parameter bit [ 3: 0] AFU_ZV   = 4'b0011;
	parameter bit [ 3: 0] AFU_CZ   = 4'b0110;
	parameter bit [ 3: 0] AFU_N    = 4'b1000;
	parameter bit [ 3: 0] AFU_C    = 4'b0100;
	parameter bit [ 3: 0] AFU_Z    = 4'b0010;
	parameter bit [ 3: 0] AFU_V    = 4'b0001;
		
	typedef struct packed
	{
		bit [15: 0] Y;
		bit [15: 0] X;	
	} XY_t;
	
	function bit [31:0] Swap(input bit [31:0] data, input bit [5:0] fs, input bit [1:0] op);
		bit [31: 0] res;
		
		case (op)
			2'b00: res = data;
			2'b01: res = {data[15:0],data[31:16]};
			2'b10: res = {data[31:16],data[7:0],data[15:8]};
			2'b11: res = data;
		endcase
	
		return res;
	endfunction 
	
	function bit [31:0] Ext(input bit [31:0] data, input bit [5:0] fs, input bit [1:0] op);
		bit [31: 0] mask;
		bit         sign;
		bit [31: 0] res;
		
		// Decode the field boundary in parallel rather than barrel-shifting
		// a constant through the operand path.
		for (int i = 0; i < 32; i++) mask[i] = fs <= i;
		// Select the sign bit in parallel, without a subtractor before a
		// 32-way data mux. The five-bit index wraps zero to sign bit 31.
		sign = 0;
		for (int i=0; i<32; i++)
			sign |= data[i] && fs[4:0] == 5'(i+1);
		casex ({sign,op})
			3'bx00: res = data;
			3'bx01: res = data & ~mask;
			3'b010: res = data & ~mask;
			3'b110: res = data |  mask;
			default: res = data;
		endcase
	
		return res;
	endfunction 
	
	function bit [31:0] Shift(input bit [31:0] val, input bit [4:0] sa, input bit [2:0] code);
		bit [31: 0] tmp0, tmp1, tmp2, tmp3, tmp4;
		bit [ 4: 0] s;
		bit         rot,arith,dir;
		
		s = (sa ^ {5{code[0]}}) + {4'b0000,code[0]};
		{rot,arith,dir} = code[2:0];
		
		tmp0 = !s[0] ?  val : (dir ? { { 1{ val[31]}}&{ 1{arith}}, val[31: 1]} : { val[30:0], val[31:31]&{ 1{rot}} });
		tmp1 = !s[1] ? tmp0 : (dir ? { { 2{tmp0[31]}}&{ 2{arith}},tmp0[31: 2]} : {tmp0[29:0],tmp0[31:30]&{ 2{rot}} });
		tmp2 = !s[2] ? tmp1 : (dir ? { { 4{tmp1[31]}}&{ 4{arith}},tmp1[31: 4]} : {tmp1[27:0],tmp1[31:28]&{ 4{rot}} });
		tmp3 = !s[3] ? tmp2 : (dir ? { { 8{tmp2[31]}}&{ 8{arith}},tmp2[31: 8]} : {tmp2[23:0],tmp2[31:24]&{ 8{rot}} });
		tmp4 = !s[4] ? tmp3 : (dir ? { {16{tmp3[31]}}&{16{arith}},tmp3[31:16]} : {tmp3[15:0],tmp3[31:16]&{16{rot}} });
		return tmp4;
	endfunction
	
	function bit [16:0] CarryAdder16(input bit [15:0] a, input bit [15:0] b, input bit ci);
		bit [17: 0] sum;
		
		// The low bit supplies the carry input inside one addition:
		// floor(((2*a+ci)+(2*b+1))/2) == a+b+ci.
		sum = {1'b0,a,ci} + {1'b0,b,1'b1};
		
		return sum[17:1];
	endfunction 
	
	function bit [32:0] CarryAdder(input bit [31:0] a, input bit [31:0] b, input bit ci, input bit [1:0] code, input bit bcomp, input bit xy);
		bit         ci2;
		bit [31: 0] b2;
		bit [31: 0] res;
		bit         co0,co;
		// Preserve the independent carry candidates through synthesis. Merging
		// them into a dependent high-half addition defeats the carry select.
		(* keep = "true" *) bit [16: 0] high0, high1;
		
		b2 = b ^ {32{bcomp}};
		ci2 = code[1] ? ci ^ code[0] : code[0];

		{co0,res[15: 0]} = CarryAdder16(a[15: 0], b2[15: 0], ci2);
		// Compute both high-half carries alongside the low-half addition.
		high0 = CarryAdder16(a[31:16], b2[31:16], 1'b0);
		high1 = CarryAdder16(a[31:16], b2[31:16], 1'b1);
		{co ,res[31:16]} = (xy ? ci2 : co0) ? high1 : high0;
		
		
		return {co ^ code[0],res};
	endfunction
		
	function bit [31:0] Logger(input bit [31:0] a, input bit [31:0] b, input bit [3:0] code);
		bit [31: 0] b2;
		bit [31: 0] bmask;
		bit [31: 0] res;
		
		b2 = b ^ {32{code[0]}};
		bmask = 32'h00000001<<b2[4:0];
		casex (code[2:1])
			2'b00: res = a & b2;
			2'b01: res = a | b2;
			2'b10: res = a ^ b2;
			2'b11: res = a & bmask;
		endcase
	
		return res;
	endfunction 
	
	function bit [32:0] CarryShifter(input bit [31:0] val, input bit [4:0] sa, input bit [3:0] code);
		bit [31: 0] tmp0, tmp1, tmp2, tmp3, tmp4;
		bit         cl0, cl1, cl2, cl3, cl4;
		bit         cr0, cr1, cr2, cr3, cr4;
		bit [ 4: 0] s;
		bit         rot,arith,dir;
		
		s = (sa ^ {5{code[0]}}) + {4'b0000,code[0]};
		{rot,arith,dir} = code[2:0];
		
		{cl0,tmp0,cr0} = !s[0] ? {1'b0, val,1'b0} : (dir ? { 1'b0,{ 1{ val[31]}}&{ 1{arith}}, val[31: 1], val[ 0]} : { val[31], val[30:0], val[31:31]&{ 1{rot}},1'b0 });
		{cl1,tmp1,cr1} = !s[1] ? { cl0,tmp0, cr0} : (dir ? { 1'b0,{ 2{tmp0[31]}}&{ 2{arith}},tmp0[31: 2],tmp0[ 1]} : {tmp0[30],tmp0[29:0],tmp0[31:30]&{ 2{rot}},1'b0 });
		{cl2,tmp2,cr2} = !s[2] ? { cl1,tmp1, cr1} : (dir ? { 1'b0,{ 4{tmp1[31]}}&{ 4{arith}},tmp1[31: 4],tmp1[ 3]} : {tmp1[28],tmp1[27:0],tmp1[31:28]&{ 4{rot}},1'b0 });
		{cl3,tmp3,cr3} = !s[3] ? { cl2,tmp2, cr2} : (dir ? { 1'b0,{ 8{tmp2[31]}}&{ 8{arith}},tmp2[31: 8],tmp2[ 7]} : {tmp2[24],tmp2[23:0],tmp2[31:24]&{ 8{rot}},1'b0 });
		{cl4,tmp4,cr4} = !s[4] ? { cl3,tmp3, cr3} : (dir ? { 1'b0,{16{tmp3[31]}}&{16{arith}},tmp3[31:16],tmp3[15]} : {tmp3[16],tmp3[15:0],tmp3[31:16]&{16{rot}},1'b0 });
		return {dir?cr4:cl4,tmp4};
	endfunction
	
	function bit ShiftLeftOvf(input bit [31:0] val, input bit [4:0] sa);
		bit [31: 0] tmp0, tmp1, tmp2, tmp3, tmp4;
		bit         one0, one1, one2, one3, one4;
		bit         zero0, zero1, zero2, zero3, zero4;
				
		{zero0,one0,tmp0} = !sa[0] ? {1'b0,1'b0, val} : { ~& val[31:31], | val[31:31],  val[30:0], { 1{1'b0}} };
		{zero1,one1,tmp1} = !sa[1] ? {1'b0,1'b0,tmp0} : { ~&tmp0[31:30], |tmp0[31:30], tmp0[29:0], { 2{1'b0}} };
		{zero2,one2,tmp2} = !sa[2] ? {1'b0,1'b0,tmp1} : { ~&tmp1[31:28], |tmp1[31:28], tmp1[27:0], { 4{1'b0}} };
		{zero3,one3,tmp3} = !sa[3] ? {1'b0,1'b0,tmp2} : { ~&tmp2[31:24], |tmp2[31:24], tmp2[23:0], { 8{1'b0}} };
		{zero4,one4,tmp4} = !sa[4] ? {1'b0,1'b0,tmp3} : { ~&tmp3[31:16], |tmp3[31:16], tmp3[15:0], {16{1'b0}} };
		
		return val[31] ? zero1|zero2|zero3|zero4 : one1|one2|one3|one4;
	endfunction
	
	function bit [4:0] OneLocate(input bit [31:0] val, input bit dir);
		bit [ 4: 0] res;
		bit [15: 0] tmp0;
		bit [ 7: 0] tmp1;
		bit [ 3: 0] tmp2;
		bit [ 1: 0] tmp3;
		bit [ 0: 0] tmp4;
		
		tmp0 = !dir ? ( val[31:16] ?  val[31:16] :  val[15: 0]) : ( val[15: 0] ?  val[15: 0] :  val[31:16]);
		tmp1 = !dir ? (tmp0[15: 8] ? tmp0[15: 8] : tmp0[ 7: 0]) : (tmp0[ 7: 0] ? tmp0[ 7: 0] : tmp0[15: 8]);
		tmp2 = !dir ? (tmp1[ 7: 4] ? tmp1[ 7: 4] : tmp1[ 3: 0]) : (tmp1[ 3: 0] ? tmp1[ 3: 0] : tmp1[ 7: 4]);
		tmp3 = !dir ? (tmp2[ 3: 2] ? tmp2[ 3: 2] : tmp2[ 1: 0]) : (tmp2[ 1: 0] ? tmp2[ 1: 0] : tmp2[ 3: 2]);
		tmp4 = !dir ? (tmp3[ 1: 1] ? tmp3[ 1: 1] : tmp3[ 0: 0]) : (tmp3[ 0: 0] ? tmp3[ 0: 0] : tmp3[ 1: 1]);
		
		res[4] = !dir ? | val[31:16] : | val[15: 0];
		res[3] = !dir ? |tmp0[15: 8] : |tmp0[ 7: 0];
		res[2] = !dir ? |tmp1[ 7: 4] : |tmp1[ 3: 0];
		res[1] = !dir ? |tmp2[ 3: 2] : |tmp2[ 1: 0];
		res[0] = !dir ? |tmp3[ 1: 1] : |tmp3[ 0: 0];
		
		return res ^ {5{~dir}};
	endfunction
	
	
	function bit [64:0] MDCarryAdder(input bit [63:0] a, input bit [63:0] b, input bit [1:0] code, input bit bcomp);
		bit [63: 0] b2;
		bit [63: 0] res;
		bit         co;
		
		b2 = b ^ {64{bcomp}};
		{co,res} = {1'b0,a} + {1'b0,b2} + {{64{1'b0}},code[0]};		
		
		return {co ^ code[0],res};
	endfunction
	
	function bit [63:0] MultStep(input bit [31:0] a, input bit [31:0] b, input bit [4:0] s);
		bit [63: 0] m0;
		bit [63: 0] m1;
		
		m0 = b[s  ] ? ({{32{a[31]}},a}<<s)     : '0;
		m1 = b[s+1] ? ({{32{a[31]}},a}<<(s+1)) : '0;
		
		return m0 + m1;
	endfunction
	
	// Signed and unsigned multiply share the two-bit partial-product path.
function bit [63:0] MultStep2Mode(input bit [31:0] a, input bit [1:0] b, input bit [4:0] s, input bit sign_extend);
	bit [63:0] m0;
	bit [63:0] m1;
	m0 = b[0] ? ({{32{a[31] && sign_extend}},a}<<(s+0)) : '0;
	m1 = b[1] ? ({{32{a[31] && sign_extend}},a}<<(s+1)) : '0;
	return m0 + m1;
endfunction

function bit [63:0] MultStep2(input bit [31:0] a, input bit [1:0] b, input bit [4:0] s);
		bit [63: 0] m0;
		bit [63: 0] m1;
		
		m0 = b[0] ? ({{32{a[31]}},a}<<(s+0)) : '0;
		m1 = b[1] ? ({{32{a[31]}},a}<<(s+1)) : '0;
		
		return m0 + m1;
	endfunction
	
	function bit [63:0] Neg64(input bit [63:0] a, input bit en);
		bit [63: 0] res;
		
		res = (a ^ {64{en}}) + en;
		
		return res;
	endfunction
	
	function bit [3:0] BitToReg(input bit [15:0] val, input bit [3:0] currbit, input bit dir);
		bit [ 3: 0] res;
		bit [15: 0] mask;
		bit [15: 0] val0;
		bit [ 7: 0] tmp0;
		bit [ 3: 0] tmp1;
		bit [ 1: 0] tmp2;
		bit [ 0: 0] tmp3;
		
		mask = 16'hFFFF>>currbit;
		val0 = val & mask;
		
		tmp0 = !dir ? (val0[15: 8] ? val0[15: 8] : val0[ 7: 0]) : (val0[ 7: 0] ? val0[ 7: 0] : val0[15: 8]);
		tmp1 = !dir ? (tmp0[ 7: 4] ? tmp0[ 7: 4] : tmp0[ 3: 0]) : (tmp0[ 3: 0] ? tmp0[ 3: 0] : tmp0[ 7: 4]);
		tmp2 = !dir ? (tmp1[ 3: 2] ? tmp1[ 3: 2] : tmp1[ 1: 0]) : (tmp1[ 1: 0] ? tmp1[ 1: 0] : tmp1[ 3: 2]);
		tmp3 = !dir ? (tmp2[ 1: 1] ? tmp2[ 1: 1] : tmp2[ 0: 0]) : (tmp2[ 0: 0] ? tmp2[ 0: 0] : tmp2[ 1: 1]);
		
		res[3] = !dir ? |val0[15: 8] : |val0[ 7: 0];
		res[2] = !dir ? |tmp0[ 7: 4] : |tmp0[ 3: 0];
		res[1] = !dir ? |tmp1[ 3: 2] : |tmp1[ 1: 0];
		res[0] = !dir ? |tmp2[ 1: 1] : |tmp2[ 0: 0];
		
		return res;
	endfunction
	
	function bit [33:0] XYAdjust(input bit [31:0] a, input bit [31:0] max, input bit en);
		bit [15: 0] x,y;
		bit [15: 0] maxx,maxy;
		bit [15: 0] tmpy;
		bit [15: 0] resx,resy;
		bit         cox,coy;
		bit         wrapx, wrapy, yge, ynext_eq;

		{y,x} = a;
		{maxy,maxx} = max;
		
		// Compare the original Y in parallel with X. Testing the incremented
		// Y after the X wrap would put two compares and an adder in series.
		wrapx = en && x >= maxx;
		yge = y >= maxy;
		ynext_eq = y == (maxy - 16'd1);
		wrapy = en && (wrapx ? ((maxy == 0) ||
		        ((y != 16'hffff) && (yge || ynext_eq))) : yge);
		tmpy = wrapx ? y + 16'd1 : y;
		{cox,resx} = {wrapx,wrapx ? 16'h0000 : x};
		{coy,resy} = {wrapy,wrapy ? 16'h0000 : tmpy};
		
		return {coy,cox,resy,resx};
	endfunction
	
	function bit [3:0] XYCompareWin(input bit [31:0] v, input bit [31:0] min, input bit [31:0] max);
		bit [15: 0] minxs;
		bit [15: 0] minys;
		bit [15: 0] maxxs;
		bit [15: 0] maxys;
		
		minxs = v[15: 0] - min[15: 0];
		minys = v[31:16] - min[31:16];
		maxxs = max[15: 0] - v[15: 0];
		maxys = max[31:16] - v[31:16];

		return {maxys[15],minys[15],maxxs[15],minxs[15]};
	endfunction
	
	// The blit microcode supplies the exclusive far corner. Reject a rectangle
	// only when it has no pixels in the window; a far corner outside the window
	// alone does not exclude a partially visible blit.
	function automatic bit [3:0] XYCompareBltWin(input XY_t far, input XY_t size, input XY_t min, input XY_t max);
		bit signed [15:0] sx, sy;
		bit signed [17:0] ex, ey;
		sx = far.X - size.X;
		sy = far.Y - size.Y;
		ex = {{2{sx[15]}},sx} + $signed({2'b00,size.X});
		ey = {{2{sy[15]}},sy} + $signed({2'b00,size.Y});
		return {sy > $signed(max.Y), size.Y == 0 || ey <= $signed(min.Y),
		        sx > $signed(max.X), size.X == 0 || ex <= $signed(min.X)};
	endfunction

	function XY_t XYWinOffset(input XY_t v, input XY_t ws);
		XY_t res;
		
		res.X = $signed(ws.X) > $signed(v.X) ? ws.X - v.X : '0;
		res.Y = $signed(ws.Y) > $signed(v.Y) ? ws.Y - v.Y : '0;

		return res;
	endfunction
	
	function automatic XY_t WinAdjust(input XY_t far, input XY_t dydx, input XY_t wstart, input XY_t wend, input bit wen);
		XY_t res;
		bit [15:0] sx_bits, sy_bits;
		bit signed [17:0] sx, sy, ex, ey;
		bit signed [17:0] min_x, min_y, max_x_excl, max_y_excl;
		bit signed [17:0] near_x, near_y, far_x, far_y;
		
		if (wen) begin
			sx_bits = far.X - dydx.X;
			sy_bits = far.Y - dydx.Y;
			sx = $signed(sx_bits);
			sy = $signed(sy_bits);
			ex = sx + $signed({2'b00,dydx.X});
			ey = sy + $signed({2'b00,dydx.Y});
			min_x = $signed({{2{wstart.X[15]}},wstart.X});
			min_y = $signed({{2{wstart.Y[15]}},wstart.Y});
			max_x_excl = $signed({{2{wend.X[15]}},wend.X}) + 18'sd1;
			max_y_excl = $signed({{2{wend.Y[15]}},wend.Y}) + 18'sd1;
			near_x = sx > min_x ? sx : min_x;
			near_y = sy > min_y ? sy : min_y;
			far_x = ex < max_x_excl ? ex : max_x_excl;
			far_y = ey < max_y_excl ? ey : max_y_excl;
			res.X = far_x > near_x ? far_x - near_x : 16'd0;
			res.Y = far_y > near_y ? far_y - near_y : 16'd0;
		end else begin
			res = dydx;
		end

		return res;
	endfunction
	
	function bit [31:0] XYToL(input XY_t coord, input bit [5:0] ps, input bit [4:0] xp);
		bit [31: 0] xtol;
		bit [31: 0] ytol;
		
		case (ps)
			default: xtol = { {16{coord.X[15]}},coord.X };
			6'h01:   xtol = { {16{coord.X[15]}},coord.X };
			6'h02:   xtol = { {15{coord.X[15]}},coord.X,1'b0 };
			6'h04:   xtol = { {14{coord.X[15]}},coord.X,2'b00 };
			6'h08:   xtol = { {13{coord.X[15]}},coord.X,3'b000 };
			6'h10:   xtol = { {12{coord.X[15]}},coord.X,4'b0000 };
			6'h20:   xtol = { {11{coord.X[15]}},coord.X,5'b00000 };
		endcase
		ytol = { {16{coord.Y[15]}},coord.Y } << (~xp);
		
		return xtol + ytol;
	endfunction
	
	function bit [31:0] XStep(input bit [5:0] ps);
		bit [15: 0] x;
		
		case (ps)
			default: x = 16'h0000;
			6'h01: x = 16'h0020;
			6'h02: x = 16'h0010;
			6'h04: x = 16'h0008;
			6'h08: x = 16'h0004;
			6'h10: x = 16'h0002;
			6'h20: x = 16'h0001;
		endcase

		return {16'h0000,x};
	endfunction
	
	function bit [31:0] LineStep(input XY_t dydx, input bit gz);
		bit [15: 0] a,b;
		bit [31: 0] res;
		
		{b,a} = dydx;
		res = {{15{b[15]}},b,1'b0} - (gz ? {{15{a[15]}},a,1'b0} : 32'h0);//2b-2a

		return res;
	endfunction
	
	function bit [4:0] PSToShift(input bit [5:0] ps);
		bit [ 4: 0] res;
		
		case (ps)
			16'h0001: res = 5'd0;
			16'h0002: res = 5'd1;
			16'h0004: res = 5'd2;
			16'h0008: res = 5'd3;
			16'h0010: res = 5'd4;
			16'h0020: res = 5'd5;
			default:  res = 5'd0;
		endcase
		
		return res;
	endfunction
	
	
	function bit [5:0] PPWToFS(input bit [5:0] ppw, input bit [5:0] ps);
		bit [ 5: 0] res;
		
		case (ps)
			6'h01: res = {ppw[5:0]};
			6'h02: res = {ppw[4:0],1'b0};
			6'h04: res = {ppw[3:0],2'b00};
			6'h08: res = {ppw[2:0],3'b000};
			6'h10: res = {ppw[1:0],4'b0000};
			6'h20: res = {ppw[0:0],5'b00000};
			default: res = 5'd0;
		endcase
		
		return res;
	endfunction
	
	function bit [31:0] PatternExpand(input bit [31:0] bset, input bit [31:0] c0, input bit [31:0] c1, input bit [4:0] px, input bit [5:0] ps);
		bit [31: 0] res;
		bit [31: 0] mask;
		
		case (ps)
			6'h01: mask = bset;
			6'h02: mask = { { 2{bset[px+15]}},{ 2{bset[px+14]}},{2{bset[px+13]}},{2{bset[px+12]}},{2{bset[px+11]}},{2{bset[px+10]}},{2{bset[px+9]}},{2{bset[px+8]}},
			                { 2{bset[px+ 7]}},{ 2{bset[px+ 6]}},{2{bset[px+ 5]}},{2{bset[px+ 4]}},{2{bset[px+ 3]}},{2{bset[px+ 2]}},{2{bset[px+1]}},{2{bset[px+0]}} };
			6'h04: mask = { { 4{bset[px+ 7]}},{ 4{bset[px+ 6]}},{4{bset[px+ 5]}},{4{bset[px+ 4]}},{4{bset[px+ 3]}},{4{bset[px+ 2]}},{4{bset[px+1]}},{4{bset[px+0]}} };
			6'h08: mask = { { 8{bset[px+ 3]}},{ 8{bset[px+ 2]}},{8{bset[px+ 1]}},{8{bset[px+ 0]}} };
			6'h10: mask = { {16{bset[px+ 1]}},{16{bset[px+ 0]}} };
			6'h20: mask = { {32{bset[px+ 0]}} };
			default: mask = 5'd0;
		endcase
		res = (c0 & ~mask) | (c1 & mask);
		
		return res;
	endfunction
	
	function bit [31:0] PatternEqual(input bit [31:0] pat, input bit [31:0] col, input bit [5:0] ps);
		bit [31: 0] res;
		bit [31: 0] temp;
		bit [15: 0] m2;
		bit [ 7: 0] m4;
		bit [ 3: 0] m8;
		bit [ 1: 0] m16;
		
		temp = pat ^ ~col;
//		m2  = { {2{&temp[31:30]}},{2{&temp[29:28]}},{2{&temp[27:26]}},{2{&temp[25:24]}},{2{&temp[23:22]}},{2{&temp[21:20]}},{2{&temp[19:18]}},{2{&temp[17:16]}},
//		        {2{&temp[15:14]}},{2{&temp[13:12]}},{2{&temp[11:10]}},{2{&temp[ 9: 8]}},{2{&temp[ 7: 6]}},{2{&temp[ 5: 4]}},{2{&temp[ 3: 2]}},{2{&temp[ 1: 0]}} };
//		m4  = { {2{&  m2[15:14]}},{2{&  m2[13:12]}},{2{&  m2[11:10]}},{2{&  m2[ 9: 8]}},{2{&  m2[ 7: 6]}},{2{&  m2[ 5: 4]}},{2{&  m2[ 3: 2]}},{2{&  m2[ 1: 0]}} };
//		m8  = { {2{&  m4[ 7: 6]}},{2{&  m4[ 5: 4]}},{2{&  m4[ 3: 2]}},{2{&  m4[ 1: 0]}} };
//		m16 = { {2{&  m8[ 3: 2]}},{2{&  m8[ 1: 0]}} };
		
		case (ps)
			6'h01: res = temp;
			6'h02: res = { { 2{&temp[31:30]}},{ 2{&temp[29:28]}},{2{&temp[27:26]}},{2{&temp[25:24]}},{2{&temp[23:22]}},{2{&temp[21:20]}},{2{&temp[19:18]}},{2{&temp[17:16]}},
			               { 2{&temp[15:14]}},{ 2{&temp[13:12]}},{2{&temp[11:10]}},{2{&temp[ 9: 8]}},{2{&temp[ 7: 6]}},{2{&temp[ 5: 4]}},{2{&temp[ 3: 2]}},{2{&temp[ 1: 0]}} };
			6'h04: res = { { 4{&temp[31:28]}},{ 4{&temp[27:24]}},{4{&temp[23:20]}},{4{&temp[19:16]}},{4{&temp[15:12]}},{4{&temp[11: 8]}},{4{&temp[ 7: 4]}},{4{&temp[ 3: 0]}} };
			6'h08: res = { { 8{&temp[31:24]}},{ 8{&temp[23:16]}},{8{&temp[15: 8]}},{8{&temp[ 7: 0]}} };
			6'h10: res = { {16{&temp[31:16]}},{16{&temp[15: 0]}} };
			6'h20: res = { {32{&temp[31: 0]}} };
			default: res = 5'd0;
		endcase
		
		return res;
	endfunction
	
	// Exact aggregate of ~PatternEqual, without constructing and reducing the
	// complete lane mask on the instruction decoder's write-enable path.
	function bit PatternWritable(input bit [31:0] pat, input bit [31:0] col, input bit [5:0] ps);
		case (ps)
			6'h01, 6'h02, 6'h04, 6'h08, 6'h10, 6'h20: return pat != col;
			default: return 1'b1;
		endcase
	endfunction

	// ---- PATS_B predecode helpers: exact factorisation of PatternExpand / PatternEqual ----
	// Pixel lane k (PSIZE bits wide) of the expanded bitmap pattern is selected by
	// bitmap bit px+k (bit i itself for PSIZE=1: no rotation). PatternBitView()
	// returns that select already replicated across each pixel's bits (bit i of
	// the result is the select of the pixel containing bit i); out-of-range
	// bit-selects resolve as in PatternExpand's variable bit-select, and an invalid PSIZE
	// gives 0 (PatternExpand then selects COLOR0 everywhere).
	// Then PatternExpand(..) == (c0 & ~view) | (c1 & view).
	function bit [31:0] PatternBitView(input bit [31:0] bset, input bit [4:0] px, input bit [5:0] ps);
		bit [31:0] res;
		res = '0;
		// Same index expression form as PatternExpand (px + constant), so any
		// out-of-range select resolves exactly as it does there.
		for (int i = 0; i < 32; i++) begin
			case (ps)
				6'h01: res[i] = bset[i];
				6'h02: res[i] = bset[px + (i >> 1)];
				6'h04: res[i] = bset[px + (i >> 2)];
				6'h08: res[i] = bset[px + (i >> 3)];
				6'h10: res[i] = bset[px + (i >> 4)];
				6'h20: res[i] = bset[px + 0];
				default: res[i] = 1'b0;
			endcase
		end
		return res;
	endfunction

	// Bit i = pixel (of ps bits) containing bit i of a differs from that of b.
	function bit [31:0] LaneDiff(input bit [31:0] a, input bit [31:0] b, input bit [5:0] ps);
		bit [31:0] t, res;
		t = a ^ b;
		res = '0;
		case (ps)
			6'h01: res = t;
			6'h02: for (int j = 0; j < 16; j++) res[2*j +: 2] = {2{|t[2*j +: 2]}};
			6'h04: for (int j = 0; j <  8; j++) res[4*j +: 4] = {4{|t[4*j +: 4]}};
			6'h08: for (int j = 0; j <  4; j++) res[8*j +: 8] = {8{|t[8*j +: 8]}};
			6'h10: for (int j = 0; j <  2; j++) res[16*j +: 16] = {16{|t[16*j +: 16]}};
			6'h20: res = {32{|t}};
			default: ;
		endcase
		return res;
	endfunction

	// {NE1, NE0} for the PATS_B transparency compare. With view = PatternBitView(..),
	//   ~PatternEqual(PAT0, COLOR0 & TM0, PSIZE) == (view & NE1) | (~view & NE0)
	// when the transparency compare is active for a valid PSIZE; in every other case
	// (T=0, TM[1]=1, invalid PSIZE: TMASK = 0) NE0 = NE1 = all ones, so the
	// write mask is all ones. The pixel write enable is then |write_mask.
	function bit [63:0] PatternWriteNE(input bit [31:0] c0, input bit [31:0] c1, input bit [2:0] tm, input bit t, input bit [5:0] ps);
		bit [31:0] col, ne0, ne1;
		bit force_we;
		col = c0 & {32{tm[0]}};
		ne0 = LaneDiff(c0, col, ps);
		ne1 = LaneDiff(c1, col, ps);
		if (tm == 3'b101) begin	// transparent source is 0 whatever the bitmap
			ne0 = LaneDiff(32'b0, col, ps);
			ne1 = ne0;
		end
		force_we = !(t && !tm[1]) || !(ps == 6'h01 || ps == 6'h02 || ps == 6'h04 ||
		                              ps == 6'h08 || ps == 6'h10 || ps == 6'h20);
		if (force_we) begin ne0 = '1; ne1 = '1; end
		return {ne1, ne0};
	endfunction

	function bit [31:0] PatternWriteMask(input bit [63:0] ne, input bit [31:0] view);
		return (view & ne[63:32]) | (~view & ne[31:0]);
	endfunction

	function bit [63:0] DataWriteMask(input bit [4:0] ba, input bit [5:0] fsize);
		bit [63:0] res;
		bit [63:0] lmask,rmask;
		
		lmask = 64'hFFFFFFFFFFFFFFFF<<ba;
		rmask = 64'hFFFFFFFFFFFFFFFF<<(fsize+ba);
		res = lmask & ~rmask;
		
		return res;
	endfunction
	
//	function bit [63:0] PixWriteMask(input bit [4:0] ba, input bit [5:0] fsize);
//		bit [63:0] res;
//		bit [63:0] lmask,rmask;
//		
//		lmask = 64'hFFFFFFFFFFFFFFFF<<ba;
//		rmask = 64'hFFFFFFFFFFFFFFFF<<(fsize+ba);
//		res = lmask & ~rmask;
//		
//		return res;
//	endfunction
	
	function bit [31:0] InAligner(input bit [31:0] data, input bit [31:0] old, input bit [4:0] ba, input bit [5:0] fsize);
		bit [31:0] res;
		bit [31:0] mask;
		
		mask = 32'hFFFFFFFF<<fsize;
		res = ((data>>ba) & ~mask) | (old & mask);
		
		return res;
	endfunction
	
	function bit [31:0] InAlignerExt(input bit [31:0] data, input bit [31:0] old, input bit [5:0] fsize, input bit [5:0] fsize_old);
		bit [31:0] res;
		bit [31:0] mask,omask;
		
		mask = 32'hFFFFFFFF<<fsize;
		omask = 32'hFFFFFFFF<<fsize_old;
		res = ((data << fsize_old) & ~mask) | (old & ~omask);
		
		return res;
	endfunction
	
	function bit [31:0] OutAligner(input bit [31:0] data, input bit [31:0] old, input bit [4:0] ba, input bit [5:0] fsize);
		bit [31:0] res;
		bit [31:0] bmask,fbmask;
		
		bmask = 32'hFFFFFFFF<<ba; 
		fbmask = 32'hFFFFFFFF<<(fsize+ba);
		res = ((data<<ba) & ~fbmask) | (old & (fbmask | ~bmask));
		
		return res;
	endfunction
	
	function bit [31:0] OutAlignerExt(input bit [31:0] data, input bit [31:0] old, input bit [4:0] ba_old, input bit [5:0] fsize);
		bit [31:0] res;
		bit [31:0] bmask,fbmask;
		
//		bmask = 32'hFFFFFFFF<<ba; 
		fbmask = 32'hFFFFFFFF<<(fsize[4:0]+ba_old);
		res = ((data>>(5'h00-ba_old)) & ~fbmask) | (old & fbmask);
		
		return res;
	endfunction
	
	typedef struct packed
	{
		bit         N;
		bit         C;
		bit         Z;
		bit         V;
		bit         UNUSED;
		bit         BF;
		bit         IX;
		bit [ 1: 0] UNUSED2;
		bit         SS;
		bit         IE;
		bit [ 8: 0] UNUSED3;
		bit         FE1;
		bit [ 4: 0] FS1;
		bit         FE0;
		bit [ 4: 0] FS0;
	} ST_t;
	parameter bit [31:0] ST_WMASK = 32'hF6600FFF;
	parameter bit [31:0] ST_RMASK = 32'hF6600FFF;
	parameter bit [31:0] ST_INIT = 32'h00000010;
	
	//IO registers
	typedef bit [15:0] VESYNC_t;		//R/W;C0000000
	parameter bit [15:0] VESYNC_WMASK = 16'hFFFF;
	parameter bit [15:0] VESYNC_RMASK = 16'hFFFF;
	parameter bit [15:0] VESYNC_INIT = 16'h0000;
	
	typedef bit [15:0] HESYNC_t;		//R/W;C0000010
	parameter bit [15:0] HESYNC_WMASK = 16'hFFFF;
	parameter bit [15:0] HESYNC_RMASK = 16'hFFFF;
	parameter bit [15:0] HESYNC_INIT = 16'h0000;
	
	typedef bit [15:0] VEBLNK_t;		//R/W;C0000020
	parameter bit [15:0] VEBLNK_WMASK = 16'hFFFF;
	parameter bit [15:0] VEBLNK_RMASK = 16'hFFFF;
	parameter bit [15:0] VEBLNK_INIT = 16'h0000; 
	
	typedef bit [15:0] HEBLNK_t;		//R/W;C0000030
	parameter bit [15:0] HEBLNK_WMASK = 16'hFFFF;
	parameter bit [15:0] HEBLNK_RMASK = 16'hFFFF;
	parameter bit [15:0] HEBLNK_INIT = 16'h0000; 
	
	typedef bit [15:0] VSBLNK_t;		//R/W;C0000040
	parameter bit [15:0] VSBLNK_WMASK = 16'hFFFF;
	parameter bit [15:0] VSBLNK_RMASK = 16'hFFFF;
	parameter bit [15:0] VSBLNK_INIT = 16'h0000; 
	
	typedef bit [15:0] HSBLNK_t;		//R/W;C0000050
	parameter bit [15:0] HSBLNK_WMASK = 16'hFFFF;
	parameter bit [15:0] HSBLNK_RMASK = 16'hFFFF;
	parameter bit [15:0] HSBLNK_INIT = 16'h0000; 
	
	typedef bit [15:0] VTOTAL_t;		//R/W;C0000060
	parameter bit [15:0] VTOTAL_WMASK = 16'hFFFF;
	parameter bit [15:0] VTOTAL_RMASK = 16'hFFFF;
	parameter bit [15:0] VTOTAL_INIT = 16'h0000; 
	
	typedef bit [15:0] HTOTAL_t;		//R/W;C0000070
	parameter bit [15:0] HTOTAL_WMASK = 16'hFFFF;
	parameter bit [15:0] HTOTAL_RMASK = 16'hFFFF;
	parameter bit [15:0] HTOTAL_INIT = 16'h0000; 
	
	typedef struct packed		//R/W;C0000080
	{
		bit         ENV;
		bit         NIL;			//
		bit         UNUSED;		
		bit         SRE;			//
		bit         CST;			//
		bit [ 2: 0] UNUSED2;
		bit         VCD;			//
		bit         SSV;			//
		bit [ 1: 0] UNUSED3;
		bit         CVD;			
		bit         CSD;			
		bit         VSD;			
		bit         HSD;			
	} DPYCTL_t;
	parameter bit [15:0] DPYCTL_WMASK = 16'hD8CF;
	parameter bit [15:0] DPYCTL_RMASK = 16'hD8CF;
	parameter bit [15:0] DPYCTL_INIT = 16'h0000; 
	
	typedef bit [15:0] DPYSTRT_t;		//R/W;C0000090
	parameter bit [15:0] DPYSTRT_WMASK = 16'hFFFF;
	parameter bit [15:0] DPYSTRT_RMASK = 16'hFFFF;
	parameter bit [15:0] DPYSTRT_INIT = 16'h0000; 
	
	typedef bit [15:0] DPYINT_t;		//R/W;C00000A0
	parameter bit [15:0] DPYINT_WMASK = 16'hFFFF;
	parameter bit [15:0] DPYINT_RMASK = 16'hFFFF;
	parameter bit [15:0] DPYINT_INIT = 16'h0000; 
	
	typedef struct packed		//R/W;C00000B0/C0000190
	{
		bit         CD;			//
		bit [ 4: 0] PPOP;			//
		bit         PBV;			//		
		bit         PBH;			//
		bit [ 1: 0] W;				//
		bit         T;				//
		bit [ 1: 0] UNUSED;
		bit [ 2: 0] TM;			//
	} CONTROL_t;
	parameter bit [15:0] CONTROL_WMASK = 16'hFFE7;
	parameter bit [15:0] CONTROL_RMASK = 16'hFFE7;
	parameter bit [15:0] CONTROL_INIT = 16'h0000; 
	
	typedef bit [15:0] HSTDATA_t;		//R/W;C00000C0
	parameter bit [15:0] HSTDATA_WMASK = 16'hFFFF;
	parameter bit [15:0] HSTDATA_RMASK = 16'hFFFF;
	parameter bit [15:0] HSTDATA_INIT = 16'h0000; 
	
	typedef bit [15:0] HSTADRL_t;		//R/W;C00000D0
	parameter bit [15:0] HSTADRL_WMASK = 16'hFFFF;
	parameter bit [15:0] HSTADRL_RMASK = 16'hFFFF;
	parameter bit [15:0] HSTADRL_INIT = 16'h0000; 
	
	typedef bit [15:0] HSTADRH_t;		//R/W;C00000E0
	parameter bit [15:0] HSTADRH_WMASK = 16'hFFFF;
	parameter bit [15:0] HSTADRH_RMASK = 16'hFFFF;
	parameter bit [15:0] HSTADRH_INIT = 16'h0000;
	
	typedef struct packed		//R/W;C00000F0
	{
		bit         HBREN;		//
		bit         HBFI;
		bit         HRYI;			//
		bit         EMIEN;		//
		bit         EMG;			//		
		bit         EMR;			//
		bit [ 1: 0] UNUSED;
		bit         INTOUT;		//
		bit [ 2: 0] MSGOUT;		//
		bit         INTIN;		//
		bit [ 2: 0] MSGIN;
	} HSTCTLL_t;
	parameter bit [15:0] HSTCTLL_WMASK = 16'hFCFF;
	parameter bit [15:0] HSTCTLL_RMASK = 16'hFCFF;
	parameter bit [15:0] HSTCTLL_INIT = 16'h0000; 
	
	typedef struct packed		//R/W;C0000100
	{
		bit         HLT;			//
		bit         CF;			//
		bit         UNUSED;
		bit         HINC;			//
		bit         HPFW;			//
		bit         UNUSED2;
		bit         NMIM;			//		
		bit         NMI;			//
		bit         RST;			//
		bit [ 1: 0] HLB;			//
		bit         HACK;			//
		bit [ 3: 0] UNUSED3;
	} HSTCTLH_t;
	parameter bit [15:0] HSTCTLH_WMASK = 16'hDBF0;
	parameter bit [15:0] HSTCTLH_RMASK = 16'hDBF0;
	parameter bit [15:0] HSTCTLH_INIT = 16'h0000; 
	
	typedef struct packed		//R/W;C0000110
	{
		bit [ 3: 0] UNUSED;
		bit         WVE;			//
		bit         DIE;			//
		bit         HIE;			//
		bit [ 5: 0] UNUSED2;		
		bit         X2E;			//
		bit         X1E;			
		bit         UNUSED3;
	} INTENB_t;
	parameter bit [15:0] INTENB_WMASK = 16'h0E06;
	parameter bit [15:0] INTENB_RMASK = 16'h0E06;
	parameter bit [15:0] INTENB_INIT = 16'h0000; 
	
	typedef struct packed		//R/W;C0000120
	{
		bit [ 3: 0] UNUSED;
		bit         WVP;			//
		bit         DIP;			//
		bit         HIP;			//
		bit [ 5: 0] UNUSED2;		
		bit         X2P;			//
		bit         X1P;			
		bit         UNUSED3;
	} INTPEND_t;
	parameter bit [15:0] INTPEND_WMASK = 16'h0E06;
	parameter bit [15:0] INTPEND_RMASK = 16'h0E06;
	parameter bit [15:0] INTPEND_INIT = 16'h0000; 
	
	typedef bit [15:0] CONVSP_t;		//R/W;C0000130
	parameter bit [15:0] CONVSP_WMASK = 16'hFFFF;
	parameter bit [15:0] CONVSP_RMASK = 16'hFFFF;
	parameter bit [15:0] CONVSP_INIT = 16'h0000; 
	
	typedef bit [15:0] CONVDP_t;		//R/W;C0000140
	parameter bit [15:0] CONVDP_WMASK = 16'hFFFF;
	parameter bit [15:0] CONVDP_RMASK = 16'hFFFF;
	parameter bit [15:0] CONVDP_INIT = 16'h0000;
	
	typedef bit [15:0] PSIZE_t;		//R/W;C0000150
	parameter bit [15:0] PSIZE_WMASK = 16'hFFFF;
	parameter bit [15:0] PSIZE_RMASK = 16'hFFFF;
	parameter bit [15:0] PSIZE_INIT = 16'h0000;
	
	typedef bit [31:0] PMASK_t;		//R/W;C0000160
	parameter bit [31:0] PMASK_WMASK = 32'hFFFFFFFF;
	parameter bit [31:0] PMASK_RMASK = 32'hFFFFFFFF;
	parameter bit [31:0] PMASK_INIT = 32'h00000000;
	
	typedef bit [15:0] CONVMP_t;		//R/W;C0000180
	parameter bit [15:0] CONVMP_WMASK = 16'hFFFF;
	parameter bit [15:0] CONVMP_RMASK = 16'hFFFF;
	parameter bit [15:0] CONVMP_INIT = 16'h0000;
	
	//typedef bit [15:0] CONTROL_t;	//R/W;C0000190
	
	typedef struct packed		//R/W;C00001A0
	{
		bit [ 2: 0] UNUSED;
		bit [ 2: 0] RR;			//
		bit         UNUSED2;		
		bit         VEN;			//
		bit [ 3: 0] UNUSED3;
		bit         CBP;			//
		bit [ 1: 0] RCM;			//
		bit         BEN;			
	} CONFIG_t;
	parameter bit [15:0] CONFIG_WMASK = 16'h1D0F;
	parameter bit [15:0] CONFIG_RMASK = 16'h1D0F;
	parameter bit [15:0] CONFIG_INIT = 16'h0000; 
	
	typedef bit [15:0] DPYTAP_t;		//R/W;C00001B0
	parameter bit [15:0] DPYTAP_WMASK = 16'hFFFF;
	parameter bit [15:0] DPYTAP_RMASK = 16'hFFFF;
	parameter bit [15:0] DPYTAP_INIT = 16'h0000; 
	
	typedef bit [15:0] VCOUNT_t;		//R/W;C00001C0
	parameter bit [15:0] VCOUNT_WMASK = 16'hFFFF;
	parameter bit [15:0] VCOUNT_RMASK = 16'hFFFF;
	parameter bit [15:0] VCOUNT_INIT = 16'h0000;
	
	typedef bit [15:0] HCOUNT_t;		//R/W;C00001D0
	parameter bit [15:0] HCOUNT_WMASK = 16'hFFFF;
	parameter bit [15:0] HCOUNT_RMASK = 16'hFFFF;
	parameter bit [15:0] HCOUNT_INIT = 16'h0000; 
	
	typedef bit [15:0] DPYADR_t;		//R/W;C00001E0
	parameter bit [15:0] DPYADR_WMASK = 16'hFFFF;
	parameter bit [15:0] DPYADR_RMASK = 16'hFFFF;
	parameter bit [15:0] DPYADR_INIT = 16'h0000; 
	
	typedef bit [15:0] REFADR_t;		//R/W;C00001F0
	parameter bit [15:0] REFADR_WMASK = 16'hFFFF;
	parameter bit [15:0] REFADR_RMASK = 16'hFFFF;
	parameter bit [15:0] REFADR_INIT = 16'h0000;
	
	typedef struct packed		//R/W;C0000200
	{
		bit [26: 0] SRST;			//
		bit [ 4: 0] UNUSED;		//
	} DPYST_t;
	parameter bit [31:0] DPYST_WMASK = 32'hFFFFFFFF;
	parameter bit [31:0] DPYST_RMASK = 32'hFFFFFFFF;
	parameter bit [31:0] DPYST_INIT = 32'h00000000; 
	
	typedef struct packed		//R/W;C0000220
	{
		bit [26: 0] SRNX;			//
		bit [ 4: 0] YZCNT;		//
	} DPYNX_t;
	parameter bit [31:0] DPYNX_WMASK = 32'hFFFFFFFF;
	parameter bit [31:0] DPYNX_RMASK = 32'hFFFFFFFF;
	parameter bit [31:0] DPYNX_INIT = 32'h00000000; 
	
	typedef struct packed		//R/W;C0000240
	{
		bit [26: 0] SRINC;			//
		bit [ 4: 0] YZINC;		//
	} DINC_t;
	parameter bit [31:0] DINC_WMASK = 32'hFFFFFFFF;
	parameter bit [31:0] DINC_RMASK = 32'hFFFFFFFF;
	parameter bit [31:0] DINC_INIT = 32'h00000000; 
	
	typedef bit [15:0] HESERR_t;		//R/W;C0000270
	parameter bit [15:0] HESERR_WMASK = 16'hFFFF;
	parameter bit [15:0] HESERR_RMASK = 16'hFFFF;
	parameter bit [15:0] HESERR_INIT = 16'h0000;
	
	typedef bit [15:0] SCOUNT_t;		//R/W;C00002C0
	parameter bit [15:0] SCOUNT_WMASK = 16'hFFFF;
	parameter bit [15:0] SCOUNT_RMASK = 16'hFFFF;
	parameter bit [15:0] SCOUNT_INIT = 16'h0000;
	
	typedef bit [15:0] BSFLTST_t;		//R/W;C00002D0
	parameter bit [15:0] BSFLTST_WMASK = 16'hFFFF;
	parameter bit [15:0] BSFLTST_RMASK = 16'hFFFF;
	parameter bit [15:0] BSFLTST_INIT = 16'h0000; 
	
	typedef bit [15:0] DPYMSK_t;		//R/W;C00002E0
	parameter bit [15:0] DPYMSK_WMASK = 16'hFFFF;
	parameter bit [15:0] DPYMSK_RMASK = 16'hFFFF;
	parameter bit [15:0] DPYMSK_INIT = 16'h0000; 
	
	typedef bit [15:0] SETVCNT_t;		//R/W;C0000300
	parameter bit [15:0] SETVCNT_WMASK = 16'hFFFF;
	parameter bit [15:0] SETVCNT_RMASK = 16'hFFFF;
	parameter bit [15:0] SETVCNT_INIT = 16'h0000;
	
	typedef bit [15:0] SETHCNT_t;		//R/W;C0000310
	parameter bit [15:0] SETHCNT_WMASK = 16'hFFFF;
	parameter bit [15:0] SETHCNT_RMASK = 16'hFFFF;
	parameter bit [15:0] SETHCNT_INIT = 16'h0000;
	
	typedef bit [31:0] BSFLTD_t;		//R/W;C0000320
	parameter bit [31:0] BSFLTD_WMASK = 32'hFFFFFFFF;
	parameter bit [31:0] BSFLTD_RMASK = 32'hFFFFFFFF;
	parameter bit [31:0] BSFLTD_INIT = 32'h00000000; 
	
	typedef bit [31:0] IHOSTx_t;		//R/W;C0000380,C00003A0,C00003C0,C00003E0
	parameter bit [31:0] IHOSTx_WMASK = 32'hFFFFFFFF;
	parameter bit [31:0] IHOSTx_RMASK = 32'hFFFFFFFF;
	parameter bit [31:0] IHOSTx_INIT = 32'h00000000; 
	
	typedef struct packed
	{
		VESYNC_t VESYNC;
		HESYNC_t HESYNC;
		VEBLNK_t VEBLNK;
		HEBLNK_t HEBLNK;
		VSBLNK_t VSBLNK;
		HSBLNK_t HSBLNK;
		VTOTAL_t VTOTAL;
		HTOTAL_t HTOTAL;
		DPYCTL_t DPYCTL;
		DPYSTRT_t DPYSTRT;
		DPYINT_t DPYINT;
		CONTROL_t CONTROL;
		HSTDATA_t HSTDATA;
		HSTADRL_t HSTADRL;
		HSTADRH_t HSTADRH;
		HSTCTLL_t HSTCTLL;
		HSTCTLH_t HSTCTLH;
		INTENB_t INTENB;
		INTPEND_t INTPEND;
		CONVSP_t CONVSP;
		CONVDP_t CONVDP;
		PSIZE_t      PSIZE;
		PMASK_t PMASK;
		CONVMP_t CONVMP;
		CONFIG_t CONFIG;
		DPYTAP_t DPYTAP;
		VCOUNT_t VCOUNT;
		HCOUNT_t HCOUNT;
		DPYADR_t DPYADR;
		REFADR_t REFADR;
		DPYST_t DPYST;
		DPYNX_t DPYNX;
		DINC_t DINC;
		HESERR_t HESERR;
		SCOUNT_t SCOUNT;
		BSFLTST_t BSFLTST;
		BSFLTD_t BSFLTD;
		DPYMSK_t DPYMSK;
		SETVCNT_t SETVCNT;
		SETHCNT_t SETHCNT;
		IHOSTx_t IHOST1;
		IHOSTx_t IHOST2;
		IHOSTx_t IHOST3;
		IHOSTx_t IHOST4;
	} IOReg_t;


	// Literal opcode comparisons captured with IC on the same R edge.
	typedef bit [123:0] ICMatches_t;
	function automatic ICMatches_t DecodeICMatches(input bit [15:0] ic_word);
		DecodeICMatches[0] = ((ic_word & 16'hF740) == 16'h0040) |
			((ic_word & 16'hFB20) == 16'h0820) |
			((ic_word & 16'hF7C0) == 16'h0200) |
			((ic_word & 16'hFF10) == 16'h0F10) |
			((ic_word & 16'hFB80) == 16'h0880) |
			((ic_word & 16'hFD60) == 16'h0840) |
			((ic_word & 16'hFDA0) == 16'h08A0) |
			((ic_word & 16'hFEE0) == 16'h0000) |
			((ic_word & 16'hFF90) == 16'h0310) |
			((ic_word & 16'hF730) == 16'h0010) |
			((ic_word & 16'hF7A0) == 16'h00A0) |
			((ic_word & 16'hFED0) == 16'h00D0) |
			((ic_word & 16'hFE70) == 16'h0C70) |
			((ic_word & 16'hFFC0) == 16'h0F40) |
			((ic_word & 16'hFEF0) == 16'h0C40) |
			((ic_word & 16'hFEF0) == 16'h0850) |
			((ic_word & 16'hFEF0) == 16'h0C20);
		DecodeICMatches[1] = ((ic_word & 16'hFFE0) == 16'h0020);
		DecodeICMatches[2] = ((ic_word & 16'hFFF0) == 16'h0080);
		DecodeICMatches[3] = ((ic_word & 16'hFFE0) == 16'h0120);
		DecodeICMatches[4] = ((ic_word & 16'hFFE0) == 16'h0140);
		DecodeICMatches[5] = ((ic_word & 16'hFFE0) == 16'h0160);
		DecodeICMatches[6] = ((ic_word & 16'hFFE0) == 16'h0180);
		DecodeICMatches[7] = ((ic_word & 16'hFFE0) == 16'h01A0);
		DecodeICMatches[8] = ((ic_word & 16'hFFF0) == 16'h01C0);
		DecodeICMatches[9] = ((ic_word & 16'hFFF0) == 16'h01E0);
		DecodeICMatches[10] = ((ic_word & 16'hFFC0) == 16'h0240) |
			((ic_word & 16'hFF60) == 16'h0260);
		DecodeICMatches[11] = ((ic_word & 16'hFFE0) == 16'h0280);
		DecodeICMatches[12] = ((ic_word & 16'hFFE0) == 16'h02A0);
		DecodeICMatches[13] = ((ic_word & 16'hFFE0) == 16'h02C0);
		DecodeICMatches[14] = ((ic_word & 16'hFFF0) == 16'h0300) |
			((ic_word & 16'hFFF0) == 16'h0C50);
		DecodeICMatches[15] = ((ic_word & 16'hFFF0) == 16'h0320);
		DecodeICMatches[16] = ((ic_word & 16'hFFF0) == 16'h0340);
		DecodeICMatches[17] = ((ic_word & 16'hFFF0) == 16'h0360);
		DecodeICMatches[18] = ((ic_word & 16'hFFE0) == 16'h0380);
		DecodeICMatches[19] = ((ic_word & 16'hFFE0) == 16'h03A0) |
			((ic_word & 16'hFFE0) == 16'h03C0);
		DecodeICMatches[20] = ((ic_word & 16'hFFE0) == 16'h03E0);
		DecodeICMatches[21] = ((ic_word & 16'hFD00) == 16'h0400) |
			((ic_word & 16'hF700) == 16'h0600);
		DecodeICMatches[22] = ((ic_word & 16'hFDE0) == 16'h0500);
		DecodeICMatches[23] = ((ic_word & 16'hFDE0) == 16'h0520);
		DecodeICMatches[24] = ((ic_word & 16'hFDC0) == 16'h0540);
		DecodeICMatches[25] = ((ic_word & 16'hFDE0) == 16'h0580);
		DecodeICMatches[26] = ((ic_word & 16'hFDE0) == 16'h05A0);
		DecodeICMatches[27] = ((ic_word & 16'hFDE0) == 16'h05C0);
		DecodeICMatches[28] = ((ic_word & 16'hFDE0) == 16'h05E0);
		DecodeICMatches[29] = ((ic_word & 16'hFFF0) == 16'h0800);
		DecodeICMatches[30] = ((ic_word & 16'hFFE0) == 16'h0900);
		DecodeICMatches[31] = ((ic_word & 16'hFFE0) == 16'h0920);
		DecodeICMatches[32] = ((ic_word & 16'hFFF0) == 16'h0940);
		DecodeICMatches[33] = ((ic_word & 16'hFFE0) == 16'h0960);
		DecodeICMatches[34] = ((ic_word & 16'hFFE0) == 16'h0980);
		DecodeICMatches[35] = ((ic_word & 16'hFFE0) == 16'h09A0);
		DecodeICMatches[36] = ((ic_word & 16'hFFC0) == 16'h09C0);
		DecodeICMatches[37] = ((ic_word & 16'hFFE0) == 16'h0A60) |
			((ic_word & 16'hFFE0) == 16'h0A80);
		DecodeICMatches[38] = ((ic_word & 16'hFFA0) == 16'h0B00);
		DecodeICMatches[39] = ((ic_word & 16'hFFA0) == 16'h0B20);
		DecodeICMatches[40] = ((ic_word & 16'hFFA0) == 16'h0B80) |
			((ic_word & 16'hFFC0) == 16'h0B80);
		DecodeICMatches[41] = ((ic_word & 16'hFFE0) == 16'h0BE0);
		DecodeICMatches[42] = ((ic_word & 16'hFFE0) == 16'h0C00);
		DecodeICMatches[43] = ((ic_word & 16'hFFE0) == 16'h0D00);
		DecodeICMatches[44] = ((ic_word & 16'hFFF0) == 16'h0D30);
		DecodeICMatches[45] = ((ic_word & 16'hFFF0) == 16'h0D50);
		DecodeICMatches[46] = ((ic_word & 16'hFFF0) == 16'h0D60);
		DecodeICMatches[47] = ((ic_word & 16'hFFE0) == 16'h0D80);
		DecodeICMatches[48] = ((ic_word & 16'hFFE0) == 16'h0DA0);
		DecodeICMatches[49] = ((ic_word & 16'hFFE0) == 16'h0DC0);
		DecodeICMatches[50] = ((ic_word & 16'hFFF0) == 16'h0DE0);
		DecodeICMatches[51] = ((ic_word & 16'hFFD0) == 16'h0F00);
		DecodeICMatches[52] = ((ic_word & 16'hFFD0) == 16'h0F80);
		DecodeICMatches[53] = ((ic_word & 16'hFFD0) == 16'h0FC0);
		DecodeICMatches[54] = ((ic_word & 16'hFC00) == 16'h1000);
		DecodeICMatches[55] = ((ic_word & 16'hFC00) == 16'h1400);
		DecodeICMatches[56] = ((ic_word & 16'hFC00) == 16'h1800);
		DecodeICMatches[57] = ((ic_word & 16'hFC00) == 16'h1C00);
		DecodeICMatches[58] = ((ic_word & 16'hFC00) == 16'h2000);
		DecodeICMatches[59] = ((ic_word & 16'hFC00) == 16'h2400);
		DecodeICMatches[60] = ((ic_word & 16'hFC00) == 16'h2800);
		DecodeICMatches[61] = ((ic_word & 16'hFC00) == 16'h2C00);
		DecodeICMatches[62] = ((ic_word & 16'hFC00) == 16'h3000);
		DecodeICMatches[63] = ((ic_word & 16'hFC00) == 16'h3400);
		DecodeICMatches[64] = ((ic_word & 16'hF800) == 16'h3800);
		DecodeICMatches[65] = ((ic_word & 16'hFE00) == 16'h4000);
		DecodeICMatches[66] = ((ic_word & 16'hFE00) == 16'h4200);
		DecodeICMatches[67] = ((ic_word & 16'hFE00) == 16'h4400);
		DecodeICMatches[68] = ((ic_word & 16'hFE00) == 16'h4600);
		DecodeICMatches[69] = ((ic_word & 16'hFE00) == 16'h4800);
		DecodeICMatches[70] = ((ic_word & 16'hFE00) == 16'h4A00);
		DecodeICMatches[71] = ((ic_word & 16'hFC00) == 16'h4C00);
		DecodeICMatches[72] = ((ic_word & 16'hFE00) == 16'h5000);
		DecodeICMatches[73] = ((ic_word & 16'hFE00) == 16'h5200);
		DecodeICMatches[74] = ((ic_word & 16'hFE00) == 16'h5400);
		DecodeICMatches[75] = ((ic_word & 16'hFE00) == 16'h5600);
		DecodeICMatches[76] = ((ic_word & 16'hFE00) == 16'h5800);
		DecodeICMatches[77] = ((ic_word & 16'hFE00) == 16'h5A00);
		DecodeICMatches[78] = ((ic_word & 16'hFE00) == 16'h5C00);
		DecodeICMatches[79] = ((ic_word & 16'hFE00) == 16'h5E00);
		DecodeICMatches[80] = ((ic_word & 16'hFE00) == 16'h6000);
		DecodeICMatches[81] = ((ic_word & 16'hFE00) == 16'h6200);
		DecodeICMatches[82] = ((ic_word & 16'hFE00) == 16'h6400);
		DecodeICMatches[83] = ((ic_word & 16'hFE00) == 16'h6600);
		DecodeICMatches[84] = ((ic_word & 16'hFE00) == 16'h6800);
		DecodeICMatches[85] = ((ic_word & 16'hFE00) == 16'h6A00);
		DecodeICMatches[86] = ((ic_word & 16'hFE00) == 16'h6C00);
		DecodeICMatches[87] = ((ic_word & 16'hFE00) == 16'h6E00);
		DecodeICMatches[88] = ((ic_word & 16'hF200) == 16'h7000) |
			((ic_word & 16'h7600) == 16'h7600) |
			((ic_word & 16'hDE00) == 16'h9E00) |
			((ic_word & 16'hF900) == 16'hD800) |
			((ic_word & 16'hF800) == 16'h7000) |
			((ic_word & 16'hFA00) == 16'hD800) |
			((ic_word & 16'hFC00) == 16'hD800);
		DecodeICMatches[89] = ((ic_word & 16'hFE00) == 16'h7A00);
		DecodeICMatches[90] = ((ic_word & 16'hFC00) == 16'h8000);
		DecodeICMatches[91] = ((ic_word & 16'hFC00) == 16'h8400);
		DecodeICMatches[92] = ((ic_word & 16'hFC00) == 16'h8800);
		DecodeICMatches[93] = ((ic_word & 16'hFE00) == 16'h8C00);
		DecodeICMatches[94] = ((ic_word & 16'hFE00) == 16'h8E00);
		DecodeICMatches[95] = ((ic_word & 16'hFC00) == 16'h9000);
		DecodeICMatches[96] = ((ic_word & 16'hFC00) == 16'h9400);
		DecodeICMatches[97] = ((ic_word & 16'hFC00) == 16'h9800);
		DecodeICMatches[98] = ((ic_word & 16'hFE00) == 16'h9C00);
		DecodeICMatches[99] = ((ic_word & 16'hFC00) == 16'hA000);
		DecodeICMatches[100] = ((ic_word & 16'hFC00) == 16'hA400);
		DecodeICMatches[101] = ((ic_word & 16'hFC00) == 16'hA800);
		DecodeICMatches[102] = ((ic_word & 16'hFE00) == 16'hAC00);
		DecodeICMatches[103] = ((ic_word & 16'hFE00) == 16'hAE00);
		DecodeICMatches[104] = ((ic_word & 16'hFC00) == 16'hB000);
		DecodeICMatches[105] = ((ic_word & 16'hFC00) == 16'hB400);
		DecodeICMatches[106] = ((ic_word & 16'hFC00) == 16'hB800);
		DecodeICMatches[107] = ((ic_word & 16'hFE00) == 16'hBC00);
		DecodeICMatches[108] = ((ic_word & 16'hF000) == 16'hC000);
		DecodeICMatches[109] = ((ic_word & 16'hFC00) == 16'hD000);
		DecodeICMatches[110] = ((ic_word & 16'hFD00) == 16'hD400);
		DecodeICMatches[111] = ((ic_word & 16'hFD00) == 16'hD500);
		DecodeICMatches[112] = ((ic_word & 16'hFF00) == 16'hDF00);
		DecodeICMatches[113] = ((ic_word & 16'hFA00) == 16'hE000) |
			((ic_word & 16'hFC00) == 16'hE000);
		DecodeICMatches[114] = ((ic_word & 16'hFE00) == 16'hE600);
		DecodeICMatches[115] = ((ic_word & 16'hFE00) == 16'hE800);
		DecodeICMatches[116] = ((ic_word & 16'hFE00) == 16'hEA00);
		DecodeICMatches[117] = ((ic_word & 16'hFC00) == 16'hEC00);
		DecodeICMatches[118] = ((ic_word & 16'hFE00) == 16'hF000);
		DecodeICMatches[119] = ((ic_word & 16'hFE00) == 16'hF200);
		DecodeICMatches[120] = ((ic_word & 16'hFE00) == 16'hF400);
		DecodeICMatches[121] = ((ic_word & 16'hFE00) == 16'hF800);
		DecodeICMatches[122] = ((ic_word & 16'hFE00) == 16'hFA00);
		DecodeICMatches[123] = ((ic_word & 16'hFE00) == 16'hFC00);
	endfunction

	// Static source-register field captured on the instruction edge.
	function automatic bit [3:0] DecodeICRS(input bit [15:0] ic_word);
		bit upper_field;
		upper_field = ((ic_word & 16'hC000) == 16'h4000) |
			((ic_word & 16'hC000) == 16'h8000) |
			((ic_word & 16'h5000) == 16'h5000) |
			((ic_word & 16'h6000) == 16'h6000);
		DecodeICRS = upper_field ? ic_word[8:5] : ic_word[3:0];
	endfunction
	typedef bit [9:0] ICRFAddress_t;
	function automatic ICRFAddress_t DecodeICRFAddress(input bit [15:0] IC, input bit [4:0] STATE, input bit LINE_GZ);
		DecInstr_t DECI;
		bit [31:0] STATE_OH;

		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		
        STATE_OH = 32'b1 << STATE;
rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		DECI.RD = 0; rd_keep = 4'hf;
		DECI.RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		DECI.R = 0;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		DECI.MMA = 0;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		case (IC[15:12])
			4'b0000:	begin 
				casex (IC[11:8])
					4'b0000:	begin 
						casex (IC[7:4])
							4'b001x:	begin 
								;
							end
							4'b1000:	begin 
								;
								;
								;
								;
							end
							default: ;
						endcase
					end
					
					4'b0001:	begin 
						casex (IC[7:4])



							4'b001x:	begin 
								unique case (1'b1)
								STATE_OH[0]: begin
									;
									;
									;
								end
								default: begin
									;
								end
								endcase
							end
							4'b010x:	begin 
								;
							end
							4'b011x:	begin 
								unique case (1'b1)
								STATE_OH[0]: begin
									;
									;
									;
								end
								default: begin
									;
								end
								endcase
							end
							4'b100x:	begin 
								;
							end
							4'b101x:	begin 
								unique case (1'b1)
								STATE_OH[0]: begin
									;
									;
								end
								STATE_OH[1]: begin
									;
								end
								default: begin
									;
								end
								endcase
							end
							4'b1100:	begin 
								unique case (1'b1)
								STATE_OH[0]: begin	
									DECI.RD = 4'hF; rd_keep = 0;
									;
									;
									;
									;
									;
									;
								end
								STATE_OH[1]: begin	
									;
									;
								end
								STATE_OH[2]: begin
									;
								end
								default: begin
									;
								end
								endcase
							end
							4'b1110:	begin 
								unique case (1'b1)
								STATE_OH[0]: begin	
									DECI.RD = 4'hF; rd_keep = 0;
									;
									;
									;
									;
									;
								end
								default: begin	
									DECI.RD = 4'hF; rd_keep = 0;
									;
									;
								end
								endcase
							end
							default: ;
						endcase
					end
					
					4'b0010:	begin 
						casex (IC[7:4])
							4'b010x,			
							4'b011x,			
							4'b111x:	begin	
								unique case (1'b1) 
								STATE_OH[0]: begin
									;
								end
								default: begin 
									;
									;
								end
								endcase
							end
							4'b100x:	begin 
								unique case (1'b1)
								STATE_OH[0]: begin
									;
								end
								STATE_OH[1]: begin
									;
								end
								STATE_OH[2]: begin
									;
								end
								STATE_OH[3]: begin 
									;
									;
									;
									;
									;
									;
								end
								STATE_OH[4]: begin 
									;
									;
									;
									;
									;
									;
								end
								STATE_OH[5]: begin 
									;
									;
									;
									;
									;
									;
								end
								STATE_OH[6]: begin 
									;
									;
									;
									;
									;
									;
								end
								default: begin 
									;
									;
									;
									;
									;
									;
								end
								endcase
							end
							4'b101x:	begin 
								unique case (1'b1)
								STATE_OH[0]: begin
									;
								end
								default: begin 
									;
									;
									;
									;
									;
									;
								end
								endcase
							end
							4'b110x:	begin 
								unique case (1'b1)
								STATE_OH[0]: begin
									;
								end
								default: begin 
									;
									;
									;
									;
									;
								end
								endcase
							end
							default: ;
						endcase
					end
					
					4'b0011:	begin 
						casex (IC[7:4])
							4'b0000:	begin 
							end
							4'b0010:	begin 
								;
							end
							4'b0100:	begin  
								unique case (1'b1)
								STATE_OH[0]: begin 
									;
									;
								end
								STATE_OH[1]: begin 
									;
									;
									;
								end
								STATE_OH[2]: begin 
									;
									;
								end
								default: begin 
									;
									;
									;
								end
								endcase
							end
							4'b0110:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin
										;
										;
									end
									STATE_OH[1]: begin
										;
									end
									default: begin
										;
									end
								endcase
							end
							
							4'b100x:	begin 
								;
								;
								;
								;
								;
							end
							4'b101x, 		
							4'b110x:	begin 
								;
								;
								;
								;
								;
							end
							4'b111x:	begin 
								;
								;
								;
								;
								;
							end
							default: ;
						endcase
					end
			
					4'b01x1:	begin 
						casex (IC[7:4])
							4'b000x:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin	
										;
										;
										;
										;
										;
										;
										;
									end
									default: begin	
										;
										;
										;
										;
										;
										;
										;
									end
								endcase
							end
							4'b001x:	begin 
								unique case (1'b1)
									default: begin	
										;
										;
										;
										;
										;
										;
										;
									end
								endcase
							end
							4'b01xx:	begin 
								;
							end
							4'b100x:	begin  
								unique case (1'b1)
									STATE_OH[0]: begin 
										;
										;
									end
									default: begin 
										;
										;
										;
									end
								endcase
							end
							4'b101x:	begin  
								unique case (1'b1)
									STATE_OH[0]: begin 
										;
										;
									end
									STATE_OH[1]: begin 
										;
										;
										;
									end
									STATE_OH[2]: begin 
										;
										;
										;
										;
										;
									end
									default: begin 
										;
										;
										;
										;
										;
										;
										;
									end
								endcase
							end
							4'b110x:	begin  
								unique case (1'b1)
									STATE_OH[0]: begin 
										;
										;
									end
									STATE_OH[1]: begin 
										;
										;
										;
									end
									STATE_OH[2]: begin 
										;
										;
									end
									default: begin 
										;
										;
										;
									end
								endcase
							end
							4'b111x:	begin  
								unique case (1'b1)
									STATE_OH[0]: begin 
										;
										;
									end
									STATE_OH[1]: begin
										;
										if (!IC[9]) begin 
											;
											;
										end else begin 
											;
											;
										end
									end
									STATE_OH[2]: begin 
										;
										;
										;
										;
										;
									end
									default: begin 
										;
										;
										;
										;
										;
										;
										;
									end
								endcase
							end
							default: ;
						endcase
					end
			
					4'b1000:	begin 
						casex (IC[7:4])
							4'b0000:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin	
										DECI.RD = 4'hF; rd_keep = 0;
										;
										;
										;
										;
										;
									end
									STATE_OH[1]: begin	
										DECI.RD = 4'hF; rd_keep = 0;
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[2]: begin	
										DECI.RD = 4'hF; rd_keep = 0;
										;
										;
									end
									STATE_OH[3]: begin	
										;
										;
										;
									end
									STATE_OH[4]: begin	
										;
										;
									end
									STATE_OH[5]: begin 
										;
										;
									end
									default: begin
										;
									end
								endcase
							end
							default: ;
						endcase
					end
			
					4'b1001:	begin 
						casex (IC[7:4])
							4'b000x:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin	
										;
										;
									end
									STATE_OH[1]: begin	
										DECI.RD = 4'hF; rd_keep = 0;
										;
										;
										;
										;
										;
									end
									STATE_OH[2]: begin	
										DECI.RD = 4'hF; rd_keep = 0;
										;
										;
									end
									STATE_OH[3]: begin	
										DECI.RD = 4'hF; rd_keep = 0;
										;
										;
										;
										;
										;
									end
									STATE_OH[4]: begin	
										DECI.RD = 4'hF; rd_keep = 0;
										;
										;
									end
									STATE_OH[5]: begin	
										;
										;
									end
									STATE_OH[6]: begin	
										;
										;
									end
									STATE_OH[7]: begin 
										;
										;
									end
									default: begin
										;
									end
								endcase
							end
							4'b001x:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin	
										DECI.RD = 4'hF; rd_keep = 0;
										;
										;
										;
										;
										;
									end
									STATE_OH[1]: begin	
										DECI.RD = 4'hF; rd_keep = 0;
										;
										;
										;
									end
									default: begin
										;
									end
								endcase
							end
							
							4'b0100:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin	
										DECI.RD = 4'hF; rd_keep = 0;
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[1]: begin	
										DECI.RD = 4'hF; rd_keep = 0;
										;
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[2]: begin	
										;
										;
									end
									default: begin
										;
									end
								endcase
							end
							
							4'b011x:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin	
										DECI.RD = 4'hF; rd_keep = 0;
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[1]: begin	
										;
										;
									end
									default: begin
										;
									end
								endcase
							end
							4'b100x:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin
										;
										;
									end
									STATE_OH[1]: begin
										;
										;
									end
									STATE_OH[2]: begin	
										;
										;
										;
										;

										;
									end
									default: begin	
										;
										DECI.MMA = 1;
										;
										;
									end
								endcase
							end
							4'b101x:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin
										;
										;
									end
									STATE_OH[1]: begin
										;
										;
									end
									STATE_OH[2]: begin	
										;
										;
										;
										;
										;
										;
									end
									default: begin
										;
										;
										DECI.MMA = 1;
										;
										;
									end
								endcase
							end
							4'b110x, 		
							4'b111x:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin
										;
										;
									end
									default: begin 
										;
										if (!IC[5])
											;
										else
											;
										;
										;
										;
										;
									end
								endcase
							end
							default: ;
						endcase
					end
			
					4'b1010:	begin 
						casex (IC[7:4])
							4'b011x, 		
							4'b100x:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin 
										;
										;
										;
										;
										;
										;
									end
									default: begin 
										DECI.RS = 4'h4; rs_low_keep = 0; rs_high_keep = 0;
										;
										;
										;
										;
										;
									end
								endcase
							end
							default: ;
						endcase
					end
			
					4'b1011:	begin 
						casex (IC[7:4])
							4'b000x, 		
							4'b010x:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin
										;
										;
									end
									default: begin 
										;
										;
										;
										;
										;
										;
									end
								endcase
							end
							4'b001x, 		
							4'b011x:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin
										;
										;
									end
									default: begin 
										;
										;
										;
										;
										;
										;
									end
								endcase
							end






























							4'b100x, 		
							4'b101x, 		
							4'b110x:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin
										;
										;
									end
									default: begin 
										;
										;
										;
										;
										;
										;
									end
								endcase
							end
































							4'b111x:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin
										;
										;
									end
									default: begin 
										;
										;
										;
										;
										;
										;
									end
								endcase
							end
						endcase
					end
			
					4'b1100:	begin 
						casex (IC[7:4])
							4'b000x:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin
										;
										;
									end
									default: begin 
										;
										;
										;
										;
										;
										;
									end
								endcase
							end
							4'b0101:	begin
							
							end
							default: ;
						endcase
					end
			
					4'b1101:	begin 
						casex (IC[7:4])
							4'b000x:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin
										;
										;
									end
									default: begin 
										;
										;
										;
										;
										;
										;
									end
								endcase
							end
							4'b0011:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin	
										DECI.RD = 4'hF; rd_keep = 0;
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[1]: begin	
										DECI.RD = 4'hF; rd_keep = 0;
										;
										;
										;
									end
									default: begin
										;
									end
								endcase
							end
							4'b0101:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin	
										DECI.RD = 4'hF; rd_keep = 0;
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[1]: begin	
										DECI.RD = 4'hF; rd_keep = 0;
										;
										;
										;
									end
									default: begin
										;
									end
								endcase
							end
							
							4'b0110:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin
										;
										;
									end
									STATE_OH[1]: ;
									default: ;
								endcase
							end
							
							4'b100x:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin	
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[1]: begin	
										;
										;
										;
									end
									default: begin
										;
									end
								endcase
							end
							4'b101x:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin	
										;
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[1]: begin	
										;
										;
										;
									end
									default: begin
										;
									end
								endcase
							end
							4'b110x:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin	
										;
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[1]: begin	
										;
										;
										;
									end
									default: begin
										;
									end
								endcase
							end
							
							4'b1110:	begin 
								;
								;
							end
							
							default: ;
						endcase
					end
					
					4'b1111:	begin 
						casex (IC[7:4])
							4'b00x0:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin 
										DECI.RD = 4'd7; rd_keep = 0;
										DECI.RS = 4'd7; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
									end
									STATE_OH[1]: begin 
										DECI.RD = 4'd14; rd_keep = 0;
										DECI.RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
									end
									STATE_OH[2]: begin 
										DECI.RD = 4'd14; rd_keep = 0;
										DECI.RS = 4'd7; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;

										;
									end
									STATE_OH[3]: begin 
										DECI.RD = 4'd14; rd_keep = 0;
										DECI.RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
									end
									STATE_OH[4]: begin 
										DECI.RD = 4'd7; rd_keep = 0;
										DECI.RS = 4'd7; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
									end
									STATE_OH[5]: begin 
										DECI.RD = 4'd14; rd_keep = 0;
										DECI.RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;

										;
									end
									STATE_OH[6]: begin  
										DECI.RD = 4'd0; rd_keep = 0;
										DECI.RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[7]: begin 
										DECI.RD = 4'd2; rd_keep = 0;
										DECI.RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;
									end
									STATE_OH[8]: begin 
										DECI.RD = 4'd14; rd_keep = 0;
										DECI.RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;

										;
									end
									STATE_OH[9]: begin 
										DECI.RD = 4'd0; rd_keep = 0;
										DECI.RS = 4'd1; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
									end
									STATE_OH[10]: begin  
										DECI.RD = 4'd2; rd_keep = 0;
										DECI.RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[11]: begin 
										DECI.RD = 4'd2; rd_keep = 0;
										DECI.RS = 4'd4; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;
									end
									STATE_OH[12]: begin 
										DECI.RD = 4'd2; rd_keep = 0;
										DECI.RS = 4'd3; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;

										;
									end
									STATE_OH[13]: begin 
										DECI.RD = 4'd2; rd_keep = 0;
										DECI.RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
									end
									STATE_OH[14]: begin	
										DECI.RD = 4'd0; rd_keep = 0;

										DECI.R = 1;
										;
										;
										;
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[15]: begin 
										;
									end
									STATE_OH[16]: begin	
										DECI.RD = 4'd14; rd_keep = 0;
										DECI.RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[17]: begin	
										;
									end 
									STATE_OH[18]: begin	
										DECI.RD = 4'd2; rd_keep = 0;

										DECI.R = 1;
										;
										;
										;
										;
										;
										;
										;
										;
										;
										;
										;
									end 
									STATE_OH[19]: begin 
										DECI.RD = 4'd0; rd_keep = 0;
										DECI.RS = 4'd1; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;
										;
										;
									end
									default: begin	
										DECI.RD = 4'd2; rd_keep = 0;
										DECI.RS = 4'd3; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;
										;
										;
										;
									end
								endcase
							end
							
							4'b10x0:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin 
										DECI.RD = 4'd7; rd_keep = 0;
										DECI.RS = 4'd7; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
									end
									STATE_OH[1]: begin 
										DECI.RD = 4'd14; rd_keep = 0;
										DECI.RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
									end
									STATE_OH[2]: begin 
										DECI.RD = 4'd14; rd_keep = 0;
										DECI.RS = 4'd7; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;

										;
									end
									STATE_OH[3]: begin 
										DECI.RD = 4'd14; rd_keep = 0;
										DECI.RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
									end
									STATE_OH[4]: begin 
										DECI.RD = 4'd7; rd_keep = 0;
										DECI.RS = 4'd7; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
									end
									STATE_OH[5]: begin 
										DECI.RD = 4'd14; rd_keep = 0;
										DECI.RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;

										;
									end
									STATE_OH[6]: begin  
										DECI.RD = 4'd0; rd_keep = 0;
										DECI.RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[7]: begin 
										DECI.RD = 4'd2; rd_keep = 0;
										DECI.RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;

										;
										;
									end
									STATE_OH[8]: begin 
										DECI.RD = 4'd14; rd_keep = 0;
										DECI.RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;

										;
									end
									STATE_OH[9]: begin 
										DECI.RD = 4'd0; rd_keep = 0;
										DECI.RS = 4'd1; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
									end
									STATE_OH[10]: begin  
										DECI.RD = 4'd2; rd_keep = 0;
										DECI.RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[11]: begin 
										DECI.RD = 4'd2; rd_keep = 0;
										DECI.RS = 4'd4; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;
									end
									STATE_OH[12]: begin 
										DECI.RD = 4'd2; rd_keep = 0;
										DECI.RS = 4'd3; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[13]: begin 
										DECI.RD = 4'd2; rd_keep = 0;
										DECI.RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
									end
									STATE_OH[14]: begin	
										DECI.RD = 4'd0; rd_keep = 0;
										DECI.RS = 4'd0; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;
										;
										;

										;
									end
									STATE_OH[15]: begin	
										;
										;
									end
									STATE_OH[16]: begin	
										DECI.RD = 4'd14; rd_keep = 0;

										DECI.R = 1;
										;
										;
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[17]: begin	
										;
									end 
									STATE_OH[18]: begin	
										DECI.RD = 4'd2; rd_keep = 0;

										DECI.R = 1;
										;
										;
										;
										;
										;
										;
										;
										;
										;
										;
										;
									end 
									STATE_OH[19]: begin 
										DECI.RD = 4'd0; rd_keep = 0;
										DECI.RS = 4'd1; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;
										;
										;
									end
									default: begin	
										DECI.RD = 4'd2; rd_keep = 0;
										DECI.RS = 4'd3; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;
										;
										;
										;
									end
								endcase
							end
								
							4'b11x0:	begin 
								unique case (1'b1)
									STATE_OH[0]: begin 
										DECI.RD = 4'd7; rd_keep = 0;
										DECI.RS = 4'd7; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
									end
									STATE_OH[1]: begin 
										DECI.RD = 4'd14; rd_keep = 0;
										DECI.RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
									end
									STATE_OH[2]: begin 
										DECI.RD = 4'd14; rd_keep = 0;
										DECI.RS = 4'd7; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;

										;
									end
									STATE_OH[3]: begin 
										DECI.RD = 4'd14; rd_keep = 0;
										DECI.RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
									end
									STATE_OH[4]: begin 
										DECI.RD = 4'd7; rd_keep = 0;
										DECI.RS = 4'd7; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
									end
									STATE_OH[5]: begin 
										DECI.RD = 4'd14; rd_keep = 0;
										DECI.RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;

										;
									end
									STATE_OH[6]: begin  
										DECI.RD = 4'd0; rd_keep = 0;
										DECI.RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[7]: begin 
										DECI.RD = 4'd2; rd_keep = 0;
										DECI.RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;

										;
										;
									end
									STATE_OH[8]: begin 
										DECI.RD = 4'd14; rd_keep = 0;
										DECI.RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;

										;
									end
									STATE_OH[9]: begin 
										DECI.RD = 4'd0; rd_keep = 0;
										DECI.RS = 4'd1; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
									end
									STATE_OH[10]: begin  
										DECI.RD = 4'd2; rd_keep = 0;
										DECI.RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[11]: begin 
										DECI.RD = 4'd2; rd_keep = 0;
										DECI.RS = 4'd4; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;
									end
									STATE_OH[12]: begin 
										DECI.RD = 4'd2; rd_keep = 0;
										DECI.RS = 4'd3; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[13]: begin 
										DECI.RD = 4'd2; rd_keep = 0;
										DECI.RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
									end
									STATE_OH[14]: begin	
										;
										;
									end 
									STATE_OH[15]: begin	
										;
									end 
									STATE_OH[16]: begin	
										DECI.RD = 4'd14; rd_keep = 0;
										DECI.RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;
										;
										;
										;
									end
									STATE_OH[17]: begin	
										;
									end 
									STATE_OH[18]: begin	
										DECI.RD = 4'd2; rd_keep = 0;

										DECI.R = 1;
										;
										;
										;
										;
										;
										;
										;
										;
										;
										;
										;
									end 
									STATE_OH[19]: begin 
										;
									end
									default: begin	
										DECI.RD = 4'd2; rd_keep = 0;
										DECI.RS = 4'd3; rs_low_keep = 0; rs_high_keep = 0;
										DECI.R = 1;
										;
										;
										;
										;
										;
										;
										;
										;
									end
								endcase
							end
							default: ;
						endcase
					end
							
					default: ;
				endcase
			end
			
			4'b0001:	begin 
				casex (IC[11:8])
					4'b00xx:	begin  
						;
						;
						;
						;
						;
					end
					4'b01xx:	begin  
						;
						;
						;
						;
						;
					end
					4'b10xx:	begin  
						;
						;
						;
						;
					end
					4'b11xx:	begin  
						;
						;
						;
						;
					end
				endcase
			end
			
			4'b0010:	begin 
				casex (IC[11:8])
					4'b00xx:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin	
								;
							end
							STATE_OH[1]: begin 
								;
							end
							default: begin
								;
								;
								;
								;
								;
								;
								;
							end
						endcase
					end
					4'b01xx:	begin  
						unique case (1'b1)
							default: begin
								;
								;
								;
								;
								;
								;
							end
						endcase
					end
					4'b10xx:	begin  
						unique case (1'b1)
							default: begin
								;
								;
								;
								;
								;
								;
							end
						endcase
					end
					4'b11xx:	begin  
						unique case (1'b1)
							default: begin
								;
								;
								;
								;
								;
								;
							end
						endcase
					end
				endcase
			end
			
			4'b0011:	begin 
				casex (IC[11:8])
					4'b00xx:	begin  
						unique case (1'b1)
							default: begin
								;
								;
								;
								;
								;
								;
							end
						endcase
					end
					4'b01xx:	begin  
						unique case (1'b1)
							default: begin
								;
								;
								;
								;
							end
						endcase
					end
					4'b1xxx:	begin 
						unique case (1'b1)
							STATE_OH[0]: begin	
								;
								;
								;
								;
								;
							end
							STATE_OH[1]: begin	
								;
								;
								;
							end
							default: begin
								;
							end
						endcase
					end
					default: ;
				endcase
			end
			
			4'b0100:	begin 
				DECI.RS = 0; rs_low_keep = 0; rs_high_keep = 4'hf;
				casex (IC[11:8])
					4'b000x:	begin  
						;
						;
						;
					end
					4'b001x:	begin  
						;
						;
						;
					end
					4'b010x:	begin  
						;
						;
						;
						;
						;
					end
					4'b011x:	begin  
						;
						;
						;
						;
						;
					end
					4'b100x:	begin  
						;
						;
						;
						;
					end
					4'b101x:	begin  
						;
						;
						;
						;
					end
					4'b11xx:	begin  
						;
						;
						;
						;
						;
						;
					end
					default: ;
				endcase
			end
			
			4'b0101:	begin 
				DECI.RS = 0; rs_low_keep = 0; rs_high_keep = 4'hf;
				casex (IC[11:8])
					4'b000x:	begin  
						;
						;
						;
						;
						;
					end
					4'b001x:	begin  
						;
						;
						;
						;
						;
					end
					4'b010x:	begin  
						;
						;
						;
						;
						;
					end
					4'b011x:	begin  
						;
						;
						;
						;
						;
					end
					4'b100x:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin	
								DECI.RD = 4'h1; rd_keep = 4'he;
								;
								;
								;
								;
								;
								;
							end
							STATE_OH[1]: begin	
								;
								;
								;
								;
								;
							end
							STATE_OH[2]: begin	
								;
								;
								;
							end
							STATE_OH[3]: begin	
								;
								;
								;
								;
								;
							end
							STATE_OH[4]: begin	
								;
								;
								;
								;
							end
							STATE_OH[5]: begin	
								;
								;
								;
								;
							end
							STATE_OH[6]: begin 
								DECI.RD = 4'h1; rd_keep = 4'he;
								;
								;
								;
								;
								;
								;
							end
							default: begin 
								;
								;
								;
								;
								;
								;
								;
							end
						endcase
					end
					4'b101x:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin	
								DECI.RD = 4'h1; rd_keep = 4'he;
								;
								;
								;
								;
								;
								;
							end
							STATE_OH[1]: begin	
								;
								;
								;
								;
								;
							end
							STATE_OH[2]: begin	
								;
								;
								;
							end
							STATE_OH[3]: begin	
								;
								;
								;
								;
								;
							end
							STATE_OH[4]: begin	
								;
								;
								;
								;
							end
							STATE_OH[5]: begin	
								;
								;
								;
								;
							end
							STATE_OH[6]: begin 
								DECI.RD = 4'h1; rd_keep = 4'he;
								;
								;
								;
								;
								;
								;
							end
							default: begin 
								;
								;
								;
								;
								;
								;
								;
							end
						endcase
					end
					4'b110x:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin	
								;
								;
								;
							end
							STATE_OH[1]: begin	
								;
								;
								;
								;
								;
								;
								;
							end
							STATE_OH[2]: begin	
								;
								;
								;
								;
								;
								;
							end
							STATE_OH[3]: begin	
								;
								;
								;
							end
							STATE_OH[4]: begin	
								;
								;
								;
							end
							STATE_OH[5]: begin 
								DECI.RD = 4'h1; rd_keep = 4'he;
								;
								;
								;
								;
								;
								;
								;
								;
								;
							end
							default: begin	
								;
								;
								;
								;
								;
								;
								;
								;
							end
						endcase
					end
					4'b111x:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin	
								;
								;
								;
							end
							STATE_OH[1]: begin	
								;
								;
								;
								;
								;
								;
								;
							end
							STATE_OH[2]: begin	
								;
								;
								;
								;
								;
								;
							end
							STATE_OH[3]: begin	
								;
								;
								;
							end
							STATE_OH[4]: begin	
								;
								;
								;
							end
							STATE_OH[5]: begin 
								DECI.RD = 4'h1; rd_keep = 4'he;
								;
								;
								;
								;
								;
								;
								;
								;
								;
							end
							default: begin	
								;
								;
								;
								;
								;
								;
								;
								;
							end
						endcase
					end
					default: ;
				endcase
			end
			
			4'b0110:	begin 
				DECI.RS = 0; rs_low_keep = 0; rs_high_keep = 4'hf;
				casex (IC[11:8])
					4'b000x:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin	
								;
							end
							STATE_OH[1]: begin 
								;
							end
							default: begin
								;
								;
								;
								;
							end
						endcase
					end
					4'b001x:	begin  
						;
						;
						;
						;
					end
					4'b010x:	begin  
						;
						;
						;
						;
					end
					4'b011x:	begin  
						;
						;
						;
						;
					end
					4'b100x:	begin  
						;
						;
						;
						;
					end
					4'b101x:	begin  
						;
						;
						;
					end
					4'b110x:	begin	
						unique case (1'b1)
							STATE_OH[0]: begin	
								DECI.RD = 0; rd_keep = 4'hf;
								;
								;
								;
								;
								;
								;
							end
							STATE_OH[1]: begin	
								;
								;
								;
								;
								;
							end
							STATE_OH[2]: begin	
								;
								;
								;
							end
							STATE_OH[3]: begin	
								;
								;
								;
								;
								;
							end
							STATE_OH[4]: begin	
								;
								;
								;
								;
							end
							STATE_OH[5]: begin	
								;
								;
								;
							end
							default: begin 
								;
								;
								;
								;
								;
								;
								;
							end
						endcase
					end
					4'b111x:	begin	
						unique case (1'b1)
							STATE_OH[0]: begin	
								;
								;
								;
								;
								;
								;
							end
							STATE_OH[1]: begin	
								;
								;
							end
							STATE_OH[2]: begin	
								;
								;
								;
							end
							STATE_OH[3]: begin	
								;
								;
								;
								;
								;
							end
							STATE_OH[4]: begin	
								;
								;
								;
								;
							end
							STATE_OH[5]: begin	
								;
								;
								;
							end
							default: begin 
								;
								;
								;
								;
								;
								;
								;
							end
						endcase;
					end
					default: ;
				endcase
			end
			
			4'b0111:	begin 
				DECI.RS = 0; rs_low_keep = 0; rs_high_keep = 4'hf;
				casex (IC[11:8])
					4'b101x:	begin  
						;
						;
						;
					end



					default: ;
				endcase
			end
			
			4'b1000:	begin 
				DECI.RS = 0; rs_low_keep = 0; rs_high_keep = 4'hf;
				casex (IC[11:8])
					4'b00xx:	begin  
						unique case (1'b1)
							default: begin 
								;
								;
								;
							end
						endcase
					end
					4'b01xx:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
								;
							end
							STATE_OH[1]: begin 
								;
								;
								;
								;
								;
							end
							default: begin 
								;
								;
								;
								;
								;
								;
								;
							end
						endcase
					end
					4'b10xx:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
								;
							end
							default: begin 
								;
								;
								;
							end
						endcase
					end
					4'b110x:	begin  
						unique case (1'b1)
							default: begin 
								;
								;
								;
							end
						endcase
					end
					4'b111x:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
								;
							end
							STATE_OH[1]: begin 
								;
								;
								;
								;
								;
							end
							default: begin 
								;
								;
								;
								;
								;
								;
								;
							end
						endcase
					end
					default: ;
				endcase
			end
			
			4'b1001:	begin 
				DECI.RS = 0; rs_low_keep = 0; rs_high_keep = 4'hf;
				casex (IC[11:8])
					4'b00xx:	begin  
						unique case (1'b1)
							default: begin 
								;
								;
								;
								;
								;
								;
							end
						endcase
					end
					4'b01xx:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
								;
								;
								;
								;
								;
							end
							STATE_OH[1]: begin 
								;
								;
								;
								;
								;
							end
							default: begin 
								;
								;
								;
								;
								;
								;
								;
							end
						endcase
					end
					4'b10xx:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
								;
								;
								;
								;
								;
							end
							default: begin 
								;
								;
								;
								;
								;
								;
								;
							end
						endcase
					end
					4'b110x:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
								;
							end
							default: begin 
								;
								;
								;
							end
						endcase
					end
					default: ;
				endcase
			end
			
			4'b1010:	begin
				DECI.RS = 0; rs_low_keep = 0; rs_high_keep = 4'hf;
				casex (IC[11:8])
					4'b00xx:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
								;
								;
								;
								;
							end
							default: begin 
								;
								;
								;
							end
						endcase
					end
					4'b01xx:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
								;
								;
								;
								;
							end
							STATE_OH[1]: begin 
								;
								;
								;
							end
							STATE_OH[2]: begin 
								;
								;
								;
								;
								;
							end
							default: begin 
								;
								;
								;
								;
								;
								;
								;
							end
						endcase
					end
					4'b10xx:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
								;
								;
								;
								;
							end
							STATE_OH[1]: begin 
								;
								;
								;
								;
								;
								;
								;
							end
							default: begin 
								;
								;
								;
							end
						endcase
					end
					4'b110x:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
							end
							default: begin 
								;
								;
								;
							end
						endcase
					end
					4'b111x:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
							end
							STATE_OH[1]: begin 
								;
								;
								;
							end
							STATE_OH[2]: begin 
								;
								;
								;
								;
								;
							end
							default: begin 
								;
								;
								;
								;
								;
								;
								;
							end
						endcase
					end
					default: ;
				endcase
			end
			
			4'b1011:	begin
				DECI.RS = 0; rs_low_keep = 0; rs_high_keep = 4'hf;
				casex (IC[11:8])
					4'b00xx:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
							end
							default: begin 
								;
								;
								;
							end
						endcase
					end
					4'b01xx:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
							end
							STATE_OH[1]: begin 
								;
								;
								;
							end
							STATE_OH[2]: begin 
								;
								;
								;
								;
								;
							end
							default: begin 
								;
								;
								;
								;
								;
								;
								;
							end
						endcase
					end
					4'b10xx:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
							end
							STATE_OH[1]: begin 
								;
								;
								;
							end
							STATE_OH[2]: begin 
								;
								;
							end
							default: begin 
								;
								;
								;
							end
						endcase
					end
					4'b110x:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
							end
							STATE_OH[1]: begin 
								;
								;
								;
							end
							STATE_OH[2]: begin 
								;
								;
							end
							default: begin 
								;
								;
								;
							end
						endcase
					end
					default: ;
				endcase
			end
			
			4'b1100:	begin  
				casex (IC[7:0])
					8'bx0000000: begin
						unique case (1'b1)
							STATE_OH[0]: begin
								;
								;
							end
							STATE_OH[1]: begin
								;
								;
								;
							end
							default: begin
								;
							end
						endcase
					end
					default: begin
						unique case (1'b1)
							STATE_OH[0]: begin
								;
								;
								;
							end
							default: begin
								;
							end
						endcase
					end
				endcase
			end
			
			4'b1101:	begin
				DECI.RS = 0; rs_low_keep = 0; rs_high_keep = 4'hf;
				casex (IC[11:8])
					4'b00xx:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
							end
							STATE_OH[1]: begin 
								;
								;
								;
							end
							default: begin 
								;
								;
								;
								;
								;
								;
								;
							end
						endcase
					end
					4'b01x0:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
							end
							STATE_OH[1]: begin 
								;
								;
								;
							end
							default: begin 
								;
								;
								;
								;
								;
								;
								;
							end
						endcase
					end
					4'b01x1:	begin  
						unique case (1'b1)
							default: begin 
								;
								;
								;
								;
								;
								;
							end
						endcase
					end















					
					4'b1111:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								DECI.RD = 4'd7; rd_keep = 0;
								DECI.RS = 4'd7; rs_low_keep = 0; rs_high_keep = 0;
								DECI.R = 1;
								;
								;
								;
								;
								;
							end
							STATE_OH[1]: begin 
								DECI.RD = 4'd14; rd_keep = 0;
								DECI.RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
								DECI.R = 1;
								;
								;
								;
								;
								;
								;
								;
							end
							STATE_OH[2]: begin  
								DECI.RD = 4'd2; rd_keep = 0;
								DECI.RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
								DECI.R = 1;
								;
								;
								;
								;
								;
								;
							end
							STATE_OH[3]: begin 
								DECI.RD = 4'd2; rd_keep = 0;
								DECI.RS = 4'd4; rs_low_keep = 0; rs_high_keep = 0;
								DECI.R = 1;
								;
								;
								;
								;
								;
							end
							STATE_OH[4]: begin 
								DECI.RD = 4'd0; rd_keep = 0;
								DECI.RS = 4'd0; rs_low_keep = 0; rs_high_keep = 0;
								DECI.R = 1;
								;
								;
								;
								;
								;
							end
							STATE_OH[5]: begin	
								DECI.RD = 4'd10; rd_keep = 0;
								DECI.RS = 'd10; rs_low_keep = 0; rs_high_keep = 0;
								DECI.R = 1;
								;
								;
								;
								;
								;
							end
							STATE_OH[6]: begin	
								DECI.RD = 4'd14; rd_keep = 0;
								DECI.RS = LINE_GZ ? 4'd11 : 4'd12; rs_low_keep = 0; rs_high_keep = 0;
								DECI.R = 1;
								;
								;
								;

								;
								;
								;
							end
							STATE_OH[7]: begin	
								;
							end 
							STATE_OH[8]: begin	
								DECI.RD = 4'd2; rd_keep = 0;
								DECI.R = 1;
								;
								;
								;
								;
								;

								;
								;
								;
							end 
							STATE_OH[9]: begin	
								DECI.RD = 4'd2; rd_keep = 0;
								DECI.RS = LINE_GZ ? 4'd11 : 4'd12; rs_low_keep = 0; rs_high_keep = 0;
								DECI.R = 1;
								;
								;
								;
								;

								;
								;
							end 
							default: begin	
								DECI.RD = 4'd0; rd_keep = 0;
								DECI.RS = 4'd0; rs_low_keep = 0; rs_high_keep = 0;
								DECI.R = 1;
								;
								;
								;
								;
								;
								;
								;
								;
							end	
						endcase
					end
					default: ;
				endcase
			end
			
			4'b1110:	begin 
				DECI.RS = 0; rs_low_keep = 0; rs_high_keep = 4'hf;
				casex (IC[11:8])
					4'b000x,  		
					4'b001x, 		
					4'b010x:	begin 
						unique case (1'b1)
							default: begin 
								;
								;
								;
								;
								;
							end
						endcase
					end










					4'b011x:	begin  
						unique case (1'b1)
							default: begin 
								;
								;
								;
								;
								;
							end
						endcase
					end
					
					4'b100x:	begin 
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
							end
							STATE_OH[1]: begin 
								;
								;
								;
								;
								;
								;
							end
							default: begin 
								DECI.RS = 4'd4; rs_low_keep = 0; rs_high_keep = 0;
								;
								;
								;
								;
								;
							end
						endcase
					end
					4'b101x:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								DECI.RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
								;
								;
								;
								;
								;
								;
							end
							default: begin 
								;
								;
								;
								;
								;
							end
						endcase
					end
					4'b110x,  		
					4'b111x:	begin	
						unique case (1'b1)
							default: begin 
								;
								;
								;
								;
								;
							end
						endcase
					end
					default: ;
				endcase
			end
			
			4'b1111:	begin 
				DECI.RS = 0; rs_low_keep = 0; rs_high_keep = 4'hf;
				casex (IC[11:8])
					4'b000x:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
								;
								;
								;
								;
							end
							STATE_OH[1]: begin 
								DECI.RS = 4'd4; rs_low_keep = 0; rs_high_keep = 0;
								;
								;
								;
								;
								;
							end
							default: begin 
								;
								;
								;
								;
							end
						endcase
					end
					4'b001x:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
								;
								;
								;
								;
							end
							STATE_OH[1]: begin 
								DECI.RD = 4'd4; rd_keep = 0;
								;
								;
								;
								;
								;
							end
							STATE_OH[2]: begin 
								;
								;
								;
							end
							default: begin 
								;
								;
								;
								;
							end
						endcase
					end
					4'b010x:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
								;
								;
								;
								;
							end
							STATE_OH[1]: begin 
								DECI.RD = 4'd4; rd_keep = 0;
								;
								;
								;
								;
								;
							end
							STATE_OH[2]: begin 
								;
								;
								;
								;
								;
								;
							end
							STATE_OH[3]: begin 
								DECI.RS = 4'd4; rs_low_keep = 0; rs_high_keep = 0;
								;
								;
								;
								;
								;
							end
							STATE_OH[4]: begin 
								;
								;
								;
							end
							default: begin 
								;
								;
								;
								;
							end
						endcase
					end
					
					4'b100x:	begin  
						unique case (1'b1)
							default: begin 
								;
								;
								;
								;
							end
						endcase
					end
					4'b101x:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
								;
							end
							default: begin 
								;
								;
								;
								;
							end
						endcase
					end
					4'b110x:	begin  
						unique case (1'b1)
							STATE_OH[0]: begin 
								;
								;
								;
							end
							default: begin 
								;
								;
								;
								;
							end
						endcase
					end
					default: ;
				endcase
			end
			
			default: ;
		endcase
		
		DECI.R = DECI.R | IC[4];
		DECI.RD = DECI.RD | (IC[3:0] & rd_keep);
		DECI.RS = DECI.RS | (IC[3:0] & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// The XY window clip microcycle reads B14 as its far corner through RS.
		if (STATE == 5'd4 &&
		    (((IC & 16'hFFD0) == 16'h0F00) ||
		     ((IC & 16'hFFD0) == 16'h0F80) ||
		     ((IC & 16'hFFD0) == 16'h0FC0))) begin
			DECI.R = 1'b1;
			DECI.RS = 4'd14;
		end
		
		
		DECI.MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	
		DecodeICRFAddress = {DECI.MMA,DECI.R,DECI.RD,DECI.RS};
	endfunction

endpackage
