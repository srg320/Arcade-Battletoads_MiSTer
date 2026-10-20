import TMS34020_PKG::*;

module TMS34020_ID
 #(parameter bit OPSEL_REG = 1'b0)
 (
	input              CLK,
	input              RST_N,
	input              EN,
	
	input              CE_F,
	input              CE_R,
	
	input      [15: 0] IC,
	input ICMatches_t IC_MATCHES,
	input bit [3:0] IC_RS_STATIC,
	input ICRFAddress_t IC_RF_ADDR,
	input ICRFAddress_t IC_RF_ADDR_POS,
	input OpSel_t OPSEL,
	input      [ 4: 0] STATE,
	input      [31: 0] STATE_OH,
	input              MD_COND,
	input              MD_NEG,
	input              DIV_V,
	input              J_COND,
	input              DS_COND,
	input              MM_COND,
	input              FE0,
	input              FE1,
	input              RP_COND,
	input              LINE_GZ,
	input              LINE_COND,
	input              PIX_XEND,
	input              PIX_YEND,
	input              PIX_WINEN,
	input      [ 3: 0] PIX_WINCC,
	input              PIX_BL,
	input              PIX_WE,
	
	output DecInstr_t  DECI,
	// DECI.MC.AT before the PIX_WE gate on the bitmap-write microcycle: the READ
	// decision does not depend on PIX_WE (only MA_WRITE becomes MA_NONE).
	output MemAccess_t DECI_AT_PRE,
	// Operand-select fields as decoded combinationally from (IC,STATE).
	output OpSel_t OPSEL_COMB,
	input              MD_DIVIDEND_NEG
);
	
	
	DecInstr_t CLASS_DECI[124];

	DecInstr_t BASE_DECI, CLASS_DELTA;

	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		BASE_DECI.RD = 0; rd_keep = 4'hf;
		BASE_DECI.RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		BASE_DECI.R = 0;
		BASE_DECI.M = 0;
		BASE_DECI.F = IC[9];
		BASE_DECI.AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		BASE_DECI.AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		BASE_DECI.FT = '{FSI_32, 1'b0};
		BASE_DECI.ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		BASE_DECI.SHC = '{SS_NONE, 3'b000};
		BASE_DECI.MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		BASE_DECI.IWL = IW_NONE;
		BASE_DECI.MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		BASE_DECI.MMS = 0;
		BASE_DECI.MMA = 0;
		BASE_DECI.RWA = '{RS_REGA, 1'b0};
		BASE_DECI.RWB = '{RS_REGA, 1'b0};
		BASE_DECI.JC = JC_NONE;
		BASE_DECI.PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		BASE_DECI.PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		BASE_DECI.PIXO = '{PATS_NULL};
		BASE_DECI.STW = {STU_NONE, 4'b0000};
		BASE_DECI.PCS = PCS_NONE;
		BASE_DECI.PCW = 1;
		BASE_DECI.NST = STATE + 5'd1;
		BASE_DECI.LST = 1;
		BASE_DECI.ILI = 0;
		

		// Keep instruction operand bits out of the microcode priority muxes.
		BASE_DECI.R = BASE_DECI.R | IC[4];
		BASE_DECI.RD = BASE_DECI.RD | (IC[3:0] & rd_keep);
		BASE_DECI.RS = BASE_DECI.RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		BASE_DECI.MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 0.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[0].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[0].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[0].R = 0;
		CLASS_DECI[0].M = 0;
		CLASS_DECI[0].F = IC[9];
		CLASS_DECI[0].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[0].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[0].FT = '{FSI_32, 1'b0};
		CLASS_DECI[0].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[0].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[0].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[0].IWL = IW_NONE;
		CLASS_DECI[0].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[0].MMS = 0;
		CLASS_DECI[0].MMA = 0;
		CLASS_DECI[0].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[0].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[0].JC = JC_NONE;
		CLASS_DECI[0].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[0].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[0].PIXO = '{PATS_NULL};
		CLASS_DECI[0].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[0].PCS = PCS_NONE;
		CLASS_DECI[0].PCW = 1;
		CLASS_DECI[0].NST = STATE + 5'd1;
		CLASS_DECI[0].LST = 1;
		CLASS_DECI[0].ILI = 0;
		
begin
begin
CLASS_DECI[0].ILI = 1;
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[0].R = CLASS_DECI[0].R | IC[4];
		CLASS_DECI[0].RD = CLASS_DECI[0].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[0].RS = CLASS_DECI[0].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[0].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 1.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[1].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[1].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[1].R = 0;
		CLASS_DECI[1].M = 0;
		CLASS_DECI[1].F = IC[9];
		CLASS_DECI[1].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[1].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[1].FT = '{FSI_32, 1'b0};
		CLASS_DECI[1].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[1].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[1].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[1].IWL = IW_NONE;
		CLASS_DECI[1].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[1].MMS = 0;
		CLASS_DECI[1].MMA = 0;
		CLASS_DECI[1].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[1].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[1].JC = JC_NONE;
		CLASS_DECI[1].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[1].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[1].PIXO = '{PATS_NULL};
		CLASS_DECI[1].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[1].PCS = PCS_NONE;
		CLASS_DECI[1].PCW = 1;
		CLASS_DECI[1].NST = STATE + 5'd1;
		CLASS_DECI[1].LST = 1;
		CLASS_DECI[1].ILI = 0;
		
begin
begin
begin //REV Rd (REV->Rd)
CLASS_DECI[1].RWA = '{RS_REV, 1'b1};
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[1].R = CLASS_DECI[1].R | IC[4];
		CLASS_DECI[1].RD = CLASS_DECI[1].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[1].RS = CLASS_DECI[1].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[1].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 2.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[2].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[2].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[2].R = 0;
		CLASS_DECI[2].M = 0;
		CLASS_DECI[2].F = IC[9];
		CLASS_DECI[2].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[2].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[2].FT = '{FSI_32, 1'b0};
		CLASS_DECI[2].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[2].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[2].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[2].IWL = IW_NONE;
		CLASS_DECI[2].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[2].MMS = 0;
		CLASS_DECI[2].MMA = 0;
		CLASS_DECI[2].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[2].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[2].JC = JC_NONE;
		CLASS_DECI[2].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[2].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[2].PIXO = '{PATS_NULL};
		CLASS_DECI[2].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[2].PCS = PCS_NONE;
		CLASS_DECI[2].PCW = 1;
		CLASS_DECI[2].NST = STATE + 5'd1;
		CLASS_DECI[2].LST = 1;
		CLASS_DECI[2].ILI = 0;
		
begin
begin
begin //MWAIT	(*Rd)
CLASS_DECI[2].AIA = '{IMM_K, CV_0, AS_IMM, EO_NONE};
CLASS_DECI[2].AIB = '{IMM_K, CV_0, AS_IMM, EO_NONE};
CLASS_DECI[2].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[2].MC = '{MAS_RA, MDS_REGA, MA_READ, MT_DATA};
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[2].R = CLASS_DECI[2].R | IC[4];
		CLASS_DECI[2].RD = CLASS_DECI[2].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[2].RS = CLASS_DECI[2].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[2].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 3.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[3].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[3].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[3].R = 0;
		CLASS_DECI[3].M = 0;
		CLASS_DECI[3].F = IC[9];
		CLASS_DECI[3].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[3].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[3].FT = '{FSI_32, 1'b0};
		CLASS_DECI[3].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[3].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[3].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[3].IWL = IW_NONE;
		CLASS_DECI[3].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[3].MMS = 0;
		CLASS_DECI[3].MMA = 0;
		CLASS_DECI[3].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[3].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[3].JC = JC_NONE;
		CLASS_DECI[3].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[3].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[3].PIXO = '{PATS_NULL};
		CLASS_DECI[3].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[3].PCS = PCS_NONE;
		CLASS_DECI[3].PCW = 1;
		CLASS_DECI[3].NST = STATE + 5'd1;
		CLASS_DECI[3].LST = 1;
		CLASS_DECI[3].ILI = 0;
		
begin
begin
begin //EXGPC Rd (PC->Rd,Rd->PC)
unique case (1'b1)
STATE_OH[0]: begin
CLASS_DECI[3].RWA = '{RS_PC, 1'b1};
CLASS_DECI[3].JC = JC_JUMP;
CLASS_DECI[3].PCS = PCS_REG;
end
default: begin
CLASS_DECI[3].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[3].R = CLASS_DECI[3].R | IC[4];
		CLASS_DECI[3].RD = CLASS_DECI[3].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[3].RS = CLASS_DECI[3].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[3].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 4.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[4].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[4].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[4].R = 0;
		CLASS_DECI[4].M = 0;
		CLASS_DECI[4].F = IC[9];
		CLASS_DECI[4].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[4].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[4].FT = '{FSI_32, 1'b0};
		CLASS_DECI[4].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[4].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[4].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[4].IWL = IW_NONE;
		CLASS_DECI[4].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[4].MMS = 0;
		CLASS_DECI[4].MMA = 0;
		CLASS_DECI[4].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[4].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[4].JC = JC_NONE;
		CLASS_DECI[4].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[4].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[4].PIXO = '{PATS_NULL};
		CLASS_DECI[4].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[4].PCS = PCS_NONE;
		CLASS_DECI[4].PCW = 1;
		CLASS_DECI[4].NST = STATE + 5'd1;
		CLASS_DECI[4].LST = 1;
		CLASS_DECI[4].ILI = 0;
		
begin
begin
begin //GETPC Rd (PC->Rd)
CLASS_DECI[4].RWA = '{RS_PC, 1'b1};
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[4].R = CLASS_DECI[4].R | IC[4];
		CLASS_DECI[4].RD = CLASS_DECI[4].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[4].RS = CLASS_DECI[4].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[4].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 5.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[5].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[5].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[5].R = 0;
		CLASS_DECI[5].M = 0;
		CLASS_DECI[5].F = IC[9];
		CLASS_DECI[5].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[5].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[5].FT = '{FSI_32, 1'b0};
		CLASS_DECI[5].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[5].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[5].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[5].IWL = IW_NONE;
		CLASS_DECI[5].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[5].MMS = 0;
		CLASS_DECI[5].MMA = 0;
		CLASS_DECI[5].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[5].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[5].JC = JC_NONE;
		CLASS_DECI[5].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[5].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[5].PIXO = '{PATS_NULL};
		CLASS_DECI[5].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[5].PCS = PCS_NONE;
		CLASS_DECI[5].PCW = 1;
		CLASS_DECI[5].NST = STATE + 5'd1;
		CLASS_DECI[5].LST = 1;
		CLASS_DECI[5].ILI = 0;
		
begin
begin
begin //JUMP Rs (Rs->PC)
unique case (1'b1)
STATE_OH[0]: begin
CLASS_DECI[5].JC = JC_JUMP;
CLASS_DECI[5].PCS = PCS_REG;
CLASS_DECI[5].LST = 0;
end
default: begin
CLASS_DECI[5].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[5].R = CLASS_DECI[5].R | IC[4];
		CLASS_DECI[5].RD = CLASS_DECI[5].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[5].RS = CLASS_DECI[5].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[5].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 6.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[6].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[6].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[6].R = 0;
		CLASS_DECI[6].M = 0;
		CLASS_DECI[6].F = IC[9];
		CLASS_DECI[6].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[6].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[6].FT = '{FSI_32, 1'b0};
		CLASS_DECI[6].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[6].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[6].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[6].IWL = IW_NONE;
		CLASS_DECI[6].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[6].MMS = 0;
		CLASS_DECI[6].MMA = 0;
		CLASS_DECI[6].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[6].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[6].JC = JC_NONE;
		CLASS_DECI[6].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[6].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[6].PIXO = '{PATS_NULL};
		CLASS_DECI[6].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[6].PCS = PCS_NONE;
		CLASS_DECI[6].PCW = 1;
		CLASS_DECI[6].NST = STATE + 5'd1;
		CLASS_DECI[6].LST = 1;
		CLASS_DECI[6].ILI = 0;
		
begin
begin
begin //GETST Rd (ST->Rd)
CLASS_DECI[6].RWA = '{RS_ST, 1'b1};
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[6].R = CLASS_DECI[6].R | IC[4];
		CLASS_DECI[6].RD = CLASS_DECI[6].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[6].RS = CLASS_DECI[6].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[6].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 7.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[7].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[7].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[7].R = 0;
		CLASS_DECI[7].M = 0;
		CLASS_DECI[7].F = IC[9];
		CLASS_DECI[7].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[7].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[7].FT = '{FSI_32, 1'b0};
		CLASS_DECI[7].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[7].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[7].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[7].IWL = IW_NONE;
		CLASS_DECI[7].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[7].MMS = 0;
		CLASS_DECI[7].MMA = 0;
		CLASS_DECI[7].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[7].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[7].JC = JC_NONE;
		CLASS_DECI[7].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[7].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[7].PIXO = '{PATS_NULL};
		CLASS_DECI[7].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[7].PCS = PCS_NONE;
		CLASS_DECI[7].PCW = 1;
		CLASS_DECI[7].NST = STATE + 5'd1;
		CLASS_DECI[7].LST = 1;
		CLASS_DECI[7].ILI = 0;
		
begin
begin
begin //PUTST Rs (Rs->ST)
unique case (1'b1)
STATE_OH[0]: begin
CLASS_DECI[7].STW = {STU_ST, 4'b0000};
CLASS_DECI[7].LST = 0;
end
STATE_OH[1]: begin
CLASS_DECI[7].LST = 0;
end
default: begin
CLASS_DECI[7].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[7].R = CLASS_DECI[7].R | IC[4];
		CLASS_DECI[7].RD = CLASS_DECI[7].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[7].RS = CLASS_DECI[7].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[7].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 8.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[8].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[8].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[8].R = 0;
		CLASS_DECI[8].M = 0;
		CLASS_DECI[8].F = IC[9];
		CLASS_DECI[8].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[8].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[8].FT = '{FSI_32, 1'b0};
		CLASS_DECI[8].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[8].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[8].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[8].IWL = IW_NONE;
		CLASS_DECI[8].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[8].MMS = 0;
		CLASS_DECI[8].MMA = 0;
		CLASS_DECI[8].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[8].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[8].JC = JC_NONE;
		CLASS_DECI[8].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[8].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[8].PIXO = '{PATS_NULL};
		CLASS_DECI[8].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[8].PCS = PCS_NONE;
		CLASS_DECI[8].PCW = 1;
		CLASS_DECI[8].NST = STATE + 5'd1;
		CLASS_DECI[8].LST = 1;
		CLASS_DECI[8].ILI = 0;
		
begin
begin
begin //POPST
unique case (1'b1)
STATE_OH[0]: begin	//SP+32->SP,*SP->BUF
CLASS_DECI[8].RD = 4'hF; rd_keep = 0;
CLASS_DECI[8].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[8].AIB = '{IMM_K, CV_32, AS_CONST, EO_NONE};
CLASS_DECI[8].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[8].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[8].MC = '{MAS_RA, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[8].LST = 0;
end
STATE_OH[1]: begin	//BUF->ST
CLASS_DECI[8].STW = {STU_MEM, 4'b0000};
CLASS_DECI[8].LST = 0;
end
STATE_OH[2]: begin
CLASS_DECI[8].LST = 0;
end
default: begin
CLASS_DECI[8].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[8].R = CLASS_DECI[8].R | IC[4];
		CLASS_DECI[8].RD = CLASS_DECI[8].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[8].RS = CLASS_DECI[8].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[8].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 9.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[9].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[9].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[9].R = 0;
		CLASS_DECI[9].M = 0;
		CLASS_DECI[9].F = IC[9];
		CLASS_DECI[9].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[9].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[9].FT = '{FSI_32, 1'b0};
		CLASS_DECI[9].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[9].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[9].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[9].IWL = IW_NONE;
		CLASS_DECI[9].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[9].MMS = 0;
		CLASS_DECI[9].MMA = 0;
		CLASS_DECI[9].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[9].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[9].JC = JC_NONE;
		CLASS_DECI[9].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[9].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[9].PIXO = '{PATS_NULL};
		CLASS_DECI[9].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[9].PCS = PCS_NONE;
		CLASS_DECI[9].PCW = 1;
		CLASS_DECI[9].NST = STATE + 5'd1;
		CLASS_DECI[9].LST = 1;
		CLASS_DECI[9].ILI = 0;
		
begin
begin
begin //PUSHST
unique case (1'b1)
STATE_OH[0]: begin	//SP-32-0->ALUR
CLASS_DECI[9].RD = 4'hF; rd_keep = 0;
CLASS_DECI[9].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[9].AIB = '{IMM_K, CV_32, AS_CONST, EO_NONE};
CLASS_DECI[9].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[9].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[9].LST = 0;
end
default: begin	//ST->*ALUR
CLASS_DECI[9].RD = 4'hF; rd_keep = 0;
CLASS_DECI[9].MC = '{MAS_RA, MDS_ST, MA_WRITE, MT_DATA};
CLASS_DECI[9].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[9].R = CLASS_DECI[9].R | IC[4];
		CLASS_DECI[9].RD = CLASS_DECI[9].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[9].RS = CLASS_DECI[9].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[9].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 10.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[10].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[10].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[10].R = 0;
		CLASS_DECI[10].M = 0;
		CLASS_DECI[10].F = IC[9];
		CLASS_DECI[10].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[10].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[10].FT = '{FSI_32, 1'b0};
		CLASS_DECI[10].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[10].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[10].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[10].IWL = IW_NONE;
		CLASS_DECI[10].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[10].MMS = 0;
		CLASS_DECI[10].MMA = 0;
		CLASS_DECI[10].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[10].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[10].JC = JC_NONE;
		CLASS_DECI[10].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[10].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[10].PIXO = '{PATS_NULL};
		CLASS_DECI[10].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[10].PCS = PCS_NONE;
		CLASS_DECI[10].PCW = 1;
		CLASS_DECI[10].NST = STATE + 5'd1;
		CLASS_DECI[10].LST = 1;
		CLASS_DECI[10].ILI = 0;
		
begin
begin
begin	//SETCMP Rd
unique case (1'b1) //TODO
STATE_OH[0]: begin
CLASS_DECI[10].LST = 0;
end
default: begin //(Rd->*IO)
CLASS_DECI[10].MC = '{MAS_IO, MDS_REGA, MA_WRITE, MT_DATA};
CLASS_DECI[10].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[10].R = CLASS_DECI[10].R | IC[4];
		CLASS_DECI[10].RD = CLASS_DECI[10].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[10].RS = CLASS_DECI[10].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[10].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 11.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[11].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[11].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[11].R = 0;
		CLASS_DECI[11].M = 0;
		CLASS_DECI[11].F = IC[9];
		CLASS_DECI[11].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[11].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[11].FT = '{FSI_32, 1'b0};
		CLASS_DECI[11].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[11].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[11].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[11].IWL = IW_NONE;
		CLASS_DECI[11].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[11].MMS = 0;
		CLASS_DECI[11].MMA = 0;
		CLASS_DECI[11].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[11].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[11].JC = JC_NONE;
		CLASS_DECI[11].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[11].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[11].PIXO = '{PATS_NULL};
		CLASS_DECI[11].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[11].PCS = PCS_NONE;
		CLASS_DECI[11].PCW = 1;
		CLASS_DECI[11].NST = STATE + 5'd1;
		CLASS_DECI[11].LST = 1;
		CLASS_DECI[11].ILI = 0;
		
begin
begin
begin //RPIX Rd
unique case (1'b1)
STATE_OH[0]: begin
CLASS_DECI[11].LST = 0;
end
STATE_OH[1]: begin
CLASS_DECI[11].LST = RP_COND;
end
STATE_OH[2]: begin
CLASS_DECI[11].LST = 0;
end
STATE_OH[3]: begin //((Rd<<16)|Rd->Rd)
CLASS_DECI[11].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[11].AIB = '{IMM_K, CV_16, AS_REGB, EO_NONE};
CLASS_DECI[11].ALU = '{ALUOP_LOG, 4'b0010, 1'b0};
CLASS_DECI[11].SHC = '{SS_CONST, 3'b000};
CLASS_DECI[11].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[11].LST = RP_COND;
end
STATE_OH[4]: begin //((Rd<<8)|Rd->Rd)
CLASS_DECI[11].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[11].AIB = '{IMM_K, CV_8 , AS_REGB, EO_NONE};
CLASS_DECI[11].ALU = '{ALUOP_LOG, 4'b0010, 1'b0};
CLASS_DECI[11].SHC = '{SS_CONST, 3'b000};
CLASS_DECI[11].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[11].LST = RP_COND;
end
STATE_OH[5]: begin //((Rd<<4)|Rd->Rd)
CLASS_DECI[11].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[11].AIB = '{IMM_K, CV_4 , AS_REGB, EO_NONE};
CLASS_DECI[11].ALU = '{ALUOP_LOG, 4'b0010, 1'b0};
CLASS_DECI[11].SHC = '{SS_CONST, 3'b000};
CLASS_DECI[11].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[11].LST = RP_COND;
end
STATE_OH[6]: begin //((Rd<<2)|Rd->Rd)
CLASS_DECI[11].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[11].AIB = '{IMM_K, CV_2 , AS_REGB, EO_NONE};
CLASS_DECI[11].ALU = '{ALUOP_LOG, 4'b0010, 1'b0};
CLASS_DECI[11].SHC = '{SS_CONST, 3'b000};
CLASS_DECI[11].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[11].LST = RP_COND;
end
default: begin //((Rd<<1)|Rd->Rd)
CLASS_DECI[11].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[11].AIB = '{IMM_K, CV_1 , AS_REGB, EO_NONE};
CLASS_DECI[11].ALU = '{ALUOP_LOG, 4'b0010, 1'b0};
CLASS_DECI[11].SHC = '{SS_CONST, 3'b000};
CLASS_DECI[11].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[11].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[11].R = CLASS_DECI[11].R | IC[4];
		CLASS_DECI[11].RD = CLASS_DECI[11].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[11].RS = CLASS_DECI[11].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[11].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 12.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[12].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[12].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[12].R = 0;
		CLASS_DECI[12].M = 0;
		CLASS_DECI[12].F = IC[9];
		CLASS_DECI[12].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[12].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[12].FT = '{FSI_32, 1'b0};
		CLASS_DECI[12].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[12].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[12].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[12].IWL = IW_NONE;
		CLASS_DECI[12].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[12].MMS = 0;
		CLASS_DECI[12].MMA = 0;
		CLASS_DECI[12].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[12].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[12].JC = JC_NONE;
		CLASS_DECI[12].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[12].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[12].PIXO = '{PATS_NULL};
		CLASS_DECI[12].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[12].PCS = PCS_NONE;
		CLASS_DECI[12].PCW = 1;
		CLASS_DECI[12].NST = STATE + 5'd1;
		CLASS_DECI[12].LST = 1;
		CLASS_DECI[12].ILI = 0;
		
begin
begin
begin //EXGPS Rd
unique case (1'b1)
STATE_OH[0]: begin
CLASS_DECI[12].LST = 0;
end
default: begin //(0+PS->Rd,Rd->*ALUR)
CLASS_DECI[12].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[12].AIB = '{IMM_K, CV_0 , AS_PS   , EO_NONE};
CLASS_DECI[12].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[12].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[12].MC = '{MAS_IO, MDS_REGA, MA_WRITE, MT_DATA};
CLASS_DECI[12].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[12].R = CLASS_DECI[12].R | IC[4];
		CLASS_DECI[12].RD = CLASS_DECI[12].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[12].RS = CLASS_DECI[12].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[12].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 13.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[13].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[13].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[13].R = 0;
		CLASS_DECI[13].M = 0;
		CLASS_DECI[13].F = IC[9];
		CLASS_DECI[13].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[13].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[13].FT = '{FSI_32, 1'b0};
		CLASS_DECI[13].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[13].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[13].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[13].IWL = IW_NONE;
		CLASS_DECI[13].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[13].MMS = 0;
		CLASS_DECI[13].MMA = 0;
		CLASS_DECI[13].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[13].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[13].JC = JC_NONE;
		CLASS_DECI[13].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[13].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[13].PIXO = '{PATS_NULL};
		CLASS_DECI[13].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[13].PCS = PCS_NONE;
		CLASS_DECI[13].PCW = 1;
		CLASS_DECI[13].NST = STATE + 5'd1;
		CLASS_DECI[13].LST = 1;
		CLASS_DECI[13].ILI = 0;
		
begin
begin
begin //GETPS Rd
unique case (1'b1)
STATE_OH[0]: begin
CLASS_DECI[13].LST = 0;
end
default: begin //(0+PS->Rd)
CLASS_DECI[13].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[13].AIB = '{IMM_K, CV_0 , AS_PS   , EO_NONE};
CLASS_DECI[13].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[13].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[13].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[13].R = CLASS_DECI[13].R | IC[4];
		CLASS_DECI[13].RD = CLASS_DECI[13].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[13].RS = CLASS_DECI[13].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[13].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 14.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[14].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[14].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[14].R = 0;
		CLASS_DECI[14].M = 0;
		CLASS_DECI[14].F = IC[9];
		CLASS_DECI[14].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[14].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[14].FT = '{FSI_32, 1'b0};
		CLASS_DECI[14].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[14].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[14].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[14].IWL = IW_NONE;
		CLASS_DECI[14].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[14].MMS = 0;
		CLASS_DECI[14].MMA = 0;
		CLASS_DECI[14].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[14].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[14].JC = JC_NONE;
		CLASS_DECI[14].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[14].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[14].PIXO = '{PATS_NULL};
		CLASS_DECI[14].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[14].PCS = PCS_NONE;
		CLASS_DECI[14].PCW = 1;
		CLASS_DECI[14].NST = STATE + 5'd1;
		CLASS_DECI[14].LST = 1;
		CLASS_DECI[14].ILI = 0;
		
begin
begin
begin //NOP
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[14].R = CLASS_DECI[14].R | IC[4];
		CLASS_DECI[14].RD = CLASS_DECI[14].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[14].RS = CLASS_DECI[14].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[14].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 15.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[15].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[15].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[15].R = 0;
		CLASS_DECI[15].M = 0;
		CLASS_DECI[15].F = IC[9];
		CLASS_DECI[15].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[15].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[15].FT = '{FSI_32, 1'b0};
		CLASS_DECI[15].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[15].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[15].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[15].IWL = IW_NONE;
		CLASS_DECI[15].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[15].MMS = 0;
		CLASS_DECI[15].MMA = 0;
		CLASS_DECI[15].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[15].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[15].JC = JC_NONE;
		CLASS_DECI[15].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[15].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[15].PIXO = '{PATS_NULL};
		CLASS_DECI[15].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[15].PCS = PCS_NONE;
		CLASS_DECI[15].PCW = 1;
		CLASS_DECI[15].NST = STATE + 5'd1;
		CLASS_DECI[15].LST = 1;
		CLASS_DECI[15].ILI = 0;
		
begin
begin
begin //CLRC
CLASS_DECI[15].STW = {STU_C, 4'b0000};
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[15].R = CLASS_DECI[15].R | IC[4];
		CLASS_DECI[15].RD = CLASS_DECI[15].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[15].RS = CLASS_DECI[15].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[15].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 16.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[16].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[16].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[16].R = 0;
		CLASS_DECI[16].M = 0;
		CLASS_DECI[16].F = IC[9];
		CLASS_DECI[16].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[16].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[16].FT = '{FSI_32, 1'b0};
		CLASS_DECI[16].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[16].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[16].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[16].IWL = IW_NONE;
		CLASS_DECI[16].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[16].MMS = 0;
		CLASS_DECI[16].MMA = 0;
		CLASS_DECI[16].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[16].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[16].JC = JC_NONE;
		CLASS_DECI[16].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[16].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[16].PIXO = '{PATS_NULL};
		CLASS_DECI[16].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[16].PCS = PCS_NONE;
		CLASS_DECI[16].PCW = 1;
		CLASS_DECI[16].NST = STATE + 5'd1;
		CLASS_DECI[16].LST = 1;
		CLASS_DECI[16].ILI = 0;
		
begin
begin
begin  //MOVB @SAddr,@DAddr
unique case (1'b1)
STATE_OH[0]: begin //
CLASS_DECI[16].IWL = IW_LONG;
CLASS_DECI[16].LST = 0;
end
STATE_OH[1]: begin //(*IL->BUF)
CLASS_DECI[16].FT = '{FSI_8, 1'b0};
CLASS_DECI[16].MC = '{MAS_IL, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[16].LST = 0;
end
STATE_OH[2]: begin //
CLASS_DECI[16].IWL = IW_LONG;
CLASS_DECI[16].LST = 0;
end
default: begin //(BUF->*IL)
CLASS_DECI[16].FT = '{FSI_8, 1'b0};
CLASS_DECI[16].MC = '{MAS_IL, MDS_MEM, MA_WRITE, MT_DATA};
CLASS_DECI[16].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[16].R = CLASS_DECI[16].R | IC[4];
		CLASS_DECI[16].RD = CLASS_DECI[16].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[16].RS = CLASS_DECI[16].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[16].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 17.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[17].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[17].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[17].R = 0;
		CLASS_DECI[17].M = 0;
		CLASS_DECI[17].F = IC[9];
		CLASS_DECI[17].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[17].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[17].FT = '{FSI_32, 1'b0};
		CLASS_DECI[17].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[17].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[17].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[17].IWL = IW_NONE;
		CLASS_DECI[17].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[17].MMS = 0;
		CLASS_DECI[17].MMA = 0;
		CLASS_DECI[17].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[17].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[17].JC = JC_NONE;
		CLASS_DECI[17].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[17].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[17].PIXO = '{PATS_NULL};
		CLASS_DECI[17].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[17].PCS = PCS_NONE;
		CLASS_DECI[17].PCW = 1;
		CLASS_DECI[17].NST = STATE + 5'd1;
		CLASS_DECI[17].LST = 1;
		CLASS_DECI[17].ILI = 0;
		
begin
begin
begin //DINT
unique case (1'b1)
STATE_OH[0]: begin
CLASS_DECI[17].STW = {STU_IE, 4'b0000};
CLASS_DECI[17].LST = 0;
end
STATE_OH[1]: begin
CLASS_DECI[17].LST = 0;
end
default: begin
CLASS_DECI[17].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[17].R = CLASS_DECI[17].R | IC[4];
		CLASS_DECI[17].RD = CLASS_DECI[17].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[17].RS = CLASS_DECI[17].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[17].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 18.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[18].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[18].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[18].R = 0;
		CLASS_DECI[18].M = 0;
		CLASS_DECI[18].F = IC[9];
		CLASS_DECI[18].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[18].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[18].FT = '{FSI_32, 1'b0};
		CLASS_DECI[18].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[18].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[18].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[18].IWL = IW_NONE;
		CLASS_DECI[18].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[18].MMS = 0;
		CLASS_DECI[18].MMA = 0;
		CLASS_DECI[18].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[18].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[18].JC = JC_NONE;
		CLASS_DECI[18].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[18].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[18].PIXO = '{PATS_NULL};
		CLASS_DECI[18].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[18].PCS = PCS_NONE;
		CLASS_DECI[18].PCW = 1;
		CLASS_DECI[18].NST = STATE + 5'd1;
		CLASS_DECI[18].LST = 1;
		CLASS_DECI[18].ILI = 0;
		
begin
begin
begin //ABS Rd (abs(Rd)->Rd)
CLASS_DECI[18].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[18].AIB = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[18].ALU = '{ALUOP_ADD, 4'b0100, 1'b1};
CLASS_DECI[18].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[18].STW = {STU_ALU, AFU_NZV};
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[18].R = CLASS_DECI[18].R | IC[4];
		CLASS_DECI[18].RD = CLASS_DECI[18].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[18].RS = CLASS_DECI[18].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[18].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 19.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[19].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[19].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[19].R = 0;
		CLASS_DECI[19].M = 0;
		CLASS_DECI[19].F = IC[9];
		CLASS_DECI[19].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[19].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[19].FT = '{FSI_32, 1'b0};
		CLASS_DECI[19].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[19].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[19].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[19].IWL = IW_NONE;
		CLASS_DECI[19].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[19].MMS = 0;
		CLASS_DECI[19].MMA = 0;
		CLASS_DECI[19].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[19].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[19].JC = JC_NONE;
		CLASS_DECI[19].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[19].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[19].PIXO = '{PATS_NULL};
		CLASS_DECI[19].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[19].PCS = PCS_NONE;
		CLASS_DECI[19].PCW = 1;
		CLASS_DECI[19].NST = STATE + 5'd1;
		CLASS_DECI[19].LST = 1;
		CLASS_DECI[19].ILI = 0;
		
begin
begin
begin //NEGB Rd (0-Rd-C->Rd)
CLASS_DECI[19].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[19].AIB = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[19].ALU = '{ALUOP_ADD, {2'b00,IC[6],1'b1}, 1'b1};
CLASS_DECI[19].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[19].STW = {STU_ALU, AFU_NCZV};
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[19].R = CLASS_DECI[19].R | IC[4];
		CLASS_DECI[19].RD = CLASS_DECI[19].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[19].RS = CLASS_DECI[19].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[19].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 20.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[20].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[20].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[20].R = 0;
		CLASS_DECI[20].M = 0;
		CLASS_DECI[20].F = IC[9];
		CLASS_DECI[20].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[20].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[20].FT = '{FSI_32, 1'b0};
		CLASS_DECI[20].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[20].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[20].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[20].IWL = IW_NONE;
		CLASS_DECI[20].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[20].MMS = 0;
		CLASS_DECI[20].MMA = 0;
		CLASS_DECI[20].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[20].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[20].JC = JC_NONE;
		CLASS_DECI[20].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[20].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[20].PIXO = '{PATS_NULL};
		CLASS_DECI[20].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[20].PCS = PCS_NONE;
		CLASS_DECI[20].PCW = 1;
		CLASS_DECI[20].NST = STATE + 5'd1;
		CLASS_DECI[20].LST = 1;
		CLASS_DECI[20].ILI = 0;
		
begin
begin
begin //NOT Rd (~Rd->Rd)
CLASS_DECI[20].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[20].AIB = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[20].ALU = '{ALUOP_ADD, 4'b0000, 1'b1};
CLASS_DECI[20].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[20].STW = {STU_ALU, AFU_Z};
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[20].R = CLASS_DECI[20].R | IC[4];
		CLASS_DECI[20].RD = CLASS_DECI[20].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[20].RS = CLASS_DECI[20].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[20].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 21.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[21].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[21].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[21].R = 0;
		CLASS_DECI[21].M = 0;
		CLASS_DECI[21].F = IC[9];
		CLASS_DECI[21].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[21].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[21].FT = '{FSI_32, 1'b0};
		CLASS_DECI[21].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[21].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[21].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[21].IWL = IW_NONE;
		CLASS_DECI[21].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[21].MMS = 0;
		CLASS_DECI[21].MMA = 0;
		CLASS_DECI[21].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[21].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[21].JC = JC_NONE;
		CLASS_DECI[21].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[21].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[21].PIXO = '{PATS_NULL};
		CLASS_DECI[21].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[21].PCS = PCS_NONE;
		CLASS_DECI[21].PCW = 1;
		CLASS_DECI[21].NST = STATE + 5'd1;
		CLASS_DECI[21].LST = 1;
		CLASS_DECI[21].ILI = 0;
		
begin
CLASS_DECI[21].ILI = 1;
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[21].R = CLASS_DECI[21].R | IC[4];
		CLASS_DECI[21].RD = CLASS_DECI[21].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[21].RS = CLASS_DECI[21].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[21].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 22.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[22].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[22].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[22].R = 0;
		CLASS_DECI[22].M = 0;
		CLASS_DECI[22].F = IC[9];
		CLASS_DECI[22].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[22].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[22].FT = '{FSI_32, 1'b0};
		CLASS_DECI[22].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[22].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[22].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[22].IWL = IW_NONE;
		CLASS_DECI[22].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[22].MMS = 0;
		CLASS_DECI[22].MMA = 0;
		CLASS_DECI[22].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[22].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[22].JC = JC_NONE;
		CLASS_DECI[22].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[22].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[22].PIXO = '{PATS_NULL};
		CLASS_DECI[22].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[22].PCS = PCS_NONE;
		CLASS_DECI[22].PCW = 1;
		CLASS_DECI[22].NST = STATE + 5'd1;
		CLASS_DECI[22].LST = 1;
		CLASS_DECI[22].ILI = 0;
		
begin
begin
begin //SEXT Rd,F
unique case (1'b1)
STATE_OH[0]: begin	//(extu(Rd)+0+0->Rd)
CLASS_DECI[22].AIA = '{IMM_K, CV_0 , AS_REGA , EO_ZERO};
CLASS_DECI[22].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[22].FT = '{FSI_F, 1'b0};
CLASS_DECI[22].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[22].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[22].STW = {STU_ALU, AFU_NZ};
CLASS_DECI[22].LST = 0;
end
default: begin	//(exts(Rd)+0+0->Rd)
CLASS_DECI[22].AIA = '{IMM_K, CV_0 , AS_REGA , EO_SIGN};
CLASS_DECI[22].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[22].FT = '{FSI_F, 1'b0};
CLASS_DECI[22].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[22].RWA = '{RS_ALU, 1'b1};////////////////////
CLASS_DECI[22].STW = {STU_ALU, AFU_NZ};
CLASS_DECI[22].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[22].R = CLASS_DECI[22].R | IC[4];
		CLASS_DECI[22].RD = CLASS_DECI[22].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[22].RS = CLASS_DECI[22].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[22].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 23.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[23].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[23].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[23].R = 0;
		CLASS_DECI[23].M = 0;
		CLASS_DECI[23].F = IC[9];
		CLASS_DECI[23].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[23].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[23].FT = '{FSI_32, 1'b0};
		CLASS_DECI[23].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[23].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[23].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[23].IWL = IW_NONE;
		CLASS_DECI[23].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[23].MMS = 0;
		CLASS_DECI[23].MMA = 0;
		CLASS_DECI[23].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[23].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[23].JC = JC_NONE;
		CLASS_DECI[23].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[23].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[23].PIXO = '{PATS_NULL};
		CLASS_DECI[23].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[23].PCS = PCS_NONE;
		CLASS_DECI[23].PCW = 1;
		CLASS_DECI[23].NST = STATE + 5'd1;
		CLASS_DECI[23].LST = 1;
		CLASS_DECI[23].ILI = 0;
		
begin
begin
begin //ZEXT Rd,F
unique case (1'b1)
default: begin	//(extu(Rd)+0+0->Rd)
CLASS_DECI[23].AIA = '{IMM_K, CV_0 , AS_REGA , EO_ZERO};
CLASS_DECI[23].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[23].FT = '{FSI_F, 1'b0};
CLASS_DECI[23].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[23].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[23].STW = {STU_ALU, AFU_Z};
CLASS_DECI[23].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[23].R = CLASS_DECI[23].R | IC[4];
		CLASS_DECI[23].RD = CLASS_DECI[23].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[23].RS = CLASS_DECI[23].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[23].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 24.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[24].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[24].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[24].R = 0;
		CLASS_DECI[24].M = 0;
		CLASS_DECI[24].F = IC[9];
		CLASS_DECI[24].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[24].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[24].FT = '{FSI_32, 1'b0};
		CLASS_DECI[24].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[24].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[24].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[24].IWL = IW_NONE;
		CLASS_DECI[24].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[24].MMS = 0;
		CLASS_DECI[24].MMA = 0;
		CLASS_DECI[24].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[24].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[24].JC = JC_NONE;
		CLASS_DECI[24].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[24].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[24].PIXO = '{PATS_NULL};
		CLASS_DECI[24].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[24].PCS = PCS_NONE;
		CLASS_DECI[24].PCW = 1;
		CLASS_DECI[24].NST = STATE + 5'd1;
		CLASS_DECI[24].LST = 1;
		CLASS_DECI[24].ILI = 0;
		
begin
begin
begin //SETF FS,FE,F
CLASS_DECI[24].STW = {STU_FS, 4'b0000};
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[24].R = CLASS_DECI[24].R | IC[4];
		CLASS_DECI[24].RD = CLASS_DECI[24].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[24].RS = CLASS_DECI[24].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[24].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 25.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[25].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[25].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[25].R = 0;
		CLASS_DECI[25].M = 0;
		CLASS_DECI[25].F = IC[9];
		CLASS_DECI[25].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[25].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[25].FT = '{FSI_32, 1'b0};
		CLASS_DECI[25].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[25].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[25].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[25].IWL = IW_NONE;
		CLASS_DECI[25].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[25].MMS = 0;
		CLASS_DECI[25].MMA = 0;
		CLASS_DECI[25].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[25].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[25].JC = JC_NONE;
		CLASS_DECI[25].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[25].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[25].PIXO = '{PATS_NULL};
		CLASS_DECI[25].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[25].PCS = PCS_NONE;
		CLASS_DECI[25].PCW = 1;
		CLASS_DECI[25].NST = STATE + 5'd1;
		CLASS_DECI[25].LST = 1;
		CLASS_DECI[25].ILI = 0;
		
begin
begin
begin  //MOVE Rd,@DAddr,F
unique case (1'b1)
STATE_OH[0]: begin //
CLASS_DECI[25].IWL = IW_LONG;
CLASS_DECI[25].LST = 0;
end
default: begin //(Rs->*IL)
CLASS_DECI[25].FT = '{FSI_F, 1'b0};
CLASS_DECI[25].MC = '{MAS_IL, MDS_REGA, MA_WRITE, MT_DATA};
CLASS_DECI[25].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[25].R = CLASS_DECI[25].R | IC[4];
		CLASS_DECI[25].RD = CLASS_DECI[25].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[25].RS = CLASS_DECI[25].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[25].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 26.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[26].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[26].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[26].R = 0;
		CLASS_DECI[26].M = 0;
		CLASS_DECI[26].F = IC[9];
		CLASS_DECI[26].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[26].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[26].FT = '{FSI_32, 1'b0};
		CLASS_DECI[26].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[26].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[26].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[26].IWL = IW_NONE;
		CLASS_DECI[26].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[26].MMS = 0;
		CLASS_DECI[26].MMA = 0;
		CLASS_DECI[26].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[26].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[26].JC = JC_NONE;
		CLASS_DECI[26].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[26].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[26].PIXO = '{PATS_NULL};
		CLASS_DECI[26].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[26].PCS = PCS_NONE;
		CLASS_DECI[26].PCW = 1;
		CLASS_DECI[26].NST = STATE + 5'd1;
		CLASS_DECI[26].LST = 1;
		CLASS_DECI[26].ILI = 0;
		
begin
begin
begin  //MOVE @SAddr,Rd,F
unique case (1'b1)
STATE_OH[0]: begin //
CLASS_DECI[26].IWL = IW_LONG;
CLASS_DECI[26].LST = 0;
end
STATE_OH[1]: begin //(*IL->BUF)
CLASS_DECI[26].FT = '{FSI_F, 1'b0};
CLASS_DECI[26].MC = '{MAS_IL, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[26].LST = 0;
end
STATE_OH[2]: begin //(BUF->Rd)
CLASS_DECI[26].FT = '{FSI_F, 1'b0};
CLASS_DECI[26].ALU = '{ALUOP_MOV, 4'b0000, 1'b0};
CLASS_DECI[26].RWA = '{RS_MEM, 1'b1};
CLASS_DECI[26].STW = {STU_ALU, AFU_NZ};
CLASS_DECI[26].LST = !IC[9] ? ~FE0 : ~FE1;
end
default: begin //(exts(Rd)+0+0->Rd)
CLASS_DECI[26].AIA = '{IMM_K, CV_0 , AS_REGA , EO_SIGN};
CLASS_DECI[26].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[26].FT = '{FSI_F, 1'b0};
CLASS_DECI[26].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[26].RWA = '{RS_ALU, 1'b1};////////////////////
CLASS_DECI[26].STW = {STU_ALU, AFU_NZ};
CLASS_DECI[26].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[26].R = CLASS_DECI[26].R | IC[4];
		CLASS_DECI[26].RD = CLASS_DECI[26].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[26].RS = CLASS_DECI[26].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[26].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 27.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[27].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[27].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[27].R = 0;
		CLASS_DECI[27].M = 0;
		CLASS_DECI[27].F = IC[9];
		CLASS_DECI[27].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[27].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[27].FT = '{FSI_32, 1'b0};
		CLASS_DECI[27].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[27].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[27].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[27].IWL = IW_NONE;
		CLASS_DECI[27].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[27].MMS = 0;
		CLASS_DECI[27].MMA = 0;
		CLASS_DECI[27].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[27].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[27].JC = JC_NONE;
		CLASS_DECI[27].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[27].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[27].PIXO = '{PATS_NULL};
		CLASS_DECI[27].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[27].PCS = PCS_NONE;
		CLASS_DECI[27].PCW = 1;
		CLASS_DECI[27].NST = STATE + 5'd1;
		CLASS_DECI[27].LST = 1;
		CLASS_DECI[27].ILI = 0;
		
begin
begin
begin  //MOVE @SAddr,@DAddr,F
unique case (1'b1)
STATE_OH[0]: begin //
CLASS_DECI[27].IWL = IW_LONG;
CLASS_DECI[27].LST = 0;
end
STATE_OH[1]: begin //(*IL->BUF)
CLASS_DECI[27].FT = '{FSI_F, 1'b0};
CLASS_DECI[27].MC = '{MAS_IL, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[27].LST = 0;
end
STATE_OH[2]: begin //
CLASS_DECI[27].IWL = IW_LONG;
CLASS_DECI[27].LST = 0;
end
default: begin //(BUF->*IL)
CLASS_DECI[27].FT = '{FSI_F, 1'b0};
CLASS_DECI[27].MC = '{MAS_IL, MDS_MEM, MA_WRITE, MT_DATA};
CLASS_DECI[27].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[27].R = CLASS_DECI[27].R | IC[4];
		CLASS_DECI[27].RD = CLASS_DECI[27].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[27].RS = CLASS_DECI[27].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[27].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 28.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[28].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[28].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[28].R = 0;
		CLASS_DECI[28].M = 0;
		CLASS_DECI[28].F = IC[9];
		CLASS_DECI[28].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[28].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[28].FT = '{FSI_32, 1'b0};
		CLASS_DECI[28].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[28].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[28].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[28].IWL = IW_NONE;
		CLASS_DECI[28].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[28].MMS = 0;
		CLASS_DECI[28].MMA = 0;
		CLASS_DECI[28].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[28].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[28].JC = JC_NONE;
		CLASS_DECI[28].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[28].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[28].PIXO = '{PATS_NULL};
		CLASS_DECI[28].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[28].PCS = PCS_NONE;
		CLASS_DECI[28].PCW = 1;
		CLASS_DECI[28].NST = STATE + 5'd1;
		CLASS_DECI[28].LST = 1;
		CLASS_DECI[28].ILI = 0;
		
begin
begin
begin  //MOVB @Addr,Rd; MOVB Rd,@Addr
unique case (1'b1)
STATE_OH[0]: begin //
CLASS_DECI[28].IWL = IW_LONG;
CLASS_DECI[28].LST = 0;
end
STATE_OH[1]: begin
CLASS_DECI[28].FT = '{FSI_8, 1'b1};
if (!IC[9]) begin //(Rs->*IL)
CLASS_DECI[28].MC = '{MAS_IL, MDS_REGA, MA_WRITE, MT_DATA};
CLASS_DECI[28].LST = 1;
end else begin //(*IL->BUF)
CLASS_DECI[28].MC = '{MAS_IL, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[28].LST = 0;
end
end
STATE_OH[2]: begin //(BUF->Rd)
CLASS_DECI[28].FT = '{FSI_8, 1'b1};
CLASS_DECI[28].ALU = '{ALUOP_MOV, 4'b0000, 1'b0};
CLASS_DECI[28].RWA = '{RS_MEM, 1'b1};
CLASS_DECI[28].STW = {STU_ALU, AFU_NZ};
CLASS_DECI[28].LST = 0;
end
default: begin //(exts(Rd)+0+0->Rd)
CLASS_DECI[28].AIA = '{IMM_K, CV_0 , AS_REGA , EO_SIGN};
CLASS_DECI[28].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[28].FT = '{FSI_8, 1'b1};
CLASS_DECI[28].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[28].RWA = '{RS_ALU, 1'b1};////////////////////
CLASS_DECI[28].STW = {STU_ALU, AFU_NZ};
CLASS_DECI[28].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[28].R = CLASS_DECI[28].R | IC[4];
		CLASS_DECI[28].RD = CLASS_DECI[28].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[28].RS = CLASS_DECI[28].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[28].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 29.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[29].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[29].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[29].R = 0;
		CLASS_DECI[29].M = 0;
		CLASS_DECI[29].F = IC[9];
		CLASS_DECI[29].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[29].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[29].FT = '{FSI_32, 1'b0};
		CLASS_DECI[29].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[29].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[29].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[29].IWL = IW_NONE;
		CLASS_DECI[29].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[29].MMS = 0;
		CLASS_DECI[29].MMA = 0;
		CLASS_DECI[29].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[29].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[29].JC = JC_NONE;
		CLASS_DECI[29].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[29].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[29].PIXO = '{PATS_NULL};
		CLASS_DECI[29].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[29].PCS = PCS_NONE;
		CLASS_DECI[29].PCW = 1;
		CLASS_DECI[29].NST = STATE + 5'd1;
		CLASS_DECI[29].LST = 1;
		CLASS_DECI[29].ILI = 0;
		
begin
begin
begin //TRAPL N
unique case (1'b1)
STATE_OH[0]: begin	//SP-32-0->SP
CLASS_DECI[29].RD = 4'hF; rd_keep = 0;
CLASS_DECI[29].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[29].AIB = '{IMM_K, CV_32, AS_CONST, EO_NONE};
CLASS_DECI[29].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[29].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[29].LST = 0;
end
STATE_OH[1]: begin	//PC->*SP,SP-32-0->SP
CLASS_DECI[29].RD = 4'hF; rd_keep = 0;
CLASS_DECI[29].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[29].AIB = '{IMM_K, CV_32, AS_CONST, EO_NONE};
CLASS_DECI[29].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[29].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[29].MC = '{MAS_RA, MDS_PC, MA_WRITE, MT_DATA};
CLASS_DECI[29].LST = 0;
end
STATE_OH[2]: begin	//ST->*SP
CLASS_DECI[29].RD = 4'hF; rd_keep = 0;
CLASS_DECI[29].MC = '{MAS_RA, MDS_ST, MA_WRITE, MT_DATA};
CLASS_DECI[29].LST = 0;
end
STATE_OH[3]: begin	//0x00000010->ST
CLASS_DECI[29].STW = {STU_RES, 4'b0000};
CLASS_DECI[29].IWL = IW_WORD;
CLASS_DECI[29].LST = 0;
end
STATE_OH[4]: begin	//*IW->BUF
CLASS_DECI[29].MC = '{MAS_IL, MDS_REGA, MA_READ, MT_DATA};/////////////////////////////
CLASS_DECI[29].LST = 0;
end
STATE_OH[5]: begin //BUF->PC
CLASS_DECI[29].PCS = PCS_MEM;
CLASS_DECI[29].LST = 0;
end
default: begin
CLASS_DECI[29].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[29].R = CLASS_DECI[29].R | IC[4];
		CLASS_DECI[29].RD = CLASS_DECI[29].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[29].RS = CLASS_DECI[29].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[29].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 30.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[30].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[30].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[30].R = 0;
		CLASS_DECI[30].M = 0;
		CLASS_DECI[30].F = IC[9];
		CLASS_DECI[30].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[30].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[30].FT = '{FSI_32, 1'b0};
		CLASS_DECI[30].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[30].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[30].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[30].IWL = IW_NONE;
		CLASS_DECI[30].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[30].MMS = 0;
		CLASS_DECI[30].MMA = 0;
		CLASS_DECI[30].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[30].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[30].JC = JC_NONE;
		CLASS_DECI[30].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[30].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[30].PIXO = '{PATS_NULL};
		CLASS_DECI[30].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[30].PCS = PCS_NONE;
		CLASS_DECI[30].PCW = 1;
		CLASS_DECI[30].NST = STATE + 5'd1;
		CLASS_DECI[30].LST = 1;
		CLASS_DECI[30].ILI = 0;
		
begin
begin
begin //TRAP N
unique case (1'b1)
STATE_OH[0]: begin	//
CLASS_DECI[30].NST = IC[5:0] == 5'd0 ? 3'd5 : STATE + 5'd1;
CLASS_DECI[30].LST = 0;
end
STATE_OH[1]: begin	//SP-32->SP
CLASS_DECI[30].RD = 4'hF; rd_keep = 0;
CLASS_DECI[30].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[30].AIB = '{IMM_K, CV_32, AS_CONST, EO_NONE};
CLASS_DECI[30].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[30].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[30].LST = 0;
end
STATE_OH[2]: begin	//PC->*SP
CLASS_DECI[30].RD = 4'hF; rd_keep = 0;
CLASS_DECI[30].MC = '{MAS_RA, MDS_PC, MA_WRITE, MT_DATA};
CLASS_DECI[30].LST = 0;
end
STATE_OH[3]: begin	//SP-32->SP
CLASS_DECI[30].RD = 4'hF; rd_keep = 0;
CLASS_DECI[30].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[30].AIB = '{IMM_K, CV_32, AS_CONST, EO_NONE};
CLASS_DECI[30].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[30].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[30].LST = 0;
end
STATE_OH[4]: begin	//ST->*SP
CLASS_DECI[30].RD = 4'hF; rd_keep = 0;
CLASS_DECI[30].MC = '{MAS_RA, MDS_ST, MA_WRITE, MT_DATA};
CLASS_DECI[30].LST = 0;
end
STATE_OH[5]: begin	//0x00000010->ST
CLASS_DECI[30].STW = {STU_RES, 4'b0000};
CLASS_DECI[30].LST = 0;
end
STATE_OH[6]: begin	//*VEC->BUF
CLASS_DECI[30].MC = '{MAS_VEC, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[30].LST = 0;
end
STATE_OH[7]: begin //BUF->PC
CLASS_DECI[30].PCS = PCS_MEM;
CLASS_DECI[30].LST = 0;
end
default: begin
CLASS_DECI[30].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[30].R = CLASS_DECI[30].R | IC[4];
		CLASS_DECI[30].RD = CLASS_DECI[30].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[30].RS = CLASS_DECI[30].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[30].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 31.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[31].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[31].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[31].R = 0;
		CLASS_DECI[31].M = 0;
		CLASS_DECI[31].F = IC[9];
		CLASS_DECI[31].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[31].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[31].FT = '{FSI_32, 1'b0};
		CLASS_DECI[31].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[31].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[31].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[31].IWL = IW_NONE;
		CLASS_DECI[31].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[31].MMS = 0;
		CLASS_DECI[31].MMA = 0;
		CLASS_DECI[31].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[31].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[31].JC = JC_NONE;
		CLASS_DECI[31].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[31].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[31].PIXO = '{PATS_NULL};
		CLASS_DECI[31].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[31].PCS = PCS_NONE;
		CLASS_DECI[31].PCW = 1;
		CLASS_DECI[31].NST = STATE + 5'd1;
		CLASS_DECI[31].LST = 1;
		CLASS_DECI[31].ILI = 0;
		
begin
begin
begin //CALL Rs
unique case (1'b1)
STATE_OH[0]: begin	//SP-32->SP
CLASS_DECI[31].RD = 4'hF; rd_keep = 0;
CLASS_DECI[31].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[31].AIB = '{IMM_K, CV_32, AS_CONST, EO_NONE};
CLASS_DECI[31].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[31].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[31].LST = 0;
end
STATE_OH[1]: begin	//PC->*SP,Rs->PC
CLASS_DECI[31].RD = 4'hF; rd_keep = 0;
CLASS_DECI[31].MC = '{MAS_RA, MDS_PC, MA_WRITE, MT_DATA};
CLASS_DECI[31].PCS = PCS_REG;
CLASS_DECI[31].LST = 0;
end
default: begin
CLASS_DECI[31].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[31].R = CLASS_DECI[31].R | IC[4];
		CLASS_DECI[31].RD = CLASS_DECI[31].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[31].RS = CLASS_DECI[31].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[31].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 32.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[32].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[32].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[32].R = 0;
		CLASS_DECI[32].M = 0;
		CLASS_DECI[32].F = IC[9];
		CLASS_DECI[32].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[32].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[32].FT = '{FSI_32, 1'b0};
		CLASS_DECI[32].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[32].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[32].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[32].IWL = IW_NONE;
		CLASS_DECI[32].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[32].MMS = 0;
		CLASS_DECI[32].MMA = 0;
		CLASS_DECI[32].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[32].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[32].JC = JC_NONE;
		CLASS_DECI[32].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[32].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[32].PIXO = '{PATS_NULL};
		CLASS_DECI[32].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[32].PCS = PCS_NONE;
		CLASS_DECI[32].PCW = 1;
		CLASS_DECI[32].NST = STATE + 5'd1;
		CLASS_DECI[32].LST = 1;
		CLASS_DECI[32].ILI = 0;
		
begin
begin
begin //RETI
unique case (1'b1)
STATE_OH[0]: begin	//*SP->BUF,SP+32->SP
CLASS_DECI[32].RD = 4'hF; rd_keep = 0;
CLASS_DECI[32].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[32].AIB = '{IMM_K, CV_32, AS_CONST, EO_NONE};
CLASS_DECI[32].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[32].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[32].MC = '{MAS_RA, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[32].LST = 0;
end
STATE_OH[1]: begin	//*SP->BUF,SP+32->SP,BUF->ST
CLASS_DECI[32].RD = 4'hF; rd_keep = 0;
CLASS_DECI[32].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[32].AIB = '{IMM_K, CV_32, AS_CONST, EO_NONE};
CLASS_DECI[32].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[32].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[32].MC = '{MAS_RA, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[32].STW = {STU_MEM, 4'b0000};
CLASS_DECI[32].LST = 0;
end
STATE_OH[2]: begin	//BUF->PC
CLASS_DECI[32].PCS = PCS_MEM;
CLASS_DECI[32].LST = 0;
end
default: begin
CLASS_DECI[32].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[32].R = CLASS_DECI[32].R | IC[4];
		CLASS_DECI[32].RD = CLASS_DECI[32].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[32].RS = CLASS_DECI[32].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[32].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 33.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[33].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[33].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[33].R = 0;
		CLASS_DECI[33].M = 0;
		CLASS_DECI[33].F = IC[9];
		CLASS_DECI[33].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[33].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[33].FT = '{FSI_32, 1'b0};
		CLASS_DECI[33].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[33].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[33].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[33].IWL = IW_NONE;
		CLASS_DECI[33].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[33].MMS = 0;
		CLASS_DECI[33].MMA = 0;
		CLASS_DECI[33].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[33].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[33].JC = JC_NONE;
		CLASS_DECI[33].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[33].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[33].PIXO = '{PATS_NULL};
		CLASS_DECI[33].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[33].PCS = PCS_NONE;
		CLASS_DECI[33].PCW = 1;
		CLASS_DECI[33].NST = STATE + 5'd1;
		CLASS_DECI[33].LST = 1;
		CLASS_DECI[33].ILI = 0;
		
begin
begin
begin //RETS N
unique case (1'b1)
STATE_OH[0]: begin	//*SP->BUF,SP+32->SP
CLASS_DECI[33].RD = 4'hF; rd_keep = 0;
CLASS_DECI[33].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[33].AIB = '{IMM_K, CV_32, AS_CONST, EO_NONE};
CLASS_DECI[33].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[33].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[33].MC = '{MAS_RA, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[33].LST = 0;
end
STATE_OH[1]: begin	//BUF->PC
CLASS_DECI[33].PCS = PCS_MEM;
CLASS_DECI[33].LST = 0;
end
default: begin
CLASS_DECI[33].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[33].R = CLASS_DECI[33].R | IC[4];
		CLASS_DECI[33].RD = CLASS_DECI[33].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[33].RS = CLASS_DECI[33].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[33].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 34.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[34].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[34].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[34].R = 0;
		CLASS_DECI[34].M = 0;
		CLASS_DECI[34].F = IC[9];
		CLASS_DECI[34].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[34].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[34].FT = '{FSI_32, 1'b0};
		CLASS_DECI[34].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[34].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[34].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[34].IWL = IW_NONE;
		CLASS_DECI[34].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[34].MMS = 0;
		CLASS_DECI[34].MMA = 0;
		CLASS_DECI[34].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[34].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[34].JC = JC_NONE;
		CLASS_DECI[34].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[34].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[34].PIXO = '{PATS_NULL};
		CLASS_DECI[34].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[34].PCS = PCS_NONE;
		CLASS_DECI[34].PCW = 1;
		CLASS_DECI[34].NST = STATE + 5'd1;
		CLASS_DECI[34].LST = 1;
		CLASS_DECI[34].ILI = 0;
		
begin
begin
begin //MMTM Rs,List
unique case (1'b1)
STATE_OH[0]: begin
CLASS_DECI[34].IWL = IW_WORD;
CLASS_DECI[34].LST = 0;
end
STATE_OH[1]: begin
CLASS_DECI[34].MMS = 1;
CLASS_DECI[34].LST = 0;
end
STATE_OH[2]: begin	//Rs-32->Rs
CLASS_DECI[34].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[34].AIB = '{IMM_K, CV_32, AS_CONST, EO_NONE};
CLASS_DECI[34].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[34].RWA = '{RS_ALU, ~MM_COND};
//										CLASS_DECI[34].MMA = 1;
CLASS_DECI[34].LST = MM_COND;
end
default: begin	//Rs-32->Rs,RB->*ALUR
CLASS_DECI[34].MC = '{MAS_RA, MDS_REGB, MA_WRITE, MT_DATA};
CLASS_DECI[34].MMA = 1;
CLASS_DECI[34].NST = !MM_COND ? 5'd2 : STATE + 5'd1;
CLASS_DECI[34].LST = MM_COND;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[34].R = CLASS_DECI[34].R | IC[4];
		CLASS_DECI[34].RD = CLASS_DECI[34].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[34].RS = CLASS_DECI[34].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[34].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 35.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[35].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[35].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[35].R = 0;
		CLASS_DECI[35].M = 0;
		CLASS_DECI[35].F = IC[9];
		CLASS_DECI[35].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[35].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[35].FT = '{FSI_32, 1'b0};
		CLASS_DECI[35].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[35].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[35].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[35].IWL = IW_NONE;
		CLASS_DECI[35].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[35].MMS = 0;
		CLASS_DECI[35].MMA = 0;
		CLASS_DECI[35].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[35].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[35].JC = JC_NONE;
		CLASS_DECI[35].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[35].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[35].PIXO = '{PATS_NULL};
		CLASS_DECI[35].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[35].PCS = PCS_NONE;
		CLASS_DECI[35].PCW = 1;
		CLASS_DECI[35].NST = STATE + 5'd1;
		CLASS_DECI[35].LST = 1;
		CLASS_DECI[35].ILI = 0;
		
begin
begin
begin //MMFM Rs,List
unique case (1'b1)
STATE_OH[0]: begin
CLASS_DECI[35].IWL = IW_WORD;
CLASS_DECI[35].LST = 0;
end
STATE_OH[1]: begin
CLASS_DECI[35].MMS = 1;
CLASS_DECI[35].LST = 0;
end
STATE_OH[2]: begin	//*Rs->RB,Rs+32->Rs
CLASS_DECI[35].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[35].AIB = '{IMM_K, CV_32, AS_CONST, EO_NONE};
CLASS_DECI[35].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[35].RWA = '{RS_ALU, ~MM_COND};
CLASS_DECI[35].MC = '{MAS_RA, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[35].LST = MM_COND;
end
default: begin
CLASS_DECI[35].ALU = '{ALUOP_MOV, 4'b0000, 1'b0};
CLASS_DECI[35].RWB = '{RS_MEM, 1'b1};
CLASS_DECI[35].MMA = 1;
CLASS_DECI[35].NST = !MM_COND ? 5'd2 : STATE + 5'd1;
CLASS_DECI[35].LST = MM_COND;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[35].R = CLASS_DECI[35].R | IC[4];
		CLASS_DECI[35].RD = CLASS_DECI[35].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[35].RS = CLASS_DECI[35].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[35].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 36.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[36].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[36].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[36].R = 0;
		CLASS_DECI[36].M = 0;
		CLASS_DECI[36].F = IC[9];
		CLASS_DECI[36].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[36].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[36].FT = '{FSI_32, 1'b0};
		CLASS_DECI[36].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[36].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[36].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[36].IWL = IW_NONE;
		CLASS_DECI[36].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[36].MMS = 0;
		CLASS_DECI[36].MMA = 0;
		CLASS_DECI[36].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[36].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[36].JC = JC_NONE;
		CLASS_DECI[36].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[36].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[36].PIXO = '{PATS_NULL};
		CLASS_DECI[36].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[36].PCS = PCS_NONE;
		CLASS_DECI[36].PCW = 1;
		CLASS_DECI[36].NST = STATE + 5'd1;
		CLASS_DECI[36].LST = 1;
		CLASS_DECI[36].ILI = 0;
		
begin
begin
begin //MOVI IL,Rd
unique case (1'b1)
STATE_OH[0]: begin
CLASS_DECI[36].IWL = !IC[5] ? IW_WORD : IW_LONG;
CLASS_DECI[36].LST = 0;
end
default: begin //(0+IW/IL->Rd)
CLASS_DECI[36].AIA = '{IMM_K , CV_0 , AS_CONST, EO_NONE};
if (!IC[5])
CLASS_DECI[36].AIB = '{IMM_IW, CV_0 , AS_IMM  , EO_NONE};
else
CLASS_DECI[36].AIB = '{IMM_IL, CV_0 , AS_IMM  , EO_NONE};
CLASS_DECI[36].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[36].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[36].STW = {STU_ALU, AFU_NZ};
CLASS_DECI[36].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[36].R = CLASS_DECI[36].R | IC[4];
		CLASS_DECI[36].RD = CLASS_DECI[36].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[36].RS = CLASS_DECI[36].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[36].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 37.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[37].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[37].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[37].R = 0;
		CLASS_DECI[37].M = 0;
		CLASS_DECI[37].F = IC[9];
		CLASS_DECI[37].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[37].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[37].FT = '{FSI_32, 1'b0};
		CLASS_DECI[37].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[37].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[37].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[37].IWL = IW_NONE;
		CLASS_DECI[37].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[37].MMS = 0;
		CLASS_DECI[37].MMA = 0;
		CLASS_DECI[37].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[37].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[37].JC = JC_NONE;
		CLASS_DECI[37].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[37].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[37].PIXO = '{PATS_NULL};
		CLASS_DECI[37].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[37].PCS = PCS_NONE;
		CLASS_DECI[37].PCW = 1;
		CLASS_DECI[37].NST = STATE + 5'd1;
		CLASS_DECI[37].LST = 1;
		CLASS_DECI[37].ILI = 0;
		
begin
begin
begin //CVDXYL Rd
unique case (1'b1)
STATE_OH[0]: begin //XYToL(Rd.XY)->Rd
CLASS_DECI[37].AIA = '{IMM_K, CV_0 , AS_PIX  , EO_NONE};
CLASS_DECI[37].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[37].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[37].PALU = '{PIXOP_XYL, PIXAS_REGA, !IC[7] ? CNVS_MP : CNVS_DP};
CLASS_DECI[37].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[37].LST = 0;
end
default: begin //(Rd+R4->Rd)
CLASS_DECI[37].RS = 4'h4; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[37].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[37].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[37].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[37].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[37].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[37].R = CLASS_DECI[37].R | IC[4];
		CLASS_DECI[37].RD = CLASS_DECI[37].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[37].RS = CLASS_DECI[37].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[37].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 38.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[38].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[38].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[38].R = 0;
		CLASS_DECI[38].M = 0;
		CLASS_DECI[38].F = IC[9];
		CLASS_DECI[38].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[38].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[38].FT = '{FSI_32, 1'b0};
		CLASS_DECI[38].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[38].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[38].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[38].IWL = IW_NONE;
		CLASS_DECI[38].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[38].MMS = 0;
		CLASS_DECI[38].MMA = 0;
		CLASS_DECI[38].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[38].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[38].JC = JC_NONE;
		CLASS_DECI[38].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[38].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[38].PIXO = '{PATS_NULL};
		CLASS_DECI[38].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[38].PCS = PCS_NONE;
		CLASS_DECI[38].PCW = 1;
		CLASS_DECI[38].NST = STATE + 5'd1;
		CLASS_DECI[38].LST = 1;
		CLASS_DECI[38].ILI = 0;
		
begin
begin
begin //CMPI IW,Rd
unique case (1'b1)
STATE_OH[0]: begin
CLASS_DECI[38].IWL = IW_WORD;
CLASS_DECI[38].LST = 0;
end
default: begin //(Rd+IW->Rd)
CLASS_DECI[38].AIA = '{IMM_K , CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[38].AIB = '{IMM_IW, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[38].ALU = '{ALUOP_ADD, {3'b000,IC[6]}, 1'b0};
CLASS_DECI[38].RWA = '{RS_ALU, ~IC[6]};
CLASS_DECI[38].STW = {STU_ALU, AFU_NCZV};
CLASS_DECI[38].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[38].R = CLASS_DECI[38].R | IC[4];
		CLASS_DECI[38].RD = CLASS_DECI[38].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[38].RS = CLASS_DECI[38].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[38].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 39.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[39].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[39].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[39].R = 0;
		CLASS_DECI[39].M = 0;
		CLASS_DECI[39].F = IC[9];
		CLASS_DECI[39].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[39].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[39].FT = '{FSI_32, 1'b0};
		CLASS_DECI[39].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[39].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[39].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[39].IWL = IW_NONE;
		CLASS_DECI[39].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[39].MMS = 0;
		CLASS_DECI[39].MMA = 0;
		CLASS_DECI[39].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[39].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[39].JC = JC_NONE;
		CLASS_DECI[39].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[39].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[39].PIXO = '{PATS_NULL};
		CLASS_DECI[39].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[39].PCS = PCS_NONE;
		CLASS_DECI[39].PCW = 1;
		CLASS_DECI[39].NST = STATE + 5'd1;
		CLASS_DECI[39].LST = 1;
		CLASS_DECI[39].ILI = 0;
		
begin
begin
begin //CMPI IL,Rd
unique case (1'b1)
STATE_OH[0]: begin
CLASS_DECI[39].IWL = IW_LONG;
CLASS_DECI[39].LST = 0;
end
default: begin //(Rd+IL->Rd)
CLASS_DECI[39].AIA = '{IMM_K , CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[39].AIB = '{IMM_IL, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[39].ALU = '{ALUOP_ADD, {3'b000,IC[6]}, 1'b0};
CLASS_DECI[39].RWA = '{RS_ALU, ~IC[6]};
CLASS_DECI[39].STW = {STU_ALU, AFU_NCZV};
CLASS_DECI[39].LST = 1;
end
endcase
end
//							4'b010x:	begin //CMPI IW,Rd
//								case (STATE)
//									5'd0: begin
//										CLASS_DECI[39].IWL = IW_WORD;
//										CLASS_DECI[39].LST = 0;
//									end
//									default: begin //(Rd-IW)
//										CLASS_DECI[39].AIA = '{IMM_K , CV_0 , AS_REGA, EO_NONE};
//										CLASS_DECI[39].AIB = '{IMM_IW, CV_0 , AS_IMM , EO_NONE};
//										CLASS_DECI[39].ALU = '{ALUOP_ADD, 4'b0001, 1'b0};
//										CLASS_DECI[39].STW = {STU_ALU, AFU_NCZV};
//										CLASS_DECI[39].LST = 1;
//									end
//								endcase
//							end
//							4'b011x:	begin //CMPI IL,Rd
//								case (STATE)
//									5'd0: begin
//										CLASS_DECI[39].IWL = IW_LONG;
//										CLASS_DECI[39].LST = 0;
//									end
//									default: begin //(Rd-IL)
//										CLASS_DECI[39].AIA = '{IMM_K , CV_0 , AS_REGA, EO_NONE};
//										CLASS_DECI[39].AIB = '{IMM_IL, CV_0 , AS_IMM , EO_NONE};
//										CLASS_DECI[39].ALU = '{ALUOP_ADD, 4'b0001, 1'b0};
//										CLASS_DECI[39].STW = {STU_ALU, AFU_NCZV};
//										CLASS_DECI[39].LST = 1;
//									end
//								endcase
//							end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[39].R = CLASS_DECI[39].R | IC[4];
		CLASS_DECI[39].RD = CLASS_DECI[39].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[39].RS = CLASS_DECI[39].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[39].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 40.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[40].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[40].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[40].R = 0;
		CLASS_DECI[40].M = 0;
		CLASS_DECI[40].F = IC[9];
		CLASS_DECI[40].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[40].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[40].FT = '{FSI_32, 1'b0};
		CLASS_DECI[40].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[40].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[40].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[40].IWL = IW_NONE;
		CLASS_DECI[40].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[40].MMS = 0;
		CLASS_DECI[40].MMA = 0;
		CLASS_DECI[40].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[40].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[40].JC = JC_NONE;
		CLASS_DECI[40].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[40].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[40].PIXO = '{PATS_NULL};
		CLASS_DECI[40].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[40].PCS = PCS_NONE;
		CLASS_DECI[40].PCW = 1;
		CLASS_DECI[40].NST = STATE + 5'd1;
		CLASS_DECI[40].LST = 1;
		CLASS_DECI[40].ILI = 0;
		
begin
begin
begin //XORI IL,Rd
unique case (1'b1)
STATE_OH[0]: begin
CLASS_DECI[40].IWL = IW_LONG;
CLASS_DECI[40].LST = 0;
end
default: begin //(Rd&~IL->Rd)
CLASS_DECI[40].AIA = '{IMM_K , CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[40].AIB = '{IMM_IL, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[40].ALU = '{ALUOP_LOG, {1'b0,IC[6:5],~|IC[6:5]}, 1'b0};
CLASS_DECI[40].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[40].STW = {STU_ALU, AFU_Z};
CLASS_DECI[40].LST = 1;
end
endcase
end
//							4'b101x:	begin //ORI IL,Rd
//								case (STATE)
//									5'd0: begin
//										CLASS_DECI[40].IWL = IW_LONG;
//										CLASS_DECI[40].LST = 0;
//									end
//									default: begin //(Rd|IL->Rd)
//										CLASS_DECI[40].AIA = '{IMM_K , CV_0 , AS_REGA, EO_NONE};
//										CLASS_DECI[40].AIB = '{IMM_IL, CV_0 , AS_IMM , EO_NONE};
//										CLASS_DECI[40].ALU = '{ALUOP_LOG, 4'b0010, 1'b0};
//										CLASS_DECI[40].RWA = '{RS_ALU, 1'b1};
//										CLASS_DECI[40].STW = {STU_ALU, AFU_Z};
//										CLASS_DECI[40].LST = 1;
//									end
//								endcase
//							end
//							4'b110x:	begin //XORI IL,Rd
//								case (STATE)
//									5'd0: begin
//										CLASS_DECI[40].IWL = IW_LONG;
//										CLASS_DECI[40].LST = 0;
//									end
//									default: begin //(Rd^IL->Rd)
//										CLASS_DECI[40].AIA = '{IMM_K , CV_0 , AS_REGA, EO_NONE};
//										CLASS_DECI[40].AIB = '{IMM_IL, CV_0 , AS_IMM , EO_NONE};
//										CLASS_DECI[40].ALU = '{ALUOP_LOG, 4'b0100, 1'b0};
//										CLASS_DECI[40].RWA = '{RS_ALU, 1'b1};
//										CLASS_DECI[40].STW = {STU_ALU, AFU_Z};
//										CLASS_DECI[40].LST = 1;
//									end
//								endcase
//							end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[40].R = CLASS_DECI[40].R | IC[4];
		CLASS_DECI[40].RD = CLASS_DECI[40].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[40].RS = CLASS_DECI[40].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[40].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 41.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[41].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[41].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[41].R = 0;
		CLASS_DECI[41].M = 0;
		CLASS_DECI[41].F = IC[9];
		CLASS_DECI[41].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[41].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[41].FT = '{FSI_32, 1'b0};
		CLASS_DECI[41].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[41].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[41].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[41].IWL = IW_NONE;
		CLASS_DECI[41].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[41].MMS = 0;
		CLASS_DECI[41].MMA = 0;
		CLASS_DECI[41].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[41].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[41].JC = JC_NONE;
		CLASS_DECI[41].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[41].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[41].PIXO = '{PATS_NULL};
		CLASS_DECI[41].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[41].PCS = PCS_NONE;
		CLASS_DECI[41].PCW = 1;
		CLASS_DECI[41].NST = STATE + 5'd1;
		CLASS_DECI[41].LST = 1;
		CLASS_DECI[41].ILI = 0;
		
begin
begin
begin //SUBI IW,Rd
unique case (1'b1)
STATE_OH[0]: begin
CLASS_DECI[41].IWL = IW_WORD;
CLASS_DECI[41].LST = 0;
end
default: begin //(Rd-IW->Rd)
CLASS_DECI[41].AIA = '{IMM_K , CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[41].AIB = '{IMM_IW, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[41].ALU = '{ALUOP_ADD, 4'b0001, 1'b0};
CLASS_DECI[41].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[41].STW = {STU_ALU, AFU_NCZV};
CLASS_DECI[41].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[41].R = CLASS_DECI[41].R | IC[4];
		CLASS_DECI[41].RD = CLASS_DECI[41].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[41].RS = CLASS_DECI[41].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[41].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 42.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[42].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[42].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[42].R = 0;
		CLASS_DECI[42].M = 0;
		CLASS_DECI[42].F = IC[9];
		CLASS_DECI[42].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[42].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[42].FT = '{FSI_32, 1'b0};
		CLASS_DECI[42].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[42].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[42].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[42].IWL = IW_NONE;
		CLASS_DECI[42].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[42].MMS = 0;
		CLASS_DECI[42].MMA = 0;
		CLASS_DECI[42].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[42].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[42].JC = JC_NONE;
		CLASS_DECI[42].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[42].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[42].PIXO = '{PATS_NULL};
		CLASS_DECI[42].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[42].PCS = PCS_NONE;
		CLASS_DECI[42].PCW = 1;
		CLASS_DECI[42].NST = STATE + 5'd1;
		CLASS_DECI[42].LST = 1;
		CLASS_DECI[42].ILI = 0;
		
begin
begin
begin //ADDXYI IL,Rd
unique case (1'b1)
STATE_OH[0]: begin
CLASS_DECI[42].IWL = IW_LONG;
CLASS_DECI[42].LST = 0;
end
default: begin //(Rd.XY+IL->Rd.XY)
CLASS_DECI[42].AIA = '{IMM_K , CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[42].AIB = '{IMM_IL, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[42].ALU = '{ALUOP_ADDXY, 4'b0000, 1'b0};
CLASS_DECI[42].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[42].STW = {STU_ALU, AFU_NCZV};
CLASS_DECI[42].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[42].R = CLASS_DECI[42].R | IC[4];
		CLASS_DECI[42].RD = CLASS_DECI[42].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[42].RS = CLASS_DECI[42].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[42].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 43.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[43].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[43].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[43].R = 0;
		CLASS_DECI[43].M = 0;
		CLASS_DECI[43].F = IC[9];
		CLASS_DECI[43].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[43].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[43].FT = '{FSI_32, 1'b0};
		CLASS_DECI[43].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[43].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[43].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[43].IWL = IW_NONE;
		CLASS_DECI[43].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[43].MMS = 0;
		CLASS_DECI[43].MMA = 0;
		CLASS_DECI[43].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[43].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[43].JC = JC_NONE;
		CLASS_DECI[43].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[43].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[43].PIXO = '{PATS_NULL};
		CLASS_DECI[43].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[43].PCS = PCS_NONE;
		CLASS_DECI[43].PCW = 1;
		CLASS_DECI[43].NST = STATE + 5'd1;
		CLASS_DECI[43].LST = 1;
		CLASS_DECI[43].ILI = 0;
		
begin
begin
begin //SUBI IL,Rd
unique case (1'b1)
STATE_OH[0]: begin
CLASS_DECI[43].IWL = IW_LONG;
CLASS_DECI[43].LST = 0;
end
default: begin //(Rd-IL->Rd)
CLASS_DECI[43].AIA = '{IMM_K , CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[43].AIB = '{IMM_IL, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[43].ALU = '{ALUOP_ADD, 4'b0001, 1'b0};
CLASS_DECI[43].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[43].STW = {STU_ALU, AFU_NCZV};
CLASS_DECI[43].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[43].R = CLASS_DECI[43].R | IC[4];
		CLASS_DECI[43].RD = CLASS_DECI[43].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[43].RS = CLASS_DECI[43].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[43].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 44.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[44].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[44].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[44].R = 0;
		CLASS_DECI[44].M = 0;
		CLASS_DECI[44].F = IC[9];
		CLASS_DECI[44].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[44].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[44].FT = '{FSI_32, 1'b0};
		CLASS_DECI[44].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[44].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[44].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[44].IWL = IW_NONE;
		CLASS_DECI[44].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[44].MMS = 0;
		CLASS_DECI[44].MMA = 0;
		CLASS_DECI[44].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[44].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[44].JC = JC_NONE;
		CLASS_DECI[44].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[44].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[44].PIXO = '{PATS_NULL};
		CLASS_DECI[44].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[44].PCS = PCS_NONE;
		CLASS_DECI[44].PCW = 1;
		CLASS_DECI[44].NST = STATE + 5'd1;
		CLASS_DECI[44].LST = 1;
		CLASS_DECI[44].ILI = 0;
		
begin
begin
begin //CALLR Addr
unique case (1'b1)
STATE_OH[0]: begin	//SP-32->SP
CLASS_DECI[44].RD = 4'hF; rd_keep = 0;
CLASS_DECI[44].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[44].AIB = '{IMM_K, CV_32, AS_CONST, EO_NONE};
CLASS_DECI[44].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[44].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[44].IWL = IW_WORD;
CLASS_DECI[44].LST = 0;
end
STATE_OH[1]: begin	//PC->*SP,PC+IW->PC
CLASS_DECI[44].RD = 4'hF; rd_keep = 0;
CLASS_DECI[44].MC = '{MAS_RA, MDS_PC, MA_WRITE, MT_DATA};
CLASS_DECI[44].PCS = PCS_IW;
CLASS_DECI[44].LST = 0;
end
default: begin
CLASS_DECI[44].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[44].R = CLASS_DECI[44].R | IC[4];
		CLASS_DECI[44].RD = CLASS_DECI[44].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[44].RS = CLASS_DECI[44].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[44].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 45.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[45].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[45].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[45].R = 0;
		CLASS_DECI[45].M = 0;
		CLASS_DECI[45].F = IC[9];
		CLASS_DECI[45].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[45].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[45].FT = '{FSI_32, 1'b0};
		CLASS_DECI[45].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[45].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[45].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[45].IWL = IW_NONE;
		CLASS_DECI[45].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[45].MMS = 0;
		CLASS_DECI[45].MMA = 0;
		CLASS_DECI[45].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[45].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[45].JC = JC_NONE;
		CLASS_DECI[45].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[45].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[45].PIXO = '{PATS_NULL};
		CLASS_DECI[45].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[45].PCS = PCS_NONE;
		CLASS_DECI[45].PCW = 1;
		CLASS_DECI[45].NST = STATE + 5'd1;
		CLASS_DECI[45].LST = 1;
		CLASS_DECI[45].ILI = 0;
		
begin
begin
begin //CALLA Addr
unique case (1'b1)
STATE_OH[0]: begin	//SP-32->SP
CLASS_DECI[45].RD = 4'hF; rd_keep = 0;
CLASS_DECI[45].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[45].AIB = '{IMM_K, CV_32, AS_CONST, EO_NONE};
CLASS_DECI[45].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[45].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[45].IWL = IW_LONG;
CLASS_DECI[45].LST = 0;
end
STATE_OH[1]: begin	//PC->*SP,IL->PC
CLASS_DECI[45].RD = 4'hF; rd_keep = 0;
CLASS_DECI[45].MC = '{MAS_RA, MDS_PC, MA_WRITE, MT_DATA};
CLASS_DECI[45].PCS = PCS_IL;
CLASS_DECI[45].LST = 0;
end
default: begin
CLASS_DECI[45].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[45].R = CLASS_DECI[45].R | IC[4];
		CLASS_DECI[45].RD = CLASS_DECI[45].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[45].RS = CLASS_DECI[45].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[45].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 46.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[46].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[46].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[46].R = 0;
		CLASS_DECI[46].M = 0;
		CLASS_DECI[46].F = IC[9];
		CLASS_DECI[46].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[46].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[46].FT = '{FSI_32, 1'b0};
		CLASS_DECI[46].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[46].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[46].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[46].IWL = IW_NONE;
		CLASS_DECI[46].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[46].MMS = 0;
		CLASS_DECI[46].MMA = 0;
		CLASS_DECI[46].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[46].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[46].JC = JC_NONE;
		CLASS_DECI[46].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[46].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[46].PIXO = '{PATS_NULL};
		CLASS_DECI[46].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[46].PCS = PCS_NONE;
		CLASS_DECI[46].PCW = 1;
		CLASS_DECI[46].NST = STATE + 5'd1;
		CLASS_DECI[46].LST = 1;
		CLASS_DECI[46].ILI = 0;
		
begin
begin
begin //EINT
unique case (1'b1)
STATE_OH[0]: begin
CLASS_DECI[46].STW = {STU_IE, 4'b0000};
CLASS_DECI[46].LST = 0;
end
STATE_OH[1]: CLASS_DECI[46].LST = 0;
default: CLASS_DECI[46].LST = 1;
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[46].R = CLASS_DECI[46].R | IC[4];
		CLASS_DECI[46].RD = CLASS_DECI[46].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[46].RS = CLASS_DECI[46].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[46].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 47.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[47].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[47].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[47].R = 0;
		CLASS_DECI[47].M = 0;
		CLASS_DECI[47].F = IC[9];
		CLASS_DECI[47].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[47].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[47].FT = '{FSI_32, 1'b0};
		CLASS_DECI[47].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[47].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[47].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[47].IWL = IW_NONE;
		CLASS_DECI[47].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[47].MMS = 0;
		CLASS_DECI[47].MMA = 0;
		CLASS_DECI[47].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[47].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[47].JC = JC_NONE;
		CLASS_DECI[47].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[47].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[47].PIXO = '{PATS_NULL};
		CLASS_DECI[47].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[47].PCS = PCS_NONE;
		CLASS_DECI[47].PCW = 1;
		CLASS_DECI[47].NST = STATE + 5'd1;
		CLASS_DECI[47].LST = 1;
		CLASS_DECI[47].ILI = 0;
		
begin
begin
begin //DSJ Rd,Addr
unique case (1'b1)
STATE_OH[0]: begin	//Rd-1->Rd
CLASS_DECI[47].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[47].AIB = '{IMM_K, CV_1 , AS_CONST, EO_NONE};
CLASS_DECI[47].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[47].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[47].IWL = IW_WORD;
CLASS_DECI[47].LST = 0;
end
STATE_OH[1]: begin	//PC+IW->PC
CLASS_DECI[47].JC = JC_DS;
CLASS_DECI[47].PCS = PCS_IW;
CLASS_DECI[47].LST = ~DS_COND;
end
default: begin
CLASS_DECI[47].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[47].R = CLASS_DECI[47].R | IC[4];
		CLASS_DECI[47].RD = CLASS_DECI[47].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[47].RS = CLASS_DECI[47].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[47].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 48.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[48].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[48].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[48].R = 0;
		CLASS_DECI[48].M = 0;
		CLASS_DECI[48].F = IC[9];
		CLASS_DECI[48].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[48].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[48].FT = '{FSI_32, 1'b0};
		CLASS_DECI[48].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[48].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[48].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[48].IWL = IW_NONE;
		CLASS_DECI[48].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[48].MMS = 0;
		CLASS_DECI[48].MMA = 0;
		CLASS_DECI[48].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[48].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[48].JC = JC_NONE;
		CLASS_DECI[48].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[48].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[48].PIXO = '{PATS_NULL};
		CLASS_DECI[48].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[48].PCS = PCS_NONE;
		CLASS_DECI[48].PCW = 1;
		CLASS_DECI[48].NST = STATE + 5'd1;
		CLASS_DECI[48].LST = 1;
		CLASS_DECI[48].ILI = 0;
		
begin
begin
begin //DSJEQ Rd,Addr
unique case (1'b1)
STATE_OH[0]: begin	//Rd-1->Rd
CLASS_DECI[48].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[48].AIB = '{IMM_K, CV_1 , AS_CONST, EO_NONE};
CLASS_DECI[48].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[48].RWA = '{RS_ALU, DS_COND};
CLASS_DECI[48].IWL = IW_WORD;
CLASS_DECI[48].NST = DS_COND ? 5'd1 : 5'd2;
CLASS_DECI[48].LST = 0;
end
STATE_OH[1]: begin	//PC+IW->PC
CLASS_DECI[48].JC = JC_DS;
CLASS_DECI[48].PCS = PCS_IW;
CLASS_DECI[48].LST = ~DS_COND;
end
default: begin
CLASS_DECI[48].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[48].R = CLASS_DECI[48].R | IC[4];
		CLASS_DECI[48].RD = CLASS_DECI[48].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[48].RS = CLASS_DECI[48].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[48].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 49.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[49].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[49].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[49].R = 0;
		CLASS_DECI[49].M = 0;
		CLASS_DECI[49].F = IC[9];
		CLASS_DECI[49].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[49].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[49].FT = '{FSI_32, 1'b0};
		CLASS_DECI[49].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[49].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[49].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[49].IWL = IW_NONE;
		CLASS_DECI[49].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[49].MMS = 0;
		CLASS_DECI[49].MMA = 0;
		CLASS_DECI[49].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[49].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[49].JC = JC_NONE;
		CLASS_DECI[49].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[49].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[49].PIXO = '{PATS_NULL};
		CLASS_DECI[49].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[49].PCS = PCS_NONE;
		CLASS_DECI[49].PCW = 1;
		CLASS_DECI[49].NST = STATE + 5'd1;
		CLASS_DECI[49].LST = 1;
		CLASS_DECI[49].ILI = 0;
		
begin
begin
begin //DSJNE Rd,Addr
unique case (1'b1)
STATE_OH[0]: begin	//Rd-1->Rd
CLASS_DECI[49].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[49].AIB = '{IMM_K, CV_1 , AS_CONST, EO_NONE};
CLASS_DECI[49].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[49].RWA = '{RS_ALU, ~DS_COND};
CLASS_DECI[49].IWL = IW_WORD;
CLASS_DECI[49].NST = !DS_COND ? 5'd1 : 5'd2;
CLASS_DECI[49].LST = 0;
end
STATE_OH[1]: begin	//PC+IW->PC
CLASS_DECI[49].JC = JC_DS;
CLASS_DECI[49].PCS = PCS_IW;
CLASS_DECI[49].LST = ~DS_COND;
end
default: begin
CLASS_DECI[49].LST = 1;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[49].R = CLASS_DECI[49].R | IC[4];
		CLASS_DECI[49].RD = CLASS_DECI[49].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[49].RS = CLASS_DECI[49].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[49].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 50.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[50].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[50].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[50].R = 0;
		CLASS_DECI[50].M = 0;
		CLASS_DECI[50].F = IC[9];
		CLASS_DECI[50].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[50].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[50].FT = '{FSI_32, 1'b0};
		CLASS_DECI[50].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[50].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[50].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[50].IWL = IW_NONE;
		CLASS_DECI[50].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[50].MMS = 0;
		CLASS_DECI[50].MMA = 0;
		CLASS_DECI[50].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[50].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[50].JC = JC_NONE;
		CLASS_DECI[50].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[50].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[50].PIXO = '{PATS_NULL};
		CLASS_DECI[50].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[50].PCS = PCS_NONE;
		CLASS_DECI[50].PCW = 1;
		CLASS_DECI[50].NST = STATE + 5'd1;
		CLASS_DECI[50].LST = 1;
		CLASS_DECI[50].ILI = 0;
		
begin
begin
begin //SETC
CLASS_DECI[50].STW = {STU_C, 4'b0000};
CLASS_DECI[50].LST = 1;
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[50].R = CLASS_DECI[50].R | IC[4];
		CLASS_DECI[50].RD = CLASS_DECI[50].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[50].RS = CLASS_DECI[50].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[50].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 51.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[51].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[51].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[51].R = 0;
		CLASS_DECI[51].M = 0;
		CLASS_DECI[51].F = IC[9];
		CLASS_DECI[51].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[51].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[51].FT = '{FSI_32, 1'b0};
		CLASS_DECI[51].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[51].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[51].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[51].IWL = IW_NONE;
		CLASS_DECI[51].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[51].MMS = 0;
		CLASS_DECI[51].MMA = 0;
		CLASS_DECI[51].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[51].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[51].JC = JC_NONE;
		CLASS_DECI[51].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[51].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[51].PIXO = '{PATS_NULL};
		CLASS_DECI[51].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[51].PCS = PCS_NONE;
		CLASS_DECI[51].PCW = 1;
		CLASS_DECI[51].NST = STATE + 5'd1;
		CLASS_DECI[51].LST = 1;
		CLASS_DECI[51].ILI = 0;
		
begin
begin
begin //PIXBLT L,L; PIXBLT L,XY (B14.XY-curr pos)
unique case (1'b1)
STATE_OH[0]: begin //WinAdjust(B7.XY)->PIX_DYDX
CLASS_DECI[51].RD = 4'd7; rd_keep = 0;
CLASS_DECI[51].RS = 4'd7; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[51].R = 1;
CLASS_DECI[51].PF = '{PBLT_NONE, POFFS_NONE, WIN_INIT, PLN_NONE};
CLASS_DECI[51].NST = IC[5] && PIX_WINEN ? 5'd1 : 5'd8;
CLASS_DECI[51].LST = 0;
end
STATE_OH[1]: begin //B2.XY->B14.XY
CLASS_DECI[51].RD = 4'd14; rd_keep = 0;
CLASS_DECI[51].RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[51].R = 1;
CLASS_DECI[51].RWA = '{RS_REGB, 1'b1};
CLASS_DECI[51].LST = 0;
end
STATE_OH[2]: begin //B14.XY+B7.XY->B14.XY
CLASS_DECI[51].RD = 4'd14; rd_keep = 0;
CLASS_DECI[51].RS = 4'd7; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[51].R = 1;
CLASS_DECI[51].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[51].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[51].ALU = '{ALUOP_ADDXY, 4'b0000, 1'b0};
CLASS_DECI[51].RWA = '{RS_ALU, 1'b1};
//										CLASS_DECI[51].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
CLASS_DECI[51].LST = 0;
end
STATE_OH[3]: begin //CPW B14.XY,WSTART,WEND
CLASS_DECI[51].RD = 4'd14; rd_keep = 0;
CLASS_DECI[51].RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[51].R = 1;
CLASS_DECI[51].PF = '{PBLT_NONE, POFFS_NONE, WIN_CHECK, PLN_NONE};
CLASS_DECI[51].LST = 0;
end
STATE_OH[4]: begin //Clip the saved extent using B14's exclusive far corner
CLASS_DECI[51].RD = 4'd7; rd_keep = 0;
CLASS_DECI[51].RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[51].R = 1;
CLASS_DECI[51].PF = '{PBLT_NONE, POFFS_NONE, WIN_DADJ, PLN_NONE};
CLASS_DECI[51].LST = (|PIX_WINCC) & PIX_WINEN;
end
STATE_OH[5]: begin //XYWinOffset(B2.XY)->B14.XY
CLASS_DECI[51].RD = 4'd14; rd_keep = 0;
CLASS_DECI[51].RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[51].R = 1;
CLASS_DECI[51].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[51].AIB = '{IMM_K, CV_0 , AS_PIX  , EO_NONE};
CLASS_DECI[51].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[51].PALU = '{PIXOP_WSTA, PIXAS_REGB, CNVS_NO};
CLASS_DECI[51].RWA = '{RS_ALU, 1'b1};
//										CLASS_DECI[51].PF = '{PBLT_NONE, POFFS_NONE, WIN_CHECK, PLN_NONE};
CLASS_DECI[51].LST = 0;
end
STATE_OH[6]: begin  //B0+XYToL(B14.XY)->B0
CLASS_DECI[51].RD = 4'd0; rd_keep = 0;
CLASS_DECI[51].RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[51].R = 1;
CLASS_DECI[51].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[51].AIB = '{IMM_K, CV_0 , AS_PIX , EO_NONE};
CLASS_DECI[51].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[51].PALU = '{PIXOP_XYL, PIXAS_REGB, CNVS_SP};
CLASS_DECI[51].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[51].LST = 0;
end
STATE_OH[7]: begin //B2.XY+B14.XY->B2.XY
CLASS_DECI[51].RD = 4'd2; rd_keep = 0;
CLASS_DECI[51].RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[51].R = 1;
CLASS_DECI[51].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[51].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[51].ALU = '{ALUOP_ADDXY, 4'b0000, 1'b0};
CLASS_DECI[51].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[51].LST = 0;
end
STATE_OH[8]: begin //0->B14.XY
CLASS_DECI[51].RD = 4'd14; rd_keep = 0;
CLASS_DECI[51].RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[51].R = 1;
CLASS_DECI[51].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[51].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[51].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[51].RWA = '{RS_ALU, 1'b1};
//										CLASS_DECI[51].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
CLASS_DECI[51].LST = 0;
end
STATE_OH[9]: begin //B0+B1->SOFFS
CLASS_DECI[51].RD = 4'd0; rd_keep = 0;
CLASS_DECI[51].RS = 4'd1; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[51].R = 1;
CLASS_DECI[51].PALU = '{PIXOP_NOP, PIXAS_REGB, CNVS_SP};
CLASS_DECI[51].PF = '{PBLT_NONE, POFFS_INIT, WIN_NONE, PLN_NONE};
CLASS_DECI[51].NST = IC[5] ? 5'd10 : 5'd12;
CLASS_DECI[51].LST = 0;
end
STATE_OH[10]: begin  //XYToL(B2.XY)->B2 (XY)
CLASS_DECI[51].RD = 4'd2; rd_keep = 0;
CLASS_DECI[51].RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[51].R = 1;
CLASS_DECI[51].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[51].AIB = '{IMM_K, CV_0 , AS_PIX  , EO_NONE};
CLASS_DECI[51].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[51].PALU = '{PIXOP_XYL, PIXAS_REGB, CNVS_DP};
CLASS_DECI[51].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[51].LST = 0;
end
STATE_OH[11]: begin //B2+B4->B2 (XY)
CLASS_DECI[51].RD = 4'd2; rd_keep = 0;
CLASS_DECI[51].RS = 4'd4; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[51].R = 1;
CLASS_DECI[51].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[51].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[51].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[51].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[51].LST = 0;
end
STATE_OH[12]: begin //B2+B3->DOFFS
CLASS_DECI[51].RD = 4'd2; rd_keep = 0;
CLASS_DECI[51].RS = 4'd3; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[51].R = 1;
CLASS_DECI[51].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[51].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[51].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[51].PALU = '{PIXOP_NOP, PIXAS_REGB, CNVS_DP};
CLASS_DECI[51].PF = '{PBLT_NONE, POFFS_INIT, WIN_NONE, PLN_NONE};
//										CLASS_DECI[51].NST = 5'd14;
CLASS_DECI[51].LST = 0;
end
STATE_OH[13]: begin //B2->PPW
CLASS_DECI[51].RD = 4'd2; rd_keep = 0;
CLASS_DECI[51].RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[51].R = 1;
CLASS_DECI[51].PF = '{PBLT_STRT, POFFS_NONE, WIN_NONE, PLN_NONE};
CLASS_DECI[51].LST = 0;
end
STATE_OH[14]: begin	//(*B0->BUF,B0+PW->B0)
CLASS_DECI[51].RD = 4'd0; rd_keep = 0;
//										CLASS_DECI[51].RS = 4'd0;
CLASS_DECI[51].R = 1;
CLASS_DECI[51].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[51].AIB = '{IMM_K, CV_0 , AS_PIX , EO_NONE};
CLASS_DECI[51].FT = '{FSI_PW, 1'b0};
CLASS_DECI[51].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[51].PALU = '{PIXOP_PPW, PIXAS_REGB, CNVS_NO};
CLASS_DECI[51].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[51].MC = '{MAS_RA, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[51].NST = 5'd16;
CLASS_DECI[51].LST = 0;
end
STATE_OH[15]: begin //
CLASS_DECI[51].LST = 0;
end
STATE_OH[16]: begin	//B14.XY+XStep()->B14.XY, B14.XY>=PIX_DYDX
CLASS_DECI[51].RD = 4'd14; rd_keep = 0;
CLASS_DECI[51].RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[51].R = 1;
CLASS_DECI[51].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[51].AIB = '{IMM_K, CV_0 , AS_PIX , EO_NONE};
CLASS_DECI[51].ALU = '{ALUOP_ADDXY, 4'b1000, 1'b0};
CLASS_DECI[51].PALU = '{PIXOP_XYS, PIXAS_REGB, CNVS_DP};
CLASS_DECI[51].PF = '{PBLT_NEXT, POFFS_NONE, WIN_NONE, PLN_NONE};
CLASS_DECI[51].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[51].NST = 5'd18;
CLASS_DECI[51].LST = 0;
end
STATE_OH[17]: begin	//
CLASS_DECI[51].LST = 0;
end
STATE_OH[18]: begin	//(PAT->*B2,B2+PW->B2)
CLASS_DECI[51].RD = 4'd2; rd_keep = 0;
//										CLASS_DECI[51].RS = 4'd14;
CLASS_DECI[51].R = 1;
CLASS_DECI[51].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[51].AIB = '{IMM_K, CV_0 , AS_PIX , EO_NONE};
CLASS_DECI[51].FT = '{FSI_PW, 1'b0};
CLASS_DECI[51].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[51].PALU = '{PIXOP_PPW, PIXAS_REGB, CNVS_NO};
CLASS_DECI[51].PF = '{PBLT_DRAW, POFFS_NONE, WIN_NONE, PLN_NONE};
CLASS_DECI[51].PIXO = '{PATS_MEM};
CLASS_DECI[51].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[51].MC = '{MAS_RA, MDS_PIX, MA_WRITE, MT_PIX};
CLASS_DECI[51].NST = PIX_XEND ? 5'd19 : 5'd14;
CLASS_DECI[51].LST = 0;
end
STATE_OH[19]: begin //0+SOFFS->B0, SOFFS+B1->SOFFS
CLASS_DECI[51].RD = 4'd0; rd_keep = 0;
CLASS_DECI[51].RS = 4'd1; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[51].R = 1;
CLASS_DECI[51].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[51].AIB = '{IMM_K, CV_0 , AS_PIX  , EO_NONE};
CLASS_DECI[51].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[51].PALU = '{PIXOP_OFFS, PIXAS_REGB, CNVS_SP};
CLASS_DECI[51].PF = '{PBLT_NONE, POFFS_NEXT, WIN_NONE, PLN_NONE};
CLASS_DECI[51].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[51].LST = 0;
end
default: begin	//0+DOFFS->B2, DOFFS+B3->DOFFS
CLASS_DECI[51].RD = 4'd2; rd_keep = 0;
CLASS_DECI[51].RS = 4'd3; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[51].R = 1;
CLASS_DECI[51].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[51].AIB = '{IMM_K, CV_0 , AS_PIX  , EO_NONE};
CLASS_DECI[51].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[51].PALU = '{PIXOP_OFFS, PIXAS_REGB, CNVS_DP};
CLASS_DECI[51].PF = '{PBLT_NONE, POFFS_NEXT, WIN_NONE, PLN_NONE};
CLASS_DECI[51].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[51].NST = 5'd13;
CLASS_DECI[51].LST = PIX_YEND;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[51].R = CLASS_DECI[51].R | IC[4];
		CLASS_DECI[51].RD = CLASS_DECI[51].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[51].RS = CLASS_DECI[51].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[51].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 52.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[52].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[52].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[52].R = 0;
		CLASS_DECI[52].M = 0;
		CLASS_DECI[52].F = IC[9];
		CLASS_DECI[52].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[52].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[52].FT = '{FSI_32, 1'b0};
		CLASS_DECI[52].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[52].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[52].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[52].IWL = IW_NONE;
		CLASS_DECI[52].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[52].MMS = 0;
		CLASS_DECI[52].MMA = 0;
		CLASS_DECI[52].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[52].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[52].JC = JC_NONE;
		CLASS_DECI[52].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[52].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[52].PIXO = '{PATS_NULL};
		CLASS_DECI[52].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[52].PCS = PCS_NONE;
		CLASS_DECI[52].PCW = 1;
		CLASS_DECI[52].NST = STATE + 5'd1;
		CLASS_DECI[52].LST = 1;
		CLASS_DECI[52].ILI = 0;
		
begin
begin
begin //PIXBLT B,L; PIXBLT B,XY (B14.XY-curr pos)
unique case (1'b1)
STATE_OH[0]: begin //WinAdjust(B7.XY)->PIX_DYDX
CLASS_DECI[52].RD = 4'd7; rd_keep = 0;
CLASS_DECI[52].RS = 4'd7; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[52].R = 1;
CLASS_DECI[52].PF = '{PBLT_NONE, POFFS_NONE, WIN_INIT, PLN_NONE};
CLASS_DECI[52].NST = IC[5] && PIX_WINEN ? 5'd1 : 5'd8;
CLASS_DECI[52].LST = 0;
end
STATE_OH[1]: begin //B2.XY->B14.XY
CLASS_DECI[52].RD = 4'd14; rd_keep = 0;
CLASS_DECI[52].RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[52].R = 1;
CLASS_DECI[52].RWA = '{RS_REGB, 1'b1};
CLASS_DECI[52].LST = 0;
end
STATE_OH[2]: begin //B14.XY+B7.XY->B14.XY
CLASS_DECI[52].RD = 4'd14; rd_keep = 0;
CLASS_DECI[52].RS = 4'd7; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[52].R = 1;
CLASS_DECI[52].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[52].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[52].ALU = '{ALUOP_ADDXY, 4'b0000, 1'b0};
CLASS_DECI[52].RWA = '{RS_ALU, 1'b1};
//										CLASS_DECI[52].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
CLASS_DECI[52].LST = 0;
end
STATE_OH[3]: begin //CPW B14.XY,WSTART,WEND
CLASS_DECI[52].RD = 4'd14; rd_keep = 0;
CLASS_DECI[52].RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[52].R = 1;
CLASS_DECI[52].PF = '{PBLT_NONE, POFFS_NONE, WIN_CHECK, PLN_NONE};
CLASS_DECI[52].LST = 0;
end
STATE_OH[4]: begin //Clip the saved extent using B14's exclusive far corner
CLASS_DECI[52].RD = 4'd7; rd_keep = 0;
CLASS_DECI[52].RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[52].R = 1;
CLASS_DECI[52].PF = '{PBLT_NONE, POFFS_NONE, WIN_DADJ, PLN_NONE};
CLASS_DECI[52].LST = (|PIX_WINCC) & PIX_WINEN;
end
STATE_OH[5]: begin //XYWinOffset(B2.XY)->B14.XY
CLASS_DECI[52].RD = 4'd14; rd_keep = 0;
CLASS_DECI[52].RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[52].R = 1;
CLASS_DECI[52].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[52].AIB = '{IMM_K, CV_0 , AS_PIX  , EO_NONE};
CLASS_DECI[52].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[52].PALU = '{PIXOP_WSTA, PIXAS_REGB, CNVS_NO};
CLASS_DECI[52].RWA = '{RS_ALU, 1'b1};
//										CLASS_DECI[52].PF = '{PBLT_NONE, POFFS_NONE, WIN_CHECK, PLN_NONE};
CLASS_DECI[52].LST = 0;
end
STATE_OH[6]: begin  //B0+XYToL(B14.XY)->B0
CLASS_DECI[52].RD = 4'd0; rd_keep = 0;
CLASS_DECI[52].RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[52].R = 1;
CLASS_DECI[52].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[52].AIB = '{IMM_K, CV_0 , AS_PIX , EO_NONE};
CLASS_DECI[52].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[52].PALU = '{PIXOP_XYL, PIXAS_REGB, CNVS_SP};
CLASS_DECI[52].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[52].LST = 0;
end
STATE_OH[7]: begin //B2.XY+B14.XY->B2.XY
CLASS_DECI[52].RD = 4'd2; rd_keep = 0;
CLASS_DECI[52].RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[52].R = 1;
CLASS_DECI[52].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[52].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[52].ALU = '{ALUOP_ADDXY, 4'b0000, 1'b0};
//										CLASS_DECI[52].PALU = '{PIXOP_NOP, PIXAS_REGB, CNVS_NO};
CLASS_DECI[52].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[52].LST = 0;
end
STATE_OH[8]: begin //0->B14.XY
CLASS_DECI[52].RD = 4'd14; rd_keep = 0;
CLASS_DECI[52].RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[52].R = 1;
CLASS_DECI[52].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[52].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[52].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[52].RWA = '{RS_ALU, 1'b1};
//										CLASS_DECI[52].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
CLASS_DECI[52].LST = 0;
end
STATE_OH[9]: begin //B0+B1->SOFFS
CLASS_DECI[52].RD = 4'd0; rd_keep = 0;
CLASS_DECI[52].RS = 4'd1; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[52].R = 1;
CLASS_DECI[52].PALU = '{PIXOP_NOP, PIXAS_REGB, CNVS_SP};
CLASS_DECI[52].PF = '{PBLT_NONE, POFFS_INIT, WIN_NONE, PLN_NONE};
CLASS_DECI[52].NST = IC[5] ? 5'd10 : 5'd12;
CLASS_DECI[52].LST = 0;
end
STATE_OH[10]: begin  //XYToL(B2.XY)->B2 (XY)
CLASS_DECI[52].RD = 4'd2; rd_keep = 0;
CLASS_DECI[52].RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[52].R = 1;
CLASS_DECI[52].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[52].AIB = '{IMM_K, CV_0 , AS_PIX  , EO_NONE};
CLASS_DECI[52].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[52].PALU = '{PIXOP_XYL, PIXAS_REGB, CNVS_DP};
CLASS_DECI[52].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[52].LST = 0;
end
STATE_OH[11]: begin //XY (B2+B4->B2)
CLASS_DECI[52].RD = 4'd2; rd_keep = 0;
CLASS_DECI[52].RS = 4'd4; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[52].R = 1;
CLASS_DECI[52].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[52].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[52].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[52].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[52].LST = 0;
end
STATE_OH[12]: begin //B2+B3->DOFFS
CLASS_DECI[52].RD = 4'd2; rd_keep = 0;
CLASS_DECI[52].RS = 4'd3; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[52].R = 1;
CLASS_DECI[52].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[52].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[52].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[52].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_DP};
CLASS_DECI[52].PF = '{PBLT_NONE, POFFS_INIT, WIN_NONE, PLN_NONE};
CLASS_DECI[52].LST = 0;
end
STATE_OH[13]: begin //B2->PPW
CLASS_DECI[52].RD = 4'd2; rd_keep = 0;
CLASS_DECI[52].RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[52].R = 1;
CLASS_DECI[52].PF = '{PBLT_STRT, POFFS_NONE, WIN_NONE, PLN_NONE};
CLASS_DECI[52].LST = 0;
end
STATE_OH[14]: begin	//(*B0->BUF,B0+32->B0)
CLASS_DECI[52].RD = 4'd0; rd_keep = 0;
CLASS_DECI[52].RS = 4'd0; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[52].R = 1;
CLASS_DECI[52].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[52].AIB = '{IMM_K, CV_0 , AS_PIX , EO_NONE};
CLASS_DECI[52].FT = '{FSI_32, 1'b0};
CLASS_DECI[52].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[52].PALU = '{PIXOP_PPW, PIXAS_REGB, CNVS_NO};
CLASS_DECI[52].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[52].MC = '{MAS_RA, MDS_REGA, MA_READ, MT_DATA};
//										CLASS_DECI[52].NST = 5'd16;
CLASS_DECI[52].LST = 0;
end
STATE_OH[15]: begin	//BUF->PIX_BIT
CLASS_DECI[52].PF = '{PBLT_BMLD, POFFS_NONE, WIN_NONE, PLN_NONE};
CLASS_DECI[52].LST = 0;
end
STATE_OH[16]: begin	//B14.XY+XStep()->B14.XY, B14.XY>=PIX_DYDX
CLASS_DECI[52].RD = 4'd14; rd_keep = 0;
//										CLASS_DECI[52].RS = 4'd14;
CLASS_DECI[52].R = 1;
CLASS_DECI[52].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[52].AIB = '{IMM_K, CV_0 , AS_PIX , EO_NONE};
CLASS_DECI[52].ALU = '{ALUOP_ADDXY, 4'b1000, 1'b0};
CLASS_DECI[52].PALU = '{PIXOP_XYS, PIXAS_REGB, CNVS_NO};
CLASS_DECI[52].PF = '{PBLT_NEXT, POFFS_NONE, WIN_NONE, PLN_NONE};
CLASS_DECI[52].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[52].NST = 5'd18;
CLASS_DECI[52].LST = 0;
end
STATE_OH[17]: begin	//
CLASS_DECI[52].LST = 0;
end
STATE_OH[18]: begin	//(PAT->*B2,B2+PW->B2)
CLASS_DECI[52].RD = 4'd2; rd_keep = 0;
//										CLASS_DECI[52].RS = 4'd14;
CLASS_DECI[52].R = 1;
CLASS_DECI[52].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[52].AIB = '{IMM_K, CV_0 , AS_PIX , EO_NONE};
CLASS_DECI[52].FT = '{FSI_PW, 1'b0};
CLASS_DECI[52].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[52].PALU = '{PIXOP_PPW, PIXAS_REGB, CNVS_NO};
CLASS_DECI[52].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[52].PF = '{PBLT_DRAW, POFFS_NONE, WIN_NONE, PLN_NONE};
CLASS_DECI[52].PIXO = '{PATS_B};
CLASS_DECI[52].MC = '{MAS_RA, MDS_PIX, MA_WRITE, MT_PIX};
CLASS_DECI[52].NST = PIX_XEND ? 5'd19 : PIX_BL ? 5'd14 : 5'd16;
CLASS_DECI[52].LST = 0;
end
STATE_OH[19]: begin //0+SOFFS->B0, SOFFS+B1->SOFFS
CLASS_DECI[52].RD = 4'd0; rd_keep = 0;
CLASS_DECI[52].RS = 4'd1; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[52].R = 1;
CLASS_DECI[52].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[52].AIB = '{IMM_K, CV_0 , AS_PIX  , EO_NONE};
CLASS_DECI[52].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[52].PALU = '{PIXOP_OFFS, PIXAS_REGB, CNVS_SP};
CLASS_DECI[52].PF = '{PBLT_NONE, POFFS_NEXT, WIN_NONE, PLN_NONE};
CLASS_DECI[52].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[52].LST = 0;
end
default: begin	//0+DOFFS->B2, DOFFS+B3->DOFFS
CLASS_DECI[52].RD = 4'd2; rd_keep = 0;
CLASS_DECI[52].RS = 4'd3; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[52].R = 1;
CLASS_DECI[52].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[52].AIB = '{IMM_K, CV_0 , AS_PIX  , EO_NONE};
CLASS_DECI[52].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[52].PALU = '{PIXOP_OFFS, PIXAS_REGB, CNVS_DP};
CLASS_DECI[52].PF = '{PBLT_NONE, POFFS_NEXT, WIN_NONE, PLN_NONE};
CLASS_DECI[52].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[52].NST = 5'd13;
CLASS_DECI[52].LST = PIX_YEND;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[52].R = CLASS_DECI[52].R | IC[4];
		CLASS_DECI[52].RD = CLASS_DECI[52].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[52].RS = CLASS_DECI[52].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[52].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 53.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[53].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[53].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[53].R = 0;
		CLASS_DECI[53].M = 0;
		CLASS_DECI[53].F = IC[9];
		CLASS_DECI[53].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[53].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[53].FT = '{FSI_32, 1'b0};
		CLASS_DECI[53].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[53].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[53].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[53].IWL = IW_NONE;
		CLASS_DECI[53].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[53].MMS = 0;
		CLASS_DECI[53].MMA = 0;
		CLASS_DECI[53].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[53].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[53].JC = JC_NONE;
		CLASS_DECI[53].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[53].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[53].PIXO = '{PATS_NULL};
		CLASS_DECI[53].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[53].PCS = PCS_NONE;
		CLASS_DECI[53].PCW = 1;
		CLASS_DECI[53].NST = STATE + 5'd1;
		CLASS_DECI[53].LST = 1;
		CLASS_DECI[53].ILI = 0;
		
begin
begin
begin //FILL L; FILL XY
unique case (1'b1)
STATE_OH[0]: begin //WinAdjust(B7.XY)->PIX_DYDX
CLASS_DECI[53].RD = 4'd7; rd_keep = 0;
CLASS_DECI[53].RS = 4'd7; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[53].R = 1;
CLASS_DECI[53].PF = '{PBLT_NONE, POFFS_NONE, WIN_INIT, PLN_NONE};
CLASS_DECI[53].NST = IC[5] && PIX_WINEN ? 5'd1 : 5'd8;
CLASS_DECI[53].LST = 0;
end
STATE_OH[1]: begin //B2.XY->B14.XY
CLASS_DECI[53].RD = 4'd14; rd_keep = 0;
CLASS_DECI[53].RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[53].R = 1;
CLASS_DECI[53].RWA = '{RS_REGB, 1'b1};
CLASS_DECI[53].LST = 0;
end
STATE_OH[2]: begin //B14.XY+B7.XY->B14.XY
CLASS_DECI[53].RD = 4'd14; rd_keep = 0;
CLASS_DECI[53].RS = 4'd7; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[53].R = 1;
CLASS_DECI[53].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[53].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[53].ALU = '{ALUOP_ADDXY, 4'b0000, 1'b0};
CLASS_DECI[53].RWA = '{RS_ALU, 1'b1};
//										CLASS_DECI[53].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
CLASS_DECI[53].LST = 0;
end
STATE_OH[3]: begin //CPW B14.XY,WSTART,WEND
CLASS_DECI[53].RD = 4'd14; rd_keep = 0;
CLASS_DECI[53].RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[53].R = 1;
CLASS_DECI[53].PF = '{PBLT_NONE, POFFS_NONE, WIN_CHECK, PLN_NONE};
CLASS_DECI[53].LST = 0;
end
STATE_OH[4]: begin //Clip the saved extent using B14's exclusive far corner
CLASS_DECI[53].RD = 4'd7; rd_keep = 0;
CLASS_DECI[53].RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[53].R = 1;
CLASS_DECI[53].PF = '{PBLT_NONE, POFFS_NONE, WIN_DADJ, PLN_NONE};
CLASS_DECI[53].LST = (|PIX_WINCC) & PIX_WINEN;
end
STATE_OH[5]: begin //XYWinOffset(B2.XY)->B14.XY
CLASS_DECI[53].RD = 4'd14; rd_keep = 0;
CLASS_DECI[53].RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[53].R = 1;
CLASS_DECI[53].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[53].AIB = '{IMM_K, CV_0 , AS_PIX  , EO_NONE};
CLASS_DECI[53].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[53].PALU = '{PIXOP_WSTA, PIXAS_REGB, CNVS_NO};
CLASS_DECI[53].RWA = '{RS_ALU, 1'b1};
//										CLASS_DECI[53].PF = '{PBLT_NONE, POFFS_NONE, WIN_CHECK, PLN_NONE};
CLASS_DECI[53].LST = 0;
end
STATE_OH[6]: begin  //B0+XYToL(B14.XY)->B0
CLASS_DECI[53].RD = 4'd0; rd_keep = 0;
CLASS_DECI[53].RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[53].R = 1;
CLASS_DECI[53].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[53].AIB = '{IMM_K, CV_0 , AS_PIX , EO_NONE};
CLASS_DECI[53].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[53].PALU = '{PIXOP_XYL, PIXAS_REGB, CNVS_SP};
CLASS_DECI[53].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[53].LST = 0;
end
STATE_OH[7]: begin //B2.XY+B14.XY->B2.XY
CLASS_DECI[53].RD = 4'd2; rd_keep = 0;
CLASS_DECI[53].RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[53].R = 1;
CLASS_DECI[53].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[53].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[53].ALU = '{ALUOP_ADDXY, 4'b0000, 1'b0};
//										CLASS_DECI[53].PALU = '{PIXOP_NOP, PIXAS_REGB, CNVS_NO};
CLASS_DECI[53].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[53].LST = 0;
end
STATE_OH[8]: begin //0->B14.XY
CLASS_DECI[53].RD = 4'd14; rd_keep = 0;
CLASS_DECI[53].RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[53].R = 1;
CLASS_DECI[53].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[53].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[53].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[53].RWA = '{RS_ALU, 1'b1};
//										CLASS_DECI[53].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
CLASS_DECI[53].LST = 0;
end
STATE_OH[9]: begin //B0+B1->SOFFS
CLASS_DECI[53].RD = 4'd0; rd_keep = 0;
CLASS_DECI[53].RS = 4'd1; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[53].R = 1;
CLASS_DECI[53].PALU = '{PIXOP_NOP, PIXAS_REGB, CNVS_SP};
CLASS_DECI[53].PF = '{PBLT_NONE, POFFS_INIT, WIN_NONE, PLN_NONE};
CLASS_DECI[53].NST = IC[5] ? 5'd10 : 5'd12;
CLASS_DECI[53].LST = 0;
end
STATE_OH[10]: begin  //XYToL(B2.XY)->B2 (XY)
CLASS_DECI[53].RD = 4'd2; rd_keep = 0;
CLASS_DECI[53].RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[53].R = 1;
CLASS_DECI[53].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[53].AIB = '{IMM_K, CV_0 , AS_PIX  , EO_NONE};
CLASS_DECI[53].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[53].PALU = '{PIXOP_XYL, PIXAS_REGB, CNVS_DP};
CLASS_DECI[53].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[53].LST = 0;
end
STATE_OH[11]: begin //B2+B4->B2 (XY)
CLASS_DECI[53].RD = 4'd2; rd_keep = 0;
CLASS_DECI[53].RS = 4'd4; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[53].R = 1;
CLASS_DECI[53].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[53].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[53].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[53].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[53].LST = 0;
end
STATE_OH[12]: begin //B2+B3->DOFFS
CLASS_DECI[53].RD = 4'd2; rd_keep = 0;
CLASS_DECI[53].RS = 4'd3; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[53].R = 1;
CLASS_DECI[53].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[53].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[53].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[53].PALU = '{PIXOP_NOP, PIXAS_REGB, CNVS_DP};
CLASS_DECI[53].PF = '{PBLT_NONE, POFFS_INIT, WIN_NONE, PLN_NONE};
CLASS_DECI[53].LST = 0;
end
STATE_OH[13]: begin //B2->PPW
CLASS_DECI[53].RD = 4'd2; rd_keep = 0;
CLASS_DECI[53].RS = 4'd2; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[53].R = 1;
CLASS_DECI[53].PF = '{PBLT_STRT, POFFS_NONE, WIN_NONE, PLN_NONE};
CLASS_DECI[53].LST = 0;
end
STATE_OH[14]: begin	//
CLASS_DECI[53].NST = 5'd16;
CLASS_DECI[53].LST = 0;
end
STATE_OH[15]: begin	//
CLASS_DECI[53].LST = 0;
end
STATE_OH[16]: begin	//B14.XY+XStep()->B14.XY, B14.XY>=PIX_DYDX
CLASS_DECI[53].RD = 4'd14; rd_keep = 0;
CLASS_DECI[53].RS = 4'd14; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[53].R = 1;
CLASS_DECI[53].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[53].AIB = '{IMM_K, CV_0 , AS_PIX , EO_NONE};
CLASS_DECI[53].ALU = '{ALUOP_ADDXY, 4'b1000, 1'b0};
CLASS_DECI[53].PALU = '{PIXOP_XYS, PIXAS_REGB, CNVS_NO};
CLASS_DECI[53].PF = '{PBLT_NEXT, POFFS_NONE, WIN_NONE, PLN_NONE};
CLASS_DECI[53].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[53].NST = 5'd18;
CLASS_DECI[53].LST = 0;
end
STATE_OH[17]: begin	//
CLASS_DECI[53].LST = 0;
end
STATE_OH[18]: begin	//(PIX->*B2,B2+PW->B2)
CLASS_DECI[53].RD = 4'd2; rd_keep = 0;
//										CLASS_DECI[53].RS = 4'd9;
CLASS_DECI[53].R = 1;
CLASS_DECI[53].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[53].AIB = '{IMM_K, CV_0 , AS_PIX , EO_NONE};
CLASS_DECI[53].FT = '{FSI_PW, 1'b0};
CLASS_DECI[53].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[53].PALU = '{PIXOP_PPW, PIXAS_REGB, CNVS_NO};
CLASS_DECI[53].PF = '{PBLT_DRAW, POFFS_NONE, WIN_NONE, PLN_NONE};
CLASS_DECI[53].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[53].PIXO = '{PATS_COL1};
CLASS_DECI[53].MC = '{MAS_RA, MDS_PIX, MA_WRITE, MT_PIX};
CLASS_DECI[53].NST = PIX_XEND ? 5'd20 : 5'd16;
CLASS_DECI[53].LST = 0;
end
STATE_OH[19]: begin //
CLASS_DECI[53].LST = 0;
end
default: begin	//0+DOFFS->B2, DOFFS+B3->DOFFS
CLASS_DECI[53].RD = 4'd2; rd_keep = 0;
CLASS_DECI[53].RS = 4'd3; rs_low_keep = 0; rs_high_keep = 0;
CLASS_DECI[53].R = 1;
CLASS_DECI[53].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[53].AIB = '{IMM_K, CV_0 , AS_PIX  , EO_NONE};
CLASS_DECI[53].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[53].PALU = '{PIXOP_OFFS, PIXAS_REGB, CNVS_DP};
CLASS_DECI[53].PF = '{PBLT_NONE, POFFS_NEXT, WIN_NONE, PLN_NONE};
CLASS_DECI[53].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[53].NST = 5'd13;
CLASS_DECI[53].LST = PIX_YEND;
end
endcase
end
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[53].R = CLASS_DECI[53].R | IC[4];
		CLASS_DECI[53].RD = CLASS_DECI[53].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[53].RS = CLASS_DECI[53].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[53].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 54.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[54].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[54].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[54].R = 0;
		CLASS_DECI[54].M = 0;
		CLASS_DECI[54].F = IC[9];
		CLASS_DECI[54].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[54].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[54].FT = '{FSI_32, 1'b0};
		CLASS_DECI[54].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[54].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[54].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[54].IWL = IW_NONE;
		CLASS_DECI[54].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[54].MMS = 0;
		CLASS_DECI[54].MMA = 0;
		CLASS_DECI[54].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[54].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[54].JC = JC_NONE;
		CLASS_DECI[54].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[54].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[54].PIXO = '{PATS_NULL};
		CLASS_DECI[54].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[54].PCS = PCS_NONE;
		CLASS_DECI[54].PCW = 1;
		CLASS_DECI[54].NST = STATE + 5'd1;
		CLASS_DECI[54].LST = 1;
		CLASS_DECI[54].ILI = 0;
		
begin
begin  //ADDK K,Rd (Rd+K->Rd)
CLASS_DECI[54].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[54].AIB = '{IMM_K, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[54].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[54].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[54].STW = {STU_ALU, AFU_NCZV};
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[54].R = CLASS_DECI[54].R | IC[4];
		CLASS_DECI[54].RD = CLASS_DECI[54].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[54].RS = CLASS_DECI[54].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[54].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 55.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[55].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[55].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[55].R = 0;
		CLASS_DECI[55].M = 0;
		CLASS_DECI[55].F = IC[9];
		CLASS_DECI[55].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[55].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[55].FT = '{FSI_32, 1'b0};
		CLASS_DECI[55].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[55].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[55].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[55].IWL = IW_NONE;
		CLASS_DECI[55].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[55].MMS = 0;
		CLASS_DECI[55].MMA = 0;
		CLASS_DECI[55].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[55].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[55].JC = JC_NONE;
		CLASS_DECI[55].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[55].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[55].PIXO = '{PATS_NULL};
		CLASS_DECI[55].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[55].PCS = PCS_NONE;
		CLASS_DECI[55].PCW = 1;
		CLASS_DECI[55].NST = STATE + 5'd1;
		CLASS_DECI[55].LST = 1;
		CLASS_DECI[55].ILI = 0;
		
begin
begin  //SUBK K,Rd (Rd-K->Rd)
CLASS_DECI[55].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[55].AIB = '{IMM_K, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[55].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[55].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[55].STW = {STU_ALU, AFU_NCZV};
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[55].R = CLASS_DECI[55].R | IC[4];
		CLASS_DECI[55].RD = CLASS_DECI[55].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[55].RS = CLASS_DECI[55].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[55].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 56.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[56].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[56].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[56].R = 0;
		CLASS_DECI[56].M = 0;
		CLASS_DECI[56].F = IC[9];
		CLASS_DECI[56].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[56].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[56].FT = '{FSI_32, 1'b0};
		CLASS_DECI[56].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[56].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[56].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[56].IWL = IW_NONE;
		CLASS_DECI[56].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[56].MMS = 0;
		CLASS_DECI[56].MMA = 0;
		CLASS_DECI[56].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[56].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[56].JC = JC_NONE;
		CLASS_DECI[56].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[56].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[56].PIXO = '{PATS_NULL};
		CLASS_DECI[56].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[56].PCS = PCS_NONE;
		CLASS_DECI[56].PCW = 1;
		CLASS_DECI[56].NST = STATE + 5'd1;
		CLASS_DECI[56].LST = 1;
		CLASS_DECI[56].ILI = 0;
		
begin
begin  //MOVK K,Rd (0+K->Rd)
CLASS_DECI[56].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[56].AIB = '{IMM_K, CV_0 , AS_IMM  , EO_NONE};
CLASS_DECI[56].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[56].RWA = '{RS_ALU, 1'b1};
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[56].R = CLASS_DECI[56].R | IC[4];
		CLASS_DECI[56].RD = CLASS_DECI[56].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[56].RS = CLASS_DECI[56].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[56].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 57.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[57].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[57].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[57].R = 0;
		CLASS_DECI[57].M = 0;
		CLASS_DECI[57].F = IC[9];
		CLASS_DECI[57].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[57].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[57].FT = '{FSI_32, 1'b0};
		CLASS_DECI[57].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[57].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[57].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[57].IWL = IW_NONE;
		CLASS_DECI[57].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[57].MMS = 0;
		CLASS_DECI[57].MMA = 0;
		CLASS_DECI[57].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[57].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[57].JC = JC_NONE;
		CLASS_DECI[57].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[57].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[57].PIXO = '{PATS_NULL};
		CLASS_DECI[57].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[57].PCS = PCS_NONE;
		CLASS_DECI[57].PCW = 1;
		CLASS_DECI[57].NST = STATE + 5'd1;
		CLASS_DECI[57].LST = 1;
		CLASS_DECI[57].ILI = 0;
		
begin
begin  //BTST K,Rd (Rd&BMASK)
CLASS_DECI[57].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[57].AIB = '{IMM_K, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[57].ALU = '{ALUOP_LOG, 4'b0111, 1'b0};
CLASS_DECI[57].STW = {STU_ALU, AFU_Z};
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[57].R = CLASS_DECI[57].R | IC[4];
		CLASS_DECI[57].RD = CLASS_DECI[57].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[57].RS = CLASS_DECI[57].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[57].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 58.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[58].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[58].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[58].R = 0;
		CLASS_DECI[58].M = 0;
		CLASS_DECI[58].F = IC[9];
		CLASS_DECI[58].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[58].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[58].FT = '{FSI_32, 1'b0};
		CLASS_DECI[58].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[58].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[58].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[58].IWL = IW_NONE;
		CLASS_DECI[58].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[58].MMS = 0;
		CLASS_DECI[58].MMA = 0;
		CLASS_DECI[58].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[58].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[58].JC = JC_NONE;
		CLASS_DECI[58].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[58].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[58].PIXO = '{PATS_NULL};
		CLASS_DECI[58].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[58].PCS = PCS_NONE;
		CLASS_DECI[58].PCW = 1;
		CLASS_DECI[58].NST = STATE + 5'd1;
		CLASS_DECI[58].LST = 1;
		CLASS_DECI[58].ILI = 0;
		
begin
begin  //SLA K,Rd
unique case (1'b1)
STATE_OH[0]: begin	//
CLASS_DECI[58].LST = 0;
end
STATE_OH[1]: begin //
CLASS_DECI[58].LST = 0;
end
default: begin
CLASS_DECI[58].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[58].AIB = '{IMM_K, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[58].ALU = '{ALUOP_SHIFT, 4'b0000, 1'b0};
CLASS_DECI[58].SHC = '{SS_IMM, 3'b010};
CLASS_DECI[58].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[58].STW = {STU_ALU, AFU_NCZV};
CLASS_DECI[58].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[58].R = CLASS_DECI[58].R | IC[4];
		CLASS_DECI[58].RD = CLASS_DECI[58].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[58].RS = CLASS_DECI[58].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[58].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 59.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[59].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[59].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[59].R = 0;
		CLASS_DECI[59].M = 0;
		CLASS_DECI[59].F = IC[9];
		CLASS_DECI[59].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[59].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[59].FT = '{FSI_32, 1'b0};
		CLASS_DECI[59].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[59].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[59].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[59].IWL = IW_NONE;
		CLASS_DECI[59].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[59].MMS = 0;
		CLASS_DECI[59].MMA = 0;
		CLASS_DECI[59].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[59].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[59].JC = JC_NONE;
		CLASS_DECI[59].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[59].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[59].PIXO = '{PATS_NULL};
		CLASS_DECI[59].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[59].PCS = PCS_NONE;
		CLASS_DECI[59].PCW = 1;
		CLASS_DECI[59].NST = STATE + 5'd1;
		CLASS_DECI[59].LST = 1;
		CLASS_DECI[59].ILI = 0;
		
begin
begin  //SLL K,Rd
unique case (1'b1)
default: begin
CLASS_DECI[59].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[59].AIB = '{IMM_K, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[59].ALU = '{ALUOP_SHIFT, 4'b0000, 1'b0};
CLASS_DECI[59].SHC = '{SS_IMM, 3'b000};
CLASS_DECI[59].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[59].STW = {STU_ALU, AFU_CZ};
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[59].R = CLASS_DECI[59].R | IC[4];
		CLASS_DECI[59].RD = CLASS_DECI[59].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[59].RS = CLASS_DECI[59].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[59].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 60.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[60].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[60].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[60].R = 0;
		CLASS_DECI[60].M = 0;
		CLASS_DECI[60].F = IC[9];
		CLASS_DECI[60].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[60].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[60].FT = '{FSI_32, 1'b0};
		CLASS_DECI[60].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[60].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[60].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[60].IWL = IW_NONE;
		CLASS_DECI[60].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[60].MMS = 0;
		CLASS_DECI[60].MMA = 0;
		CLASS_DECI[60].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[60].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[60].JC = JC_NONE;
		CLASS_DECI[60].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[60].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[60].PIXO = '{PATS_NULL};
		CLASS_DECI[60].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[60].PCS = PCS_NONE;
		CLASS_DECI[60].PCW = 1;
		CLASS_DECI[60].NST = STATE + 5'd1;
		CLASS_DECI[60].LST = 1;
		CLASS_DECI[60].ILI = 0;
		
begin
begin  //SRA K,Rd
unique case (1'b1)
default: begin
CLASS_DECI[60].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[60].AIB = '{IMM_K, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[60].ALU = '{ALUOP_SHIFT, 4'b0000, 1'b0};
CLASS_DECI[60].SHC = '{SS_IMM, 3'b011};
CLASS_DECI[60].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[60].STW = {STU_ALU, AFU_NCZ};
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[60].R = CLASS_DECI[60].R | IC[4];
		CLASS_DECI[60].RD = CLASS_DECI[60].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[60].RS = CLASS_DECI[60].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[60].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 61.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[61].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[61].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[61].R = 0;
		CLASS_DECI[61].M = 0;
		CLASS_DECI[61].F = IC[9];
		CLASS_DECI[61].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[61].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[61].FT = '{FSI_32, 1'b0};
		CLASS_DECI[61].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[61].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[61].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[61].IWL = IW_NONE;
		CLASS_DECI[61].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[61].MMS = 0;
		CLASS_DECI[61].MMA = 0;
		CLASS_DECI[61].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[61].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[61].JC = JC_NONE;
		CLASS_DECI[61].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[61].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[61].PIXO = '{PATS_NULL};
		CLASS_DECI[61].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[61].PCS = PCS_NONE;
		CLASS_DECI[61].PCW = 1;
		CLASS_DECI[61].NST = STATE + 5'd1;
		CLASS_DECI[61].LST = 1;
		CLASS_DECI[61].ILI = 0;
		
begin
begin  //SRL K,Rd
unique case (1'b1)
default: begin
CLASS_DECI[61].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[61].AIB = '{IMM_K, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[61].ALU = '{ALUOP_SHIFT, 4'b0000, 1'b0};
CLASS_DECI[61].SHC = '{SS_IMM, 3'b001};
CLASS_DECI[61].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[61].STW = {STU_ALU, AFU_CZ};
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[61].R = CLASS_DECI[61].R | IC[4];
		CLASS_DECI[61].RD = CLASS_DECI[61].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[61].RS = CLASS_DECI[61].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[61].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 62.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[62].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[62].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[62].R = 0;
		CLASS_DECI[62].M = 0;
		CLASS_DECI[62].F = IC[9];
		CLASS_DECI[62].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[62].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[62].FT = '{FSI_32, 1'b0};
		CLASS_DECI[62].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[62].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[62].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[62].IWL = IW_NONE;
		CLASS_DECI[62].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[62].MMS = 0;
		CLASS_DECI[62].MMA = 0;
		CLASS_DECI[62].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[62].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[62].JC = JC_NONE;
		CLASS_DECI[62].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[62].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[62].PIXO = '{PATS_NULL};
		CLASS_DECI[62].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[62].PCS = PCS_NONE;
		CLASS_DECI[62].PCW = 1;
		CLASS_DECI[62].NST = STATE + 5'd1;
		CLASS_DECI[62].LST = 1;
		CLASS_DECI[62].ILI = 0;
		
begin
begin  //RL K,Rd
unique case (1'b1)
default: begin
CLASS_DECI[62].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[62].AIB = '{IMM_K, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[62].ALU = '{ALUOP_SHIFT, 4'b0000, 1'b0};
CLASS_DECI[62].SHC = '{SS_IMM, 3'b100};
CLASS_DECI[62].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[62].STW = {STU_ALU, AFU_CZ};
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[62].R = CLASS_DECI[62].R | IC[4];
		CLASS_DECI[62].RD = CLASS_DECI[62].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[62].RS = CLASS_DECI[62].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[62].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 63.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[63].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[63].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[63].R = 0;
		CLASS_DECI[63].M = 0;
		CLASS_DECI[63].F = IC[9];
		CLASS_DECI[63].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[63].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[63].FT = '{FSI_32, 1'b0};
		CLASS_DECI[63].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[63].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[63].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[63].IWL = IW_NONE;
		CLASS_DECI[63].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[63].MMS = 0;
		CLASS_DECI[63].MMA = 0;
		CLASS_DECI[63].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[63].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[63].JC = JC_NONE;
		CLASS_DECI[63].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[63].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[63].PIXO = '{PATS_NULL};
		CLASS_DECI[63].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[63].PCS = PCS_NONE;
		CLASS_DECI[63].PCW = 1;
		CLASS_DECI[63].NST = STATE + 5'd1;
		CLASS_DECI[63].LST = 1;
		CLASS_DECI[63].ILI = 0;
		
begin
begin  //CMPK K,Rd (Rd-K)
unique case (1'b1)
default: begin
CLASS_DECI[63].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[63].AIB = '{IMM_K, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[63].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[63].STW = {STU_ALU, AFU_NCZV};
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[63].R = CLASS_DECI[63].R | IC[4];
		CLASS_DECI[63].RD = CLASS_DECI[63].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[63].RS = CLASS_DECI[63].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[63].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 64.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[64].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[64].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[64].R = 0;
		CLASS_DECI[64].M = 0;
		CLASS_DECI[64].F = IC[9];
		CLASS_DECI[64].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[64].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[64].FT = '{FSI_32, 1'b0};
		CLASS_DECI[64].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[64].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[64].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[64].IWL = IW_NONE;
		CLASS_DECI[64].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[64].MMS = 0;
		CLASS_DECI[64].MMA = 0;
		CLASS_DECI[64].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[64].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[64].JC = JC_NONE;
		CLASS_DECI[64].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[64].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[64].PIXO = '{PATS_NULL};
		CLASS_DECI[64].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[64].PCS = PCS_NONE;
		CLASS_DECI[64].PCW = 1;
		CLASS_DECI[64].NST = STATE + 5'd1;
		CLASS_DECI[64].LST = 1;
		CLASS_DECI[64].ILI = 0;
		
begin
begin //DSJS Rd,Addr
unique case (1'b1)
STATE_OH[0]: begin	//Rd-1->Rd
CLASS_DECI[64].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[64].AIB = '{IMM_K, CV_1 , AS_CONST, EO_NONE};
CLASS_DECI[64].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[64].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[64].LST = 0;
end
STATE_OH[1]: begin	//PC+SS->PC
CLASS_DECI[64].JC = JC_DS;
CLASS_DECI[64].PCS = PCS_K;
CLASS_DECI[64].LST = ~DS_COND;
end
default: begin
CLASS_DECI[64].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[64].R = CLASS_DECI[64].R | IC[4];
		CLASS_DECI[64].RD = CLASS_DECI[64].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[64].RS = CLASS_DECI[64].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[64].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 65.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[65].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[65].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[65].R = 0;
		CLASS_DECI[65].M = 0;
		CLASS_DECI[65].F = IC[9];
		CLASS_DECI[65].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[65].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[65].FT = '{FSI_32, 1'b0};
		CLASS_DECI[65].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[65].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[65].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[65].IWL = IW_NONE;
		CLASS_DECI[65].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[65].MMS = 0;
		CLASS_DECI[65].MMA = 0;
		CLASS_DECI[65].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[65].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[65].JC = JC_NONE;
		CLASS_DECI[65].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[65].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[65].PIXO = '{PATS_NULL};
		CLASS_DECI[65].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[65].PCS = PCS_NONE;
		CLASS_DECI[65].PCW = 1;
		CLASS_DECI[65].NST = STATE + 5'd1;
		CLASS_DECI[65].LST = 1;
		CLASS_DECI[65].ILI = 0;
		
begin

begin  //ADD Rs,Rd (Rd+Rs->Rd)
CLASS_DECI[65].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[65].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[65].STW = {STU_ALU, AFU_NCZV};
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[65].R = CLASS_DECI[65].R | IC[4];
		CLASS_DECI[65].RD = CLASS_DECI[65].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[65].RS = CLASS_DECI[65].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[65].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 66.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[66].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[66].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[66].R = 0;
		CLASS_DECI[66].M = 0;
		CLASS_DECI[66].F = IC[9];
		CLASS_DECI[66].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[66].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[66].FT = '{FSI_32, 1'b0};
		CLASS_DECI[66].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[66].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[66].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[66].IWL = IW_NONE;
		CLASS_DECI[66].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[66].MMS = 0;
		CLASS_DECI[66].MMA = 0;
		CLASS_DECI[66].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[66].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[66].JC = JC_NONE;
		CLASS_DECI[66].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[66].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[66].PIXO = '{PATS_NULL};
		CLASS_DECI[66].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[66].PCS = PCS_NONE;
		CLASS_DECI[66].PCW = 1;
		CLASS_DECI[66].NST = STATE + 5'd1;
		CLASS_DECI[66].LST = 1;
		CLASS_DECI[66].ILI = 0;
		
begin

begin  //ADDC Rs,Rd (Rd+Rs+C->Rd)
CLASS_DECI[66].ALU = '{ALUOP_ADD, 4'b0010, 1'b0};
CLASS_DECI[66].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[66].STW = {STU_ALU, AFU_NCZV};
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[66].R = CLASS_DECI[66].R | IC[4];
		CLASS_DECI[66].RD = CLASS_DECI[66].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[66].RS = CLASS_DECI[66].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[66].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 67.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[67].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[67].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[67].R = 0;
		CLASS_DECI[67].M = 0;
		CLASS_DECI[67].F = IC[9];
		CLASS_DECI[67].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[67].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[67].FT = '{FSI_32, 1'b0};
		CLASS_DECI[67].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[67].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[67].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[67].IWL = IW_NONE;
		CLASS_DECI[67].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[67].MMS = 0;
		CLASS_DECI[67].MMA = 0;
		CLASS_DECI[67].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[67].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[67].JC = JC_NONE;
		CLASS_DECI[67].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[67].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[67].PIXO = '{PATS_NULL};
		CLASS_DECI[67].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[67].PCS = PCS_NONE;
		CLASS_DECI[67].PCW = 1;
		CLASS_DECI[67].NST = STATE + 5'd1;
		CLASS_DECI[67].LST = 1;
		CLASS_DECI[67].ILI = 0;
		
begin

begin  //SUB Rs,Rd (Rd-Rs->Rd)
CLASS_DECI[67].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[67].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[67].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[67].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[67].STW = {STU_ALU, AFU_NCZV};
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[67].R = CLASS_DECI[67].R | IC[4];
		CLASS_DECI[67].RD = CLASS_DECI[67].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[67].RS = CLASS_DECI[67].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[67].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 68.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[68].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[68].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[68].R = 0;
		CLASS_DECI[68].M = 0;
		CLASS_DECI[68].F = IC[9];
		CLASS_DECI[68].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[68].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[68].FT = '{FSI_32, 1'b0};
		CLASS_DECI[68].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[68].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[68].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[68].IWL = IW_NONE;
		CLASS_DECI[68].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[68].MMS = 0;
		CLASS_DECI[68].MMA = 0;
		CLASS_DECI[68].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[68].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[68].JC = JC_NONE;
		CLASS_DECI[68].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[68].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[68].PIXO = '{PATS_NULL};
		CLASS_DECI[68].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[68].PCS = PCS_NONE;
		CLASS_DECI[68].PCW = 1;
		CLASS_DECI[68].NST = STATE + 5'd1;
		CLASS_DECI[68].LST = 1;
		CLASS_DECI[68].ILI = 0;
		
begin

begin  //SUBB Rs,Rd (Rd-Rs-C->Rd)
CLASS_DECI[68].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[68].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[68].ALU = '{ALUOP_ADD, 4'b0011, 1'b1};
CLASS_DECI[68].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[68].STW = {STU_ALU, AFU_NCZV};
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[68].R = CLASS_DECI[68].R | IC[4];
		CLASS_DECI[68].RD = CLASS_DECI[68].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[68].RS = CLASS_DECI[68].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[68].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 69.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[69].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[69].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[69].R = 0;
		CLASS_DECI[69].M = 0;
		CLASS_DECI[69].F = IC[9];
		CLASS_DECI[69].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[69].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[69].FT = '{FSI_32, 1'b0};
		CLASS_DECI[69].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[69].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[69].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[69].IWL = IW_NONE;
		CLASS_DECI[69].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[69].MMS = 0;
		CLASS_DECI[69].MMA = 0;
		CLASS_DECI[69].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[69].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[69].JC = JC_NONE;
		CLASS_DECI[69].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[69].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[69].PIXO = '{PATS_NULL};
		CLASS_DECI[69].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[69].PCS = PCS_NONE;
		CLASS_DECI[69].PCW = 1;
		CLASS_DECI[69].NST = STATE + 5'd1;
		CLASS_DECI[69].LST = 1;
		CLASS_DECI[69].ILI = 0;
		
begin

begin  //CMP Rs,Rd (Rd-Rs)
CLASS_DECI[69].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[69].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[69].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[69].STW = {STU_ALU, AFU_NCZV};
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[69].R = CLASS_DECI[69].R | IC[4];
		CLASS_DECI[69].RD = CLASS_DECI[69].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[69].RS = CLASS_DECI[69].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[69].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 70.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[70].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[70].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[70].R = 0;
		CLASS_DECI[70].M = 0;
		CLASS_DECI[70].F = IC[9];
		CLASS_DECI[70].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[70].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[70].FT = '{FSI_32, 1'b0};
		CLASS_DECI[70].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[70].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[70].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[70].IWL = IW_NONE;
		CLASS_DECI[70].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[70].MMS = 0;
		CLASS_DECI[70].MMA = 0;
		CLASS_DECI[70].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[70].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[70].JC = JC_NONE;
		CLASS_DECI[70].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[70].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[70].PIXO = '{PATS_NULL};
		CLASS_DECI[70].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[70].PCS = PCS_NONE;
		CLASS_DECI[70].PCW = 1;
		CLASS_DECI[70].NST = STATE + 5'd1;
		CLASS_DECI[70].LST = 1;
		CLASS_DECI[70].ILI = 0;
		
begin

begin  //BTST Rs,Rd (Rd&BMASK)
CLASS_DECI[70].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[70].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[70].ALU = '{ALUOP_LOG, 4'b0110, 1'b0};
CLASS_DECI[70].STW = {STU_ALU, AFU_Z};
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[70].R = CLASS_DECI[70].R | IC[4];
		CLASS_DECI[70].RD = CLASS_DECI[70].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[70].RS = CLASS_DECI[70].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[70].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 71.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[71].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[71].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[71].R = 0;
		CLASS_DECI[71].M = 0;
		CLASS_DECI[71].F = IC[9];
		CLASS_DECI[71].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[71].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[71].FT = '{FSI_32, 1'b0};
		CLASS_DECI[71].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[71].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[71].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[71].IWL = IW_NONE;
		CLASS_DECI[71].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[71].MMS = 0;
		CLASS_DECI[71].MMA = 0;
		CLASS_DECI[71].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[71].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[71].JC = JC_NONE;
		CLASS_DECI[71].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[71].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[71].PIXO = '{PATS_NULL};
		CLASS_DECI[71].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[71].PCS = PCS_NONE;
		CLASS_DECI[71].PCW = 1;
		CLASS_DECI[71].NST = STATE + 5'd1;
		CLASS_DECI[71].LST = 1;
		CLASS_DECI[71].ILI = 0;
		
begin

begin  //MOVE Rs,Rd (Rs->Rd)
CLASS_DECI[71].M = IC[9];
CLASS_DECI[71].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[71].AIB = '{IMM_K, CV_0 , AS_REGB , EO_NONE};
CLASS_DECI[71].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[71].RWA = '{RS_REGB, 1'b1};
CLASS_DECI[71].STW = {STU_ALU, AFU_NZ};
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[71].R = CLASS_DECI[71].R | IC[4];
		CLASS_DECI[71].RD = CLASS_DECI[71].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[71].RS = CLASS_DECI[71].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[71].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 72.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[72].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[72].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[72].R = 0;
		CLASS_DECI[72].M = 0;
		CLASS_DECI[72].F = IC[9];
		CLASS_DECI[72].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[72].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[72].FT = '{FSI_32, 1'b0};
		CLASS_DECI[72].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[72].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[72].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[72].IWL = IW_NONE;
		CLASS_DECI[72].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[72].MMS = 0;
		CLASS_DECI[72].MMA = 0;
		CLASS_DECI[72].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[72].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[72].JC = JC_NONE;
		CLASS_DECI[72].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[72].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[72].PIXO = '{PATS_NULL};
		CLASS_DECI[72].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[72].PCS = PCS_NONE;
		CLASS_DECI[72].PCW = 1;
		CLASS_DECI[72].NST = STATE + 5'd1;
		CLASS_DECI[72].LST = 1;
		CLASS_DECI[72].ILI = 0;
		
begin

begin  //AND Rs,Rd (Rd&Rs->Rd)
CLASS_DECI[72].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[72].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[72].ALU = '{ALUOP_LOG, 4'b0000, 1'b0};
CLASS_DECI[72].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[72].STW = {STU_ALU, AFU_Z};
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[72].R = CLASS_DECI[72].R | IC[4];
		CLASS_DECI[72].RD = CLASS_DECI[72].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[72].RS = CLASS_DECI[72].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[72].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 73.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[73].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[73].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[73].R = 0;
		CLASS_DECI[73].M = 0;
		CLASS_DECI[73].F = IC[9];
		CLASS_DECI[73].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[73].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[73].FT = '{FSI_32, 1'b0};
		CLASS_DECI[73].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[73].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[73].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[73].IWL = IW_NONE;
		CLASS_DECI[73].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[73].MMS = 0;
		CLASS_DECI[73].MMA = 0;
		CLASS_DECI[73].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[73].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[73].JC = JC_NONE;
		CLASS_DECI[73].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[73].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[73].PIXO = '{PATS_NULL};
		CLASS_DECI[73].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[73].PCS = PCS_NONE;
		CLASS_DECI[73].PCW = 1;
		CLASS_DECI[73].NST = STATE + 5'd1;
		CLASS_DECI[73].LST = 1;
		CLASS_DECI[73].ILI = 0;
		
begin

begin  //ANDN Rs,Rd (Rd&~Rs->Rd)
CLASS_DECI[73].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[73].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[73].ALU = '{ALUOP_LOG, 4'b0001, 1'b0};
CLASS_DECI[73].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[73].STW = {STU_ALU, AFU_Z};
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[73].R = CLASS_DECI[73].R | IC[4];
		CLASS_DECI[73].RD = CLASS_DECI[73].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[73].RS = CLASS_DECI[73].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[73].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 74.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[74].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[74].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[74].R = 0;
		CLASS_DECI[74].M = 0;
		CLASS_DECI[74].F = IC[9];
		CLASS_DECI[74].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[74].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[74].FT = '{FSI_32, 1'b0};
		CLASS_DECI[74].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[74].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[74].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[74].IWL = IW_NONE;
		CLASS_DECI[74].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[74].MMS = 0;
		CLASS_DECI[74].MMA = 0;
		CLASS_DECI[74].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[74].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[74].JC = JC_NONE;
		CLASS_DECI[74].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[74].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[74].PIXO = '{PATS_NULL};
		CLASS_DECI[74].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[74].PCS = PCS_NONE;
		CLASS_DECI[74].PCW = 1;
		CLASS_DECI[74].NST = STATE + 5'd1;
		CLASS_DECI[74].LST = 1;
		CLASS_DECI[74].ILI = 0;
		
begin

begin  //OR Rs,Rd (Rd|Rs->Rd)
CLASS_DECI[74].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[74].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[74].ALU = '{ALUOP_LOG, 4'b0010, 1'b0};
CLASS_DECI[74].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[74].STW = {STU_ALU, AFU_Z};
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[74].R = CLASS_DECI[74].R | IC[4];
		CLASS_DECI[74].RD = CLASS_DECI[74].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[74].RS = CLASS_DECI[74].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[74].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 75.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[75].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[75].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[75].R = 0;
		CLASS_DECI[75].M = 0;
		CLASS_DECI[75].F = IC[9];
		CLASS_DECI[75].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[75].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[75].FT = '{FSI_32, 1'b0};
		CLASS_DECI[75].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[75].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[75].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[75].IWL = IW_NONE;
		CLASS_DECI[75].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[75].MMS = 0;
		CLASS_DECI[75].MMA = 0;
		CLASS_DECI[75].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[75].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[75].JC = JC_NONE;
		CLASS_DECI[75].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[75].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[75].PIXO = '{PATS_NULL};
		CLASS_DECI[75].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[75].PCS = PCS_NONE;
		CLASS_DECI[75].PCW = 1;
		CLASS_DECI[75].NST = STATE + 5'd1;
		CLASS_DECI[75].LST = 1;
		CLASS_DECI[75].ILI = 0;
		
begin

begin  //XOR Rs,Rd (Rd^Rs->Rd)
CLASS_DECI[75].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[75].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[75].ALU = '{ALUOP_LOG, 4'b0100, 1'b0};
CLASS_DECI[75].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[75].STW = {STU_ALU, AFU_Z};
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[75].R = CLASS_DECI[75].R | IC[4];
		CLASS_DECI[75].RD = CLASS_DECI[75].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[75].RS = CLASS_DECI[75].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[75].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 76.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[76].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[76].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[76].R = 0;
		CLASS_DECI[76].M = 0;
		CLASS_DECI[76].F = IC[9];
		CLASS_DECI[76].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[76].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[76].FT = '{FSI_32, 1'b0};
		CLASS_DECI[76].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[76].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[76].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[76].IWL = IW_NONE;
		CLASS_DECI[76].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[76].MMS = 0;
		CLASS_DECI[76].MMA = 0;
		CLASS_DECI[76].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[76].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[76].JC = JC_NONE;
		CLASS_DECI[76].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[76].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[76].PIXO = '{PATS_NULL};
		CLASS_DECI[76].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[76].PCS = PCS_NONE;
		CLASS_DECI[76].PCW = 1;
		CLASS_DECI[76].NST = STATE + 5'd1;
		CLASS_DECI[76].LST = 1;
		CLASS_DECI[76].ILI = 0;
		
begin

begin  //DIVS Rs,Rd
unique case (1'b1)
STATE_OH[0]: begin	//R(d|1)->MD_ACC[31:0]
CLASS_DECI[76].RD = 4'h1; rd_keep = 4'he;
CLASS_DECI[76].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[76].AIB = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[76].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[76].MDC = '{MDO_DIVINIT, MDA_LDL, MDSH_NOP};
CLASS_DECI[76].NST = !IC[0] ? 5'd1 : 5'd2;
CLASS_DECI[76].LST = 0;
end
STATE_OH[1]: begin	//Rd->MD_ACC[63:32]
CLASS_DECI[76].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[76].AIB = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[76].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[76].MDC = '{MDO_DIVDVNT, MDA_LDH, MDSH_NOP};
CLASS_DECI[76].LST = 0;
end
STATE_OH[2]: begin	//0-MD_ACC->MD_ACC
CLASS_DECI[76].ALU = '{ALUOP_DIV, {3'b010,MD_NEG}, MD_NEG};
CLASS_DECI[76].MDC = '{MDO_NOP, MDA_NEG, MDSH_NOP};
CLASS_DECI[76].LST = 0;
end
STATE_OH[3]: begin	//abs(Rs)->MD_SHIFT
CLASS_DECI[76].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[76].AIB = '{IMM_K, CV_0 , AS_REGB , EO_NONE};
CLASS_DECI[76].ALU = '{ALUOP_ADD, 4'b0100, 1'b0};
CLASS_DECI[76].MDC = '{MDO_DIVDVSR, MDA_NOP, MDSH_LDD};
CLASS_DECI[76].LST = 0;
end
STATE_OH[4]: begin	//MD_ACC-MD_SHIFT->MD_ACC
CLASS_DECI[76].ALU = '{ALUOP_DIV, 4'b0001, 1'b1};
CLASS_DECI[76].MDC = '{MDO_DIVSTEP, MDA_DIV, MDSH_DIV};
CLASS_DECI[76].NST = !MD_COND ? 5'd4 : 5'd5;
CLASS_DECI[76].LST = DIV_V;
if (DIV_V) CLASS_DECI[76].STW = {STU_ALU, AFU_NZV};
end
STATE_OH[5]: begin	//0-MD_Q->MD_Q
CLASS_DECI[76].ALU = '{ALUOP_DIV, {3'b010,MD_NEG}, MD_NEG};
CLASS_DECI[76].MDC = '{MDO_DIVQUOT, MDA_NOP, MDSH_NOP};
CLASS_DECI[76].NST = !IC[0] ? 5'd6 : 5'd7;
CLASS_DECI[76].LST = 0;
end
STATE_OH[6]: begin //MD_ACC->Rd+1
CLASS_DECI[76].RD = 4'h1; rd_keep = 4'he;
CLASS_DECI[76].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[76].AIB = '{IMM_K, CV_0 , AS_MDAL , EO_NONE};
CLASS_DECI[76].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
CLASS_DECI[76].ALU = '{ALUOP_DIV, {3'b000,MD_DIVIDEND_NEG}, MD_DIVIDEND_NEG};
CLASS_DECI[76].RWA = '{RS_ALU, !DIV_V};
CLASS_DECI[76].LST = 0;
end
default: begin //MD_Q->Rd
CLASS_DECI[76].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[76].AIB = '{IMM_K, CV_0 , AS_MDQ  , EO_NONE};
CLASS_DECI[76].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
CLASS_DECI[76].ALU = '{ALUOP_DIV, 4'b0000, 1'b0};
CLASS_DECI[76].STW = {STU_ALU, AFU_NZV};
CLASS_DECI[76].RWA = '{RS_ALU, !DIV_V};
CLASS_DECI[76].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[76].R = CLASS_DECI[76].R | IC[4];
		CLASS_DECI[76].RD = CLASS_DECI[76].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[76].RS = CLASS_DECI[76].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[76].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 77.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[77].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[77].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[77].R = 0;
		CLASS_DECI[77].M = 0;
		CLASS_DECI[77].F = IC[9];
		CLASS_DECI[77].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[77].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[77].FT = '{FSI_32, 1'b0};
		CLASS_DECI[77].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[77].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[77].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[77].IWL = IW_NONE;
		CLASS_DECI[77].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[77].MMS = 0;
		CLASS_DECI[77].MMA = 0;
		CLASS_DECI[77].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[77].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[77].JC = JC_NONE;
		CLASS_DECI[77].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[77].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[77].PIXO = '{PATS_NULL};
		CLASS_DECI[77].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[77].PCS = PCS_NONE;
		CLASS_DECI[77].PCW = 1;
		CLASS_DECI[77].NST = STATE + 5'd1;
		CLASS_DECI[77].LST = 1;
		CLASS_DECI[77].ILI = 0;
		
begin

begin  //DIVU Rs,Rd
unique case (1'b1)
STATE_OH[0]: begin	//R(d|1)->MD_ACC[31:0]
CLASS_DECI[77].RD = 4'h1; rd_keep = 4'he;
CLASS_DECI[77].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[77].AIB = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[77].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[77].MDC = '{MDO_DIVINIT, MDA_LDL, MDSH_NOP};
CLASS_DECI[77].NST = !IC[0] ? 5'd1 : 5'd2;
CLASS_DECI[77].LST = 0;
end
STATE_OH[1]: begin	//Rd->MD_ACC[63:32]
CLASS_DECI[77].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[77].AIB = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[77].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[77].MDC = '{MDO_DIVDVNT, MDA_LDH, MDSH_NOP};
CLASS_DECI[77].LST = 0;
end
STATE_OH[2]: begin	//0-MD_ACC->MD_ACC
CLASS_DECI[77].ALU = '{ALUOP_DIV, {3'b010,MD_NEG}, MD_NEG};
CLASS_DECI[77].MDC = '{MDO_NOP, MDA_NEG, MDSH_NOP};
CLASS_DECI[77].LST = 0;
end
STATE_OH[3]: begin	//Rs->MD_SHIFT
CLASS_DECI[77].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[77].AIB = '{IMM_K, CV_0 , AS_REGB , EO_NONE};
CLASS_DECI[77].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[77].MDC = '{MDO_DIVDVSR, MDA_NOP, MDSH_LDD};
CLASS_DECI[77].LST = 0;
end
STATE_OH[4]: begin	//MD_ACC-MD_SHIFT->MD_ACC
CLASS_DECI[77].ALU = '{ALUOP_DIV, 4'b0001, 1'b1};
CLASS_DECI[77].MDC = '{MDO_DIVSTEP, MDA_DIV, MDSH_DIV};
CLASS_DECI[77].NST = !MD_COND ? 5'd4 : 5'd5;
CLASS_DECI[77].LST = DIV_V;
if (DIV_V) CLASS_DECI[77].STW = {STU_ALU, AFU_ZV};
end
STATE_OH[5]: begin	//0-MD_Q->MD_Q
CLASS_DECI[77].ALU = '{ALUOP_DIV, {3'b010,MD_NEG}, MD_NEG};
CLASS_DECI[77].MDC = '{MDO_DIVQUOT, MDA_NOP, MDSH_NOP};
CLASS_DECI[77].NST = !IC[0] ? 5'd6 : 5'd7;
CLASS_DECI[77].LST = 0;
end
STATE_OH[6]: begin //MD_ACC->Rd|1
CLASS_DECI[77].RD = 4'h1; rd_keep = 4'he;
CLASS_DECI[77].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[77].AIB = '{IMM_K, CV_0 , AS_MDAL , EO_NONE};
CLASS_DECI[77].ALU = '{ALUOP_DIV, 4'b0000, 1'b0};
CLASS_DECI[77].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
CLASS_DECI[77].RWA = '{RS_ALU, !DIV_V};
CLASS_DECI[77].LST = 0;
end
default: begin //MD_Q->Rd
CLASS_DECI[77].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[77].AIB = '{IMM_K, CV_0 , AS_MDQ  , EO_NONE};
CLASS_DECI[77].ALU = '{ALUOP_DIV, 4'b0000, 1'b0};
CLASS_DECI[77].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
CLASS_DECI[77].STW = {STU_ALU, AFU_ZV};
CLASS_DECI[77].RWA = '{RS_ALU, !DIV_V};
CLASS_DECI[77].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[77].R = CLASS_DECI[77].R | IC[4];
		CLASS_DECI[77].RD = CLASS_DECI[77].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[77].RS = CLASS_DECI[77].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[77].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 78.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[78].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[78].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[78].R = 0;
		CLASS_DECI[78].M = 0;
		CLASS_DECI[78].F = IC[9];
		CLASS_DECI[78].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[78].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[78].FT = '{FSI_32, 1'b0};
		CLASS_DECI[78].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[78].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[78].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[78].IWL = IW_NONE;
		CLASS_DECI[78].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[78].MMS = 0;
		CLASS_DECI[78].MMA = 0;
		CLASS_DECI[78].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[78].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[78].JC = JC_NONE;
		CLASS_DECI[78].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[78].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[78].PIXO = '{PATS_NULL};
		CLASS_DECI[78].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[78].PCS = PCS_NONE;
		CLASS_DECI[78].PCW = 1;
		CLASS_DECI[78].NST = STATE + 5'd1;
		CLASS_DECI[78].LST = 1;
		CLASS_DECI[78].ILI = 0;
		
begin

begin  //MPYS Rs,Rd
unique case (1'b1)
STATE_OH[0]: begin	//0->MD_ACC
CLASS_DECI[78].ALU = '{ALUOP_MUL, 4'b0000, 1'b0};
CLASS_DECI[78].MDC = '{MDO_MULINIT, MDA_ZERO, MDSH_NOP};
CLASS_DECI[78].LST = 0;
end
STATE_OH[1]: begin	//abs(Rs)->MD_SHIFT
CLASS_DECI[78].F = 1;
CLASS_DECI[78].FT = '{FSI_F, 1'b0};
CLASS_DECI[78].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[78].AIB = '{IMM_K, CV_0 , AS_REGB , EO_SIGN};
CLASS_DECI[78].ALU = '{ALUOP_ADD, 4'b0100, 1'b0};
CLASS_DECI[78].MDC = '{MDO_MULCHK, MDA_NOP, MDSH_LDM};
CLASS_DECI[78].LST = 0;
end
STATE_OH[2]: begin	//MD_ACC+Mult()->MD_ACC
CLASS_DECI[78].F = 1;
CLASS_DECI[78].FT = '{FSI_F, 1'b0};
CLASS_DECI[78].ALU = '{ALUOP_MUL, 4'b0000, 1'b0};
CLASS_DECI[78].MDC = '{MDO_MULSTEP, MDA_MULT, MDSH_MULT};
CLASS_DECI[78].NST = !MD_COND ? 5'd2 : 5'd3;
CLASS_DECI[78].LST = 0;
end
STATE_OH[3]: begin	//
CLASS_DECI[78].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
CLASS_DECI[78].NST = MD_NEG ? 5'd4 : 5'd5;
CLASS_DECI[78].LST = 0;
end
STATE_OH[4]: begin	//0-MD_ACC->MD_ACC
CLASS_DECI[78].ALU = '{ALUOP_MUL, 4'b0101, 1'b1};
CLASS_DECI[78].MDC = '{MDO_NOP, MDA_NEG, MDSH_NOP};
CLASS_DECI[78].LST = 0;
end
STATE_OH[5]: begin //MD_ACCL->Rd+1
CLASS_DECI[78].RD = 4'h1; rd_keep = 4'he;
CLASS_DECI[78].F = 1;
CLASS_DECI[78].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[78].AIB = '{IMM_K, CV_0 , AS_MDAL , EO_NONE};
CLASS_DECI[78].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
CLASS_DECI[78].ALU = '{ALUOP_MUL, 4'b0000, 1'b0};
CLASS_DECI[78].FT = '{FSI_F, 1'b0};
CLASS_DECI[78].STW = {STU_ALU, AFU_NZ};
CLASS_DECI[78].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[78].LST = IC[0];
end
default: begin	//MD_ACCH->Rd
CLASS_DECI[78].F = 1;
CLASS_DECI[78].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[78].AIB = '{IMM_K, CV_0 , AS_MDAH , EO_SIGN};
CLASS_DECI[78].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
CLASS_DECI[78].ALU = '{ALUOP_MUL, 4'b0000, 1'b0};
CLASS_DECI[78].FT = '{FSI_F, 1'b0};
CLASS_DECI[78].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[78].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[78].R = CLASS_DECI[78].R | IC[4];
		CLASS_DECI[78].RD = CLASS_DECI[78].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[78].RS = CLASS_DECI[78].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[78].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 79.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[79].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[79].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[79].R = 0;
		CLASS_DECI[79].M = 0;
		CLASS_DECI[79].F = IC[9];
		CLASS_DECI[79].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[79].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[79].FT = '{FSI_32, 1'b0};
		CLASS_DECI[79].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[79].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[79].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[79].IWL = IW_NONE;
		CLASS_DECI[79].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[79].MMS = 0;
		CLASS_DECI[79].MMA = 0;
		CLASS_DECI[79].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[79].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[79].JC = JC_NONE;
		CLASS_DECI[79].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[79].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[79].PIXO = '{PATS_NULL};
		CLASS_DECI[79].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[79].PCS = PCS_NONE;
		CLASS_DECI[79].PCW = 1;
		CLASS_DECI[79].NST = STATE + 5'd1;
		CLASS_DECI[79].LST = 1;
		CLASS_DECI[79].ILI = 0;
		
begin

begin  //MPYU Rs,Rd
unique case (1'b1)
STATE_OH[0]: begin	//0->MD_ACC
CLASS_DECI[79].ALU = '{ALUOP_MUL, 4'b0000, 1'b0};
CLASS_DECI[79].MDC = '{MDO_MULINIT, MDA_ZERO, MDSH_NOP};
CLASS_DECI[79].LST = 0;
end
STATE_OH[1]: begin	//Rs->MD_SHIFT
CLASS_DECI[79].F = 1;
CLASS_DECI[79].FT = '{FSI_F, 1'b0};
CLASS_DECI[79].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[79].AIB = '{IMM_K, CV_0 , AS_REGB , EO_ZERO};
CLASS_DECI[79].ALU = '{ALUOP_MUL, 4'b0000, 1'b0};
CLASS_DECI[79].MDC = '{MDO_MULCHK, MDA_NOP, MDSH_LDM};
CLASS_DECI[79].LST = 0;
end
STATE_OH[2]: begin	//MD_ACC+Mult()->MD_ACC
CLASS_DECI[79].F = 1;
CLASS_DECI[79].FT = '{FSI_F, 1'b0};
CLASS_DECI[79].ALU = '{ALUOP_MUL, 4'b0000, 1'b0};
CLASS_DECI[79].MDC = '{MDO_MULSTEP, MDA_MULT, MDSH_MULT};
CLASS_DECI[79].NST = !MD_COND ? 5'd2 : 5'd3;
CLASS_DECI[79].LST = 0;
end
STATE_OH[3]: begin	//
CLASS_DECI[79].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
CLASS_DECI[79].NST = MD_NEG ? 5'd4 : 5'd5;
CLASS_DECI[79].LST = 0;
end
STATE_OH[4]: begin	//0-MD_ACC->MD_ACC
CLASS_DECI[79].ALU = '{ALUOP_MUL, 4'b0101, 1'b1};
CLASS_DECI[79].MDC = '{MDO_NOP, MDA_NEG, MDSH_NOP};
CLASS_DECI[79].LST = 0;
end
STATE_OH[5]: begin //MD_ACCL->Rd (odd)
CLASS_DECI[79].RD = 4'h1; rd_keep = 4'he;
CLASS_DECI[79].F = 1;
CLASS_DECI[79].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[79].AIB = '{IMM_K, CV_0 , AS_MDAL , EO_NONE};
CLASS_DECI[79].ALU = '{ALUOP_MUL, 4'b0000, 1'b0};
CLASS_DECI[79].FT = '{FSI_F, 1'b0};
CLASS_DECI[79].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
CLASS_DECI[79].STW = {STU_ALU, AFU_Z};
CLASS_DECI[79].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[79].LST = IC[0];
end
default: begin	//MD_ACCH->Rd (even)
CLASS_DECI[79].F = 1;
CLASS_DECI[79].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[79].AIB = '{IMM_K, CV_0 , AS_MDAH , EO_ZERO};
CLASS_DECI[79].ALU = '{ALUOP_MUL, 4'b0000, 1'b0};
CLASS_DECI[79].FT = '{FSI_F, 1'b0};
CLASS_DECI[79].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
CLASS_DECI[79].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[79].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[79].R = CLASS_DECI[79].R | IC[4];
		CLASS_DECI[79].RD = CLASS_DECI[79].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[79].RS = CLASS_DECI[79].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[79].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 80.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[80].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[80].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[80].R = 0;
		CLASS_DECI[80].M = 0;
		CLASS_DECI[80].F = IC[9];
		CLASS_DECI[80].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[80].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[80].FT = '{FSI_32, 1'b0};
		CLASS_DECI[80].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[80].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[80].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[80].IWL = IW_NONE;
		CLASS_DECI[80].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[80].MMS = 0;
		CLASS_DECI[80].MMA = 0;
		CLASS_DECI[80].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[80].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[80].JC = JC_NONE;
		CLASS_DECI[80].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[80].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[80].PIXO = '{PATS_NULL};
		CLASS_DECI[80].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[80].PCS = PCS_NONE;
		CLASS_DECI[80].PCW = 1;
		CLASS_DECI[80].NST = STATE + 5'd1;
		CLASS_DECI[80].LST = 1;
		CLASS_DECI[80].ILI = 0;
		
begin

begin  //SLA Rs,Rd
unique case (1'b1)
STATE_OH[0]: begin	//
CLASS_DECI[80].LST = 0;
end
STATE_OH[1]: begin //
CLASS_DECI[80].LST = 0;
end
default: begin
CLASS_DECI[80].ALU = '{ALUOP_SHIFT, 4'b0000, 1'b0};
CLASS_DECI[80].SHC = '{SS_REG, 3'b010};
CLASS_DECI[80].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[80].STW = {STU_ALU, AFU_NCZV};
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[80].R = CLASS_DECI[80].R | IC[4];
		CLASS_DECI[80].RD = CLASS_DECI[80].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[80].RS = CLASS_DECI[80].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[80].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 81.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[81].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[81].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[81].R = 0;
		CLASS_DECI[81].M = 0;
		CLASS_DECI[81].F = IC[9];
		CLASS_DECI[81].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[81].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[81].FT = '{FSI_32, 1'b0};
		CLASS_DECI[81].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[81].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[81].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[81].IWL = IW_NONE;
		CLASS_DECI[81].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[81].MMS = 0;
		CLASS_DECI[81].MMA = 0;
		CLASS_DECI[81].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[81].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[81].JC = JC_NONE;
		CLASS_DECI[81].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[81].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[81].PIXO = '{PATS_NULL};
		CLASS_DECI[81].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[81].PCS = PCS_NONE;
		CLASS_DECI[81].PCW = 1;
		CLASS_DECI[81].NST = STATE + 5'd1;
		CLASS_DECI[81].LST = 1;
		CLASS_DECI[81].ILI = 0;
		
begin

begin  //SLL Rs,Rd
CLASS_DECI[81].ALU = '{ALUOP_SHIFT, 4'b0000, 1'b0};
CLASS_DECI[81].SHC = '{SS_REG, 3'b000};
CLASS_DECI[81].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[81].STW = {STU_ALU, AFU_CZ};
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[81].R = CLASS_DECI[81].R | IC[4];
		CLASS_DECI[81].RD = CLASS_DECI[81].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[81].RS = CLASS_DECI[81].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[81].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 82.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[82].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[82].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[82].R = 0;
		CLASS_DECI[82].M = 0;
		CLASS_DECI[82].F = IC[9];
		CLASS_DECI[82].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[82].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[82].FT = '{FSI_32, 1'b0};
		CLASS_DECI[82].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[82].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[82].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[82].IWL = IW_NONE;
		CLASS_DECI[82].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[82].MMS = 0;
		CLASS_DECI[82].MMA = 0;
		CLASS_DECI[82].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[82].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[82].JC = JC_NONE;
		CLASS_DECI[82].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[82].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[82].PIXO = '{PATS_NULL};
		CLASS_DECI[82].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[82].PCS = PCS_NONE;
		CLASS_DECI[82].PCW = 1;
		CLASS_DECI[82].NST = STATE + 5'd1;
		CLASS_DECI[82].LST = 1;
		CLASS_DECI[82].ILI = 0;
		
begin

begin  //SRA Rs,Rd
CLASS_DECI[82].ALU = '{ALUOP_SHIFT, 4'b0000, 1'b0};
CLASS_DECI[82].SHC = '{SS_REG, 3'b011};
CLASS_DECI[82].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[82].STW = {STU_ALU, AFU_NCZ};
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[82].R = CLASS_DECI[82].R | IC[4];
		CLASS_DECI[82].RD = CLASS_DECI[82].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[82].RS = CLASS_DECI[82].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[82].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 83.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[83].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[83].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[83].R = 0;
		CLASS_DECI[83].M = 0;
		CLASS_DECI[83].F = IC[9];
		CLASS_DECI[83].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[83].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[83].FT = '{FSI_32, 1'b0};
		CLASS_DECI[83].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[83].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[83].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[83].IWL = IW_NONE;
		CLASS_DECI[83].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[83].MMS = 0;
		CLASS_DECI[83].MMA = 0;
		CLASS_DECI[83].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[83].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[83].JC = JC_NONE;
		CLASS_DECI[83].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[83].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[83].PIXO = '{PATS_NULL};
		CLASS_DECI[83].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[83].PCS = PCS_NONE;
		CLASS_DECI[83].PCW = 1;
		CLASS_DECI[83].NST = STATE + 5'd1;
		CLASS_DECI[83].LST = 1;
		CLASS_DECI[83].ILI = 0;
		
begin

begin  //SRL Rs,Rd
CLASS_DECI[83].ALU = '{ALUOP_SHIFT, 4'b0000, 1'b0};
CLASS_DECI[83].SHC = '{SS_REG, 3'b001};
CLASS_DECI[83].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[83].STW = {STU_ALU, AFU_CZ};
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[83].R = CLASS_DECI[83].R | IC[4];
		CLASS_DECI[83].RD = CLASS_DECI[83].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[83].RS = CLASS_DECI[83].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[83].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 84.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[84].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[84].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[84].R = 0;
		CLASS_DECI[84].M = 0;
		CLASS_DECI[84].F = IC[9];
		CLASS_DECI[84].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[84].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[84].FT = '{FSI_32, 1'b0};
		CLASS_DECI[84].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[84].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[84].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[84].IWL = IW_NONE;
		CLASS_DECI[84].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[84].MMS = 0;
		CLASS_DECI[84].MMA = 0;
		CLASS_DECI[84].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[84].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[84].JC = JC_NONE;
		CLASS_DECI[84].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[84].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[84].PIXO = '{PATS_NULL};
		CLASS_DECI[84].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[84].PCS = PCS_NONE;
		CLASS_DECI[84].PCW = 1;
		CLASS_DECI[84].NST = STATE + 5'd1;
		CLASS_DECI[84].LST = 1;
		CLASS_DECI[84].ILI = 0;
		
begin

begin  //RL Rs,Rd
CLASS_DECI[84].ALU = '{ALUOP_SHIFT, 4'b0000, 1'b0};
CLASS_DECI[84].SHC = '{SS_REG, 3'b100};
CLASS_DECI[84].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[84].STW = {STU_ALU, AFU_CZ};
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[84].R = CLASS_DECI[84].R | IC[4];
		CLASS_DECI[84].RD = CLASS_DECI[84].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[84].RS = CLASS_DECI[84].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[84].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 85.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[85].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[85].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[85].R = 0;
		CLASS_DECI[85].M = 0;
		CLASS_DECI[85].F = IC[9];
		CLASS_DECI[85].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[85].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[85].FT = '{FSI_32, 1'b0};
		CLASS_DECI[85].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[85].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[85].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[85].IWL = IW_NONE;
		CLASS_DECI[85].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[85].MMS = 0;
		CLASS_DECI[85].MMA = 0;
		CLASS_DECI[85].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[85].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[85].JC = JC_NONE;
		CLASS_DECI[85].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[85].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[85].PIXO = '{PATS_NULL};
		CLASS_DECI[85].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[85].PCS = PCS_NONE;
		CLASS_DECI[85].PCW = 1;
		CLASS_DECI[85].NST = STATE + 5'd1;
		CLASS_DECI[85].LST = 1;
		CLASS_DECI[85].ILI = 0;
		
begin

begin  //LMO Rs,Rd
CLASS_DECI[85].ALU = '{ALUOP_LOC, 4'b0000, 1'b0};
CLASS_DECI[85].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[85].STW = {STU_ALU, AFU_Z};
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[85].R = CLASS_DECI[85].R | IC[4];
		CLASS_DECI[85].RD = CLASS_DECI[85].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[85].RS = CLASS_DECI[85].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[85].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 86.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[86].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[86].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[86].R = 0;
		CLASS_DECI[86].M = 0;
		CLASS_DECI[86].F = IC[9];
		CLASS_DECI[86].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[86].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[86].FT = '{FSI_32, 1'b0};
		CLASS_DECI[86].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[86].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[86].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[86].IWL = IW_NONE;
		CLASS_DECI[86].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[86].MMS = 0;
		CLASS_DECI[86].MMA = 0;
		CLASS_DECI[86].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[86].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[86].JC = JC_NONE;
		CLASS_DECI[86].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[86].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[86].PIXO = '{PATS_NULL};
		CLASS_DECI[86].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[86].PCS = PCS_NONE;
		CLASS_DECI[86].PCW = 1;
		CLASS_DECI[86].NST = STATE + 5'd1;
		CLASS_DECI[86].LST = 1;
		CLASS_DECI[86].ILI = 0;
		
begin

begin	//MODS Rs,Rd
unique case (1'b1)
STATE_OH[0]: begin	//Rd->MD_ACC[31:0]
CLASS_DECI[86].RD = 0; rd_keep = 4'hf;
CLASS_DECI[86].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[86].AIB = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[86].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[86].MDC = '{MDO_DIVINIT, MDA_LDL, MDSH_NOP};
CLASS_DECI[86].NST = 5'd2;
CLASS_DECI[86].LST = 0;
end
STATE_OH[1]: begin	//Rd->MD_ACC[63:32]
CLASS_DECI[86].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[86].AIB = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[86].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[86].MDC = '{MDO_DIVDVNT, MDA_LDH, MDSH_NOP};
CLASS_DECI[86].LST = 0;
end
STATE_OH[2]: begin	//0-MD_ACC->MD_ACC
CLASS_DECI[86].ALU = '{ALUOP_DIV, {3'b010,MD_NEG}, MD_NEG};
CLASS_DECI[86].MDC = '{MDO_NOP, MDA_NEG, MDSH_NOP};
CLASS_DECI[86].LST = 0;
end
STATE_OH[3]: begin	//abs(Rs)->MD_SHIFT
CLASS_DECI[86].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[86].AIB = '{IMM_K, CV_0 , AS_REGB , EO_NONE};
CLASS_DECI[86].ALU = '{ALUOP_ADD, 4'b0100, 1'b0};
CLASS_DECI[86].MDC = '{MDO_DIVDVSR, MDA_NOP, MDSH_LDD};
CLASS_DECI[86].LST = 0;
end
STATE_OH[4]: begin	//MD_ACC-MD_SHIFT->MD_ACC
CLASS_DECI[86].ALU = '{ALUOP_DIV, 4'b0001, 1'b1};
CLASS_DECI[86].MDC = '{MDO_DIVSTEP, MDA_DIV, MDSH_DIV};
CLASS_DECI[86].NST = !MD_COND ? 5'd4 : 5'd5;
CLASS_DECI[86].STW = DIV_V ? {STU_ALU, AFU_NZV} : {STU_NONE, 4'b0000};
CLASS_DECI[86].LST = DIV_V;
end
STATE_OH[5]: begin	//0-MD_Q->MD_Q
CLASS_DECI[86].ALU = '{ALUOP_DIV, {3'b010,MD_NEG}, MD_NEG};
CLASS_DECI[86].MDC = '{MDO_DIVQUOT, MDA_NOP, MDSH_NOP};
CLASS_DECI[86].LST = 0;
end
default: begin //MD_ACC->Rd
CLASS_DECI[86].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[86].AIB = '{IMM_K, CV_0 , AS_MDAL , EO_NONE};
CLASS_DECI[86].ALU = '{ALUOP_DIV, {3'b000,MD_DIVIDEND_NEG}, MD_DIVIDEND_NEG};
CLASS_DECI[86].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
CLASS_DECI[86].STW = {STU_ALU, AFU_NZV};
CLASS_DECI[86].RWA = '{RS_ALU, !DIV_V};
CLASS_DECI[86].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[86].R = CLASS_DECI[86].R | IC[4];
		CLASS_DECI[86].RD = CLASS_DECI[86].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[86].RS = CLASS_DECI[86].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[86].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 87.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[87].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[87].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[87].R = 0;
		CLASS_DECI[87].M = 0;
		CLASS_DECI[87].F = IC[9];
		CLASS_DECI[87].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[87].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[87].FT = '{FSI_32, 1'b0};
		CLASS_DECI[87].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[87].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[87].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[87].IWL = IW_NONE;
		CLASS_DECI[87].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[87].MMS = 0;
		CLASS_DECI[87].MMA = 0;
		CLASS_DECI[87].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[87].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[87].JC = JC_NONE;
		CLASS_DECI[87].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[87].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[87].PIXO = '{PATS_NULL};
		CLASS_DECI[87].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[87].PCS = PCS_NONE;
		CLASS_DECI[87].PCW = 1;
		CLASS_DECI[87].NST = STATE + 5'd1;
		CLASS_DECI[87].LST = 1;
		CLASS_DECI[87].ILI = 0;
		
begin

begin	//MODU Rs,Rd
unique case (1'b1)
STATE_OH[0]: begin	//Rd->MD_ACC
CLASS_DECI[87].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[87].AIB = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[87].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[87].MDC = '{MDO_DIVINIT, MDA_LDL, MDSH_NOP};
CLASS_DECI[87].NST = 5'd2;
CLASS_DECI[87].LST = 0;
end
STATE_OH[1]: begin	//
CLASS_DECI[87].MDC = '{MDO_DIVDVNT, MDA_LDH, MDSH_NOP};
CLASS_DECI[87].LST = 0;
end
STATE_OH[2]: begin	//0-MD_ACC->MD_ACC
CLASS_DECI[87].ALU = '{ALUOP_DIV, {3'b010,MD_NEG}, MD_NEG};
CLASS_DECI[87].MDC = '{MDO_NOP, MDA_NEG, MDSH_NOP};
CLASS_DECI[87].LST = 0;
end
STATE_OH[3]: begin	//Rs->MD_SHIFT
CLASS_DECI[87].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[87].AIB = '{IMM_K, CV_0 , AS_REGB , EO_NONE};
CLASS_DECI[87].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[87].MDC = '{MDO_DIVDVSR, MDA_NEG, MDSH_LDD};
CLASS_DECI[87].LST = 0;
end
STATE_OH[4]: begin	//MD_ACC-MD_SHIFT->MD_ACC
CLASS_DECI[87].ALU = '{ALUOP_DIV, 4'b0001, 1'b1};
CLASS_DECI[87].MDC = '{MDO_DIVSTEP, MDA_DIV, MDSH_DIV};
CLASS_DECI[87].NST = !MD_COND ? 5'd4 : 5'd5;
CLASS_DECI[87].STW = DIV_V ? {STU_ALU, AFU_ZV} : {STU_NONE, 4'b0000};
CLASS_DECI[87].LST = DIV_V;
end
STATE_OH[5]: begin	//0-MD_Q->MD_Q
CLASS_DECI[87].ALU = '{ALUOP_DIV, {3'b010,MD_NEG}, MD_NEG};
CLASS_DECI[87].MDC = '{MDO_DIVQUOT, MDA_NOP, MDSH_NOP};
CLASS_DECI[87].LST = 0;
end
default: begin //MD_ACC->Rd
CLASS_DECI[87].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[87].AIB = '{IMM_K, CV_0 , AS_MDAL , EO_NONE};
CLASS_DECI[87].ALU = '{ALUOP_DIV, 4'b0000, 1'b0};
CLASS_DECI[87].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
CLASS_DECI[87].STW = {STU_ALU, AFU_ZV};
CLASS_DECI[87].RWA = '{RS_ALU, !DIV_V};
CLASS_DECI[87].LST = 1;
end
endcase;
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[87].R = CLASS_DECI[87].R | IC[4];
		CLASS_DECI[87].RD = CLASS_DECI[87].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[87].RS = CLASS_DECI[87].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[87].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 88.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[88].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[88].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[88].R = 0;
		CLASS_DECI[88].M = 0;
		CLASS_DECI[88].F = IC[9];
		CLASS_DECI[88].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[88].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[88].FT = '{FSI_32, 1'b0};
		CLASS_DECI[88].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[88].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[88].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[88].IWL = IW_NONE;
		CLASS_DECI[88].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[88].MMS = 0;
		CLASS_DECI[88].MMA = 0;
		CLASS_DECI[88].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[88].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[88].JC = JC_NONE;
		CLASS_DECI[88].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[88].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[88].PIXO = '{PATS_NULL};
		CLASS_DECI[88].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[88].PCS = PCS_NONE;
		CLASS_DECI[88].PCW = 1;
		CLASS_DECI[88].NST = STATE + 5'd1;
		CLASS_DECI[88].LST = 1;
		CLASS_DECI[88].ILI = 0;
		
begin

CLASS_DECI[88].ILI = 1;
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[88].R = CLASS_DECI[88].R | IC[4];
		CLASS_DECI[88].RD = CLASS_DECI[88].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[88].RS = CLASS_DECI[88].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[88].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 89.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[89].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[89].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[89].R = 0;
		CLASS_DECI[89].M = 0;
		CLASS_DECI[89].F = IC[9];
		CLASS_DECI[89].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[89].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[89].FT = '{FSI_32, 1'b0};
		CLASS_DECI[89].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[89].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[89].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[89].IWL = IW_NONE;
		CLASS_DECI[89].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[89].MMS = 0;
		CLASS_DECI[89].MMA = 0;
		CLASS_DECI[89].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[89].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[89].JC = JC_NONE;
		CLASS_DECI[89].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[89].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[89].PIXO = '{PATS_NULL};
		CLASS_DECI[89].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[89].PCS = PCS_NONE;
		CLASS_DECI[89].PCW = 1;
		CLASS_DECI[89].NST = STATE + 5'd1;
		CLASS_DECI[89].LST = 1;
		CLASS_DECI[89].ILI = 0;
		
begin

begin  //RMO Rs,Rd
CLASS_DECI[89].ALU = '{ALUOP_LOC, 4'b0001, 1'b0};
CLASS_DECI[89].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[89].STW = {STU_ALU, AFU_Z};
end
//					4'b111x:	begin  //SWAPF Rs,Rd,F
//
//					end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[89].R = CLASS_DECI[89].R | IC[4];
		CLASS_DECI[89].RD = CLASS_DECI[89].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[89].RS = CLASS_DECI[89].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[89].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 90.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[90].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[90].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[90].R = 0;
		CLASS_DECI[90].M = 0;
		CLASS_DECI[90].F = IC[9];
		CLASS_DECI[90].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[90].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[90].FT = '{FSI_32, 1'b0};
		CLASS_DECI[90].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[90].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[90].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[90].IWL = IW_NONE;
		CLASS_DECI[90].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[90].MMS = 0;
		CLASS_DECI[90].MMA = 0;
		CLASS_DECI[90].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[90].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[90].JC = JC_NONE;
		CLASS_DECI[90].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[90].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[90].PIXO = '{PATS_NULL};
		CLASS_DECI[90].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[90].PCS = PCS_NONE;
		CLASS_DECI[90].PCW = 1;
		CLASS_DECI[90].NST = STATE + 5'd1;
		CLASS_DECI[90].LST = 1;
		CLASS_DECI[90].ILI = 0;
		
begin

begin  //MOVE Rs,*Rd,F
unique case (1'b1)
default: begin //(Rs->*Rd)
CLASS_DECI[90].FT = '{FSI_F, 1'b0};
CLASS_DECI[90].MC = '{MAS_RA, MDS_REGB, MA_WRITE, MT_DATA};
CLASS_DECI[90].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[90].R = CLASS_DECI[90].R | IC[4];
		CLASS_DECI[90].RD = CLASS_DECI[90].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[90].RS = CLASS_DECI[90].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[90].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 91.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[91].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[91].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[91].R = 0;
		CLASS_DECI[91].M = 0;
		CLASS_DECI[91].F = IC[9];
		CLASS_DECI[91].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[91].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[91].FT = '{FSI_32, 1'b0};
		CLASS_DECI[91].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[91].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[91].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[91].IWL = IW_NONE;
		CLASS_DECI[91].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[91].MMS = 0;
		CLASS_DECI[91].MMA = 0;
		CLASS_DECI[91].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[91].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[91].JC = JC_NONE;
		CLASS_DECI[91].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[91].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[91].PIXO = '{PATS_NULL};
		CLASS_DECI[91].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[91].PCS = PCS_NONE;
		CLASS_DECI[91].PCW = 1;
		CLASS_DECI[91].NST = STATE + 5'd1;
		CLASS_DECI[91].LST = 1;
		CLASS_DECI[91].ILI = 0;
		
begin

begin  //MOVE *Rs,Rd,F
unique case (1'b1)
STATE_OH[0]: begin //(*Rs->BUF)
CLASS_DECI[91].FT = '{FSI_F, 1'b0};
CLASS_DECI[91].MC = '{MAS_RB, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[91].LST = 0;
end
STATE_OH[1]: begin //(BUF->Rd)
CLASS_DECI[91].FT = '{FSI_F, 1'b0};
CLASS_DECI[91].ALU = '{ALUOP_MOV, 4'b0000, 1'b0};
CLASS_DECI[91].RWA = '{RS_MEM, 1'b1};
CLASS_DECI[91].STW = {STU_ALU, AFU_NZ};
CLASS_DECI[91].LST = !IC[9] ? ~FE0 : ~FE1;
end
default: begin //(exts(Rd)+0->Rd)
CLASS_DECI[91].AIA = '{IMM_K, CV_0 , AS_REGA , EO_SIGN};
CLASS_DECI[91].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[91].FT = '{FSI_F, 1'b0};
CLASS_DECI[91].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[91].RWA = '{RS_ALU, 1'b1};////////////
CLASS_DECI[91].STW = {STU_ALU, AFU_NZ};
CLASS_DECI[91].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[91].R = CLASS_DECI[91].R | IC[4];
		CLASS_DECI[91].RD = CLASS_DECI[91].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[91].RS = CLASS_DECI[91].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[91].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 92.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[92].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[92].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[92].R = 0;
		CLASS_DECI[92].M = 0;
		CLASS_DECI[92].F = IC[9];
		CLASS_DECI[92].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[92].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[92].FT = '{FSI_32, 1'b0};
		CLASS_DECI[92].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[92].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[92].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[92].IWL = IW_NONE;
		CLASS_DECI[92].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[92].MMS = 0;
		CLASS_DECI[92].MMA = 0;
		CLASS_DECI[92].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[92].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[92].JC = JC_NONE;
		CLASS_DECI[92].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[92].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[92].PIXO = '{PATS_NULL};
		CLASS_DECI[92].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[92].PCS = PCS_NONE;
		CLASS_DECI[92].PCW = 1;
		CLASS_DECI[92].NST = STATE + 5'd1;
		CLASS_DECI[92].LST = 1;
		CLASS_DECI[92].ILI = 0;
		
begin

begin  //MOVE *Rs,*Rd,F
unique case (1'b1)
STATE_OH[0]: begin //(*Rs->BUF)
CLASS_DECI[92].FT = '{FSI_F, 1'b0};
CLASS_DECI[92].MC = '{MAS_RB, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[92].LST = 0;
end
default: begin //(BUF->*Rd)
CLASS_DECI[92].FT = '{FSI_F, 1'b0};
CLASS_DECI[92].MC = '{MAS_RA, MDS_MEM, MA_WRITE, MT_DATA};
CLASS_DECI[92].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[92].R = CLASS_DECI[92].R | IC[4];
		CLASS_DECI[92].RD = CLASS_DECI[92].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[92].RS = CLASS_DECI[92].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[92].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 93.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[93].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[93].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[93].R = 0;
		CLASS_DECI[93].M = 0;
		CLASS_DECI[93].F = IC[9];
		CLASS_DECI[93].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[93].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[93].FT = '{FSI_32, 1'b0};
		CLASS_DECI[93].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[93].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[93].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[93].IWL = IW_NONE;
		CLASS_DECI[93].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[93].MMS = 0;
		CLASS_DECI[93].MMA = 0;
		CLASS_DECI[93].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[93].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[93].JC = JC_NONE;
		CLASS_DECI[93].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[93].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[93].PIXO = '{PATS_NULL};
		CLASS_DECI[93].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[93].PCS = PCS_NONE;
		CLASS_DECI[93].PCW = 1;
		CLASS_DECI[93].NST = STATE + 5'd1;
		CLASS_DECI[93].LST = 1;
		CLASS_DECI[93].ILI = 0;
		
begin

begin  //MOVB Rs,*Rd
unique case (1'b1)
default: begin //(Rs->*Rd)
CLASS_DECI[93].FT = '{FSI_8, 1'b1};
CLASS_DECI[93].MC = '{MAS_RA, MDS_REGB, MA_WRITE, MT_DATA};
CLASS_DECI[93].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[93].R = CLASS_DECI[93].R | IC[4];
		CLASS_DECI[93].RD = CLASS_DECI[93].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[93].RS = CLASS_DECI[93].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[93].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 94.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[94].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[94].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[94].R = 0;
		CLASS_DECI[94].M = 0;
		CLASS_DECI[94].F = IC[9];
		CLASS_DECI[94].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[94].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[94].FT = '{FSI_32, 1'b0};
		CLASS_DECI[94].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[94].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[94].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[94].IWL = IW_NONE;
		CLASS_DECI[94].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[94].MMS = 0;
		CLASS_DECI[94].MMA = 0;
		CLASS_DECI[94].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[94].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[94].JC = JC_NONE;
		CLASS_DECI[94].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[94].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[94].PIXO = '{PATS_NULL};
		CLASS_DECI[94].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[94].PCS = PCS_NONE;
		CLASS_DECI[94].PCW = 1;
		CLASS_DECI[94].NST = STATE + 5'd1;
		CLASS_DECI[94].LST = 1;
		CLASS_DECI[94].ILI = 0;
		
begin

begin  //MOVB *Rs,Rd
unique case (1'b1)
STATE_OH[0]: begin //(*Rs->BUF)
CLASS_DECI[94].FT = '{FSI_8, 1'b1};
CLASS_DECI[94].MC = '{MAS_RB, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[94].LST = 0;
end
STATE_OH[1]: begin //(BUF->Rd)
CLASS_DECI[94].FT = '{FSI_8, 1'b1};
CLASS_DECI[94].ALU = '{ALUOP_MOV, 4'b0000, 1'b0};
CLASS_DECI[94].RWA = '{RS_MEM, 1'b1};
CLASS_DECI[94].STW = {STU_ALU, AFU_NZ};
CLASS_DECI[94].LST = 0;
end
default: begin //(exts(Rd)+0->Rd)
CLASS_DECI[94].AIA = '{IMM_K, CV_0 , AS_REGA , EO_SIGN};
CLASS_DECI[94].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[94].FT = '{FSI_8, 1'b1};
CLASS_DECI[94].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[94].RWA = '{RS_ALU, 1'b1};////////////
CLASS_DECI[94].STW = {STU_ALU, AFU_NZ};
CLASS_DECI[94].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[94].R = CLASS_DECI[94].R | IC[4];
		CLASS_DECI[94].RD = CLASS_DECI[94].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[94].RS = CLASS_DECI[94].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[94].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 95.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[95].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[95].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[95].R = 0;
		CLASS_DECI[95].M = 0;
		CLASS_DECI[95].F = IC[9];
		CLASS_DECI[95].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[95].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[95].FT = '{FSI_32, 1'b0};
		CLASS_DECI[95].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[95].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[95].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[95].IWL = IW_NONE;
		CLASS_DECI[95].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[95].MMS = 0;
		CLASS_DECI[95].MMA = 0;
		CLASS_DECI[95].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[95].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[95].JC = JC_NONE;
		CLASS_DECI[95].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[95].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[95].PIXO = '{PATS_NULL};
		CLASS_DECI[95].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[95].PCS = PCS_NONE;
		CLASS_DECI[95].PCW = 1;
		CLASS_DECI[95].NST = STATE + 5'd1;
		CLASS_DECI[95].LST = 1;
		CLASS_DECI[95].ILI = 0;
		
begin

begin  //MOVE Rs,*Rd+,F
unique case (1'b1)
default: begin //(Rs->*Rd,Rd+FS->Rd)
CLASS_DECI[95].AIA = '{IMM_K , CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[95].AIB = '{IMM_FS, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[95].FT = '{FSI_F, 1'b0};
CLASS_DECI[95].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[95].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[95].MC = '{MAS_RA, MDS_REGB, MA_WRITE, MT_DATA};
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[95].R = CLASS_DECI[95].R | IC[4];
		CLASS_DECI[95].RD = CLASS_DECI[95].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[95].RS = CLASS_DECI[95].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[95].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 96.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[96].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[96].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[96].R = 0;
		CLASS_DECI[96].M = 0;
		CLASS_DECI[96].F = IC[9];
		CLASS_DECI[96].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[96].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[96].FT = '{FSI_32, 1'b0};
		CLASS_DECI[96].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[96].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[96].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[96].IWL = IW_NONE;
		CLASS_DECI[96].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[96].MMS = 0;
		CLASS_DECI[96].MMA = 0;
		CLASS_DECI[96].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[96].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[96].JC = JC_NONE;
		CLASS_DECI[96].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[96].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[96].PIXO = '{PATS_NULL};
		CLASS_DECI[96].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[96].PCS = PCS_NONE;
		CLASS_DECI[96].PCW = 1;
		CLASS_DECI[96].NST = STATE + 5'd1;
		CLASS_DECI[96].LST = 1;
		CLASS_DECI[96].ILI = 0;
		
begin

begin  //MOVE *Rs+,Rd,F
unique case (1'b1)
STATE_OH[0]: begin //(*Rs->BUF,FS+Rs->Rs)
CLASS_DECI[96].AIA = '{IMM_FS, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[96].AIB = '{IMM_K , CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[96].FT = '{FSI_F, 1'b0};
CLASS_DECI[96].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[96].RWB = '{RS_ALU, 1'b1};
CLASS_DECI[96].MC = '{MAS_RB, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[96].LST = 0;
end
STATE_OH[1]: begin //(BUF->Rd)
CLASS_DECI[96].FT = '{FSI_F, 1'b0};
CLASS_DECI[96].ALU = '{ALUOP_MOV, 4'b0000, 1'b0};
CLASS_DECI[96].RWA = '{RS_MEM, 1'b1};
CLASS_DECI[96].STW = {STU_ALU, AFU_NZ};
CLASS_DECI[96].LST = !IC[9] ? ~FE0 : ~FE1;
end
default: begin //(exts(Rd)+0->Rd)
CLASS_DECI[96].AIA = '{IMM_K, CV_0 , AS_REGA , EO_SIGN};
CLASS_DECI[96].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[96].FT = '{FSI_F, 1'b0};
CLASS_DECI[96].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[96].RWA = '{RS_ALU, 1'b1};/////////
CLASS_DECI[96].STW = {STU_ALU, AFU_NZ};
CLASS_DECI[96].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[96].R = CLASS_DECI[96].R | IC[4];
		CLASS_DECI[96].RD = CLASS_DECI[96].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[96].RS = CLASS_DECI[96].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[96].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 97.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[97].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[97].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[97].R = 0;
		CLASS_DECI[97].M = 0;
		CLASS_DECI[97].F = IC[9];
		CLASS_DECI[97].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[97].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[97].FT = '{FSI_32, 1'b0};
		CLASS_DECI[97].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[97].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[97].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[97].IWL = IW_NONE;
		CLASS_DECI[97].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[97].MMS = 0;
		CLASS_DECI[97].MMA = 0;
		CLASS_DECI[97].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[97].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[97].JC = JC_NONE;
		CLASS_DECI[97].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[97].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[97].PIXO = '{PATS_NULL};
		CLASS_DECI[97].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[97].PCS = PCS_NONE;
		CLASS_DECI[97].PCW = 1;
		CLASS_DECI[97].NST = STATE + 5'd1;
		CLASS_DECI[97].LST = 1;
		CLASS_DECI[97].ILI = 0;
		
begin

begin  //MOVE *Rs+,*Rd+,F
unique case (1'b1)
STATE_OH[0]: begin //(*Rs->BUF,FS+Rs->Rs)
CLASS_DECI[97].AIA = '{IMM_FS, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[97].AIB = '{IMM_K , CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[97].FT = '{FSI_F, 1'b0};
CLASS_DECI[97].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[97].RWB = '{RS_ALU, 1'b1};
CLASS_DECI[97].MC = '{MAS_RB, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[97].LST = 0;
end
default: begin //(BUF->*Rd,Rd+FS->Rd)
CLASS_DECI[97].AIA = '{IMM_K , CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[97].AIB = '{IMM_FS, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[97].FT = '{FSI_F, 1'b0};
CLASS_DECI[97].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[97].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[97].MC = '{MAS_RA, MDS_MEM, MA_WRITE, MT_DATA};
CLASS_DECI[97].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[97].R = CLASS_DECI[97].R | IC[4];
		CLASS_DECI[97].RD = CLASS_DECI[97].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[97].RS = CLASS_DECI[97].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[97].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 98.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[98].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[98].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[98].R = 0;
		CLASS_DECI[98].M = 0;
		CLASS_DECI[98].F = IC[9];
		CLASS_DECI[98].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[98].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[98].FT = '{FSI_32, 1'b0};
		CLASS_DECI[98].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[98].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[98].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[98].IWL = IW_NONE;
		CLASS_DECI[98].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[98].MMS = 0;
		CLASS_DECI[98].MMA = 0;
		CLASS_DECI[98].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[98].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[98].JC = JC_NONE;
		CLASS_DECI[98].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[98].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[98].PIXO = '{PATS_NULL};
		CLASS_DECI[98].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[98].PCS = PCS_NONE;
		CLASS_DECI[98].PCW = 1;
		CLASS_DECI[98].NST = STATE + 5'd1;
		CLASS_DECI[98].LST = 1;
		CLASS_DECI[98].ILI = 0;
		
begin

begin  //MOVB *Rs,*Rd
unique case (1'b1)
STATE_OH[0]: begin //(*Rs->BUF)
CLASS_DECI[98].FT = '{FSI_8, 1'b1};
CLASS_DECI[98].MC = '{MAS_RB, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[98].LST = 0;
end
default: begin //(BUF->*Rd)
CLASS_DECI[98].FT = '{FSI_8, 1'b1};
CLASS_DECI[98].MC = '{MAS_RA, MDS_MEM, MA_WRITE, MT_DATA};
CLASS_DECI[98].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[98].R = CLASS_DECI[98].R | IC[4];
		CLASS_DECI[98].RD = CLASS_DECI[98].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[98].RS = CLASS_DECI[98].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[98].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 99.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[99].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[99].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[99].R = 0;
		CLASS_DECI[99].M = 0;
		CLASS_DECI[99].F = IC[9];
		CLASS_DECI[99].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[99].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[99].FT = '{FSI_32, 1'b0};
		CLASS_DECI[99].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[99].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[99].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[99].IWL = IW_NONE;
		CLASS_DECI[99].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[99].MMS = 0;
		CLASS_DECI[99].MMA = 0;
		CLASS_DECI[99].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[99].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[99].JC = JC_NONE;
		CLASS_DECI[99].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[99].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[99].PIXO = '{PATS_NULL};
		CLASS_DECI[99].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[99].PCS = PCS_NONE;
		CLASS_DECI[99].PCW = 1;
		CLASS_DECI[99].NST = STATE + 5'd1;
		CLASS_DECI[99].LST = 1;
		CLASS_DECI[99].ILI = 0;
		
begin

begin  //MOVE Rs,-*Rd,F
unique case (1'b1)
STATE_OH[0]: begin //(Rd-FS->Rd)
CLASS_DECI[99].AIA = '{IMM_K , CV_0, AS_REGA, EO_NONE};
CLASS_DECI[99].AIB = '{IMM_FS, CV_0, AS_IMM , EO_NONE};
CLASS_DECI[99].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[99].FT = '{FSI_F, 1'b0};
CLASS_DECI[99].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[99].LST = 0;
end
default: begin //(Rs->*Rd);
CLASS_DECI[99].FT = '{FSI_F, 1'b0};
CLASS_DECI[99].MC = '{MAS_RA, MDS_REGB, MA_WRITE, MT_DATA};
CLASS_DECI[99].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[99].R = CLASS_DECI[99].R | IC[4];
		CLASS_DECI[99].RD = CLASS_DECI[99].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[99].RS = CLASS_DECI[99].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[99].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 100.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[100].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[100].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[100].R = 0;
		CLASS_DECI[100].M = 0;
		CLASS_DECI[100].F = IC[9];
		CLASS_DECI[100].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[100].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[100].FT = '{FSI_32, 1'b0};
		CLASS_DECI[100].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[100].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[100].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[100].IWL = IW_NONE;
		CLASS_DECI[100].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[100].MMS = 0;
		CLASS_DECI[100].MMA = 0;
		CLASS_DECI[100].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[100].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[100].JC = JC_NONE;
		CLASS_DECI[100].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[100].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[100].PIXO = '{PATS_NULL};
		CLASS_DECI[100].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[100].PCS = PCS_NONE;
		CLASS_DECI[100].PCW = 1;
		CLASS_DECI[100].NST = STATE + 5'd1;
		CLASS_DECI[100].LST = 1;
		CLASS_DECI[100].ILI = 0;
		
begin

begin  //MOVE -*Rs,Rd,F
unique case (1'b1)
STATE_OH[0]: begin //(Rs-FS->Rs)
CLASS_DECI[100].AIA = '{IMM_K , CV_0, AS_REGB, EO_NONE};
CLASS_DECI[100].AIB = '{IMM_FS, CV_0, AS_IMM , EO_NONE};
CLASS_DECI[100].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[100].FT = '{FSI_F, 1'b0};
CLASS_DECI[100].RWB = '{RS_ALU, 1'b1};
CLASS_DECI[100].LST = 0;
end
STATE_OH[1]: begin //(*Rs->BUF)
CLASS_DECI[100].FT = '{FSI_F, 1'b0};
CLASS_DECI[100].MC = '{MAS_RB, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[100].LST = 0;
end
STATE_OH[2]: begin //(BUF->Rd)
CLASS_DECI[100].FT = '{FSI_F, 1'b0};
CLASS_DECI[100].ALU = '{ALUOP_MOV, 4'b0000, 1'b0};
CLASS_DECI[100].RWA = '{RS_MEM, 1'b1};
CLASS_DECI[100].STW = {STU_ALU, AFU_NZ};
CLASS_DECI[100].LST = 0;
end
default: begin //(exts(Rd)+0->Rd)
CLASS_DECI[100].AIA = '{IMM_K, CV_0 , AS_REGA , EO_SIGN};
CLASS_DECI[100].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[100].FT = '{FSI_F, 1'b0};
CLASS_DECI[100].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[100].RWA = '{RS_ALU, 1'b1};/////////
CLASS_DECI[100].STW = {STU_ALU, AFU_NZ};
CLASS_DECI[100].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[100].R = CLASS_DECI[100].R | IC[4];
		CLASS_DECI[100].RD = CLASS_DECI[100].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[100].RS = CLASS_DECI[100].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[100].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 101.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[101].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[101].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[101].R = 0;
		CLASS_DECI[101].M = 0;
		CLASS_DECI[101].F = IC[9];
		CLASS_DECI[101].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[101].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[101].FT = '{FSI_32, 1'b0};
		CLASS_DECI[101].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[101].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[101].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[101].IWL = IW_NONE;
		CLASS_DECI[101].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[101].MMS = 0;
		CLASS_DECI[101].MMA = 0;
		CLASS_DECI[101].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[101].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[101].JC = JC_NONE;
		CLASS_DECI[101].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[101].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[101].PIXO = '{PATS_NULL};
		CLASS_DECI[101].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[101].PCS = PCS_NONE;
		CLASS_DECI[101].PCW = 1;
		CLASS_DECI[101].NST = STATE + 5'd1;
		CLASS_DECI[101].LST = 1;
		CLASS_DECI[101].ILI = 0;
		
begin

begin  //MOVE -*Rs,-*Rd,F
unique case (1'b1)
STATE_OH[0]: begin //(Rs-FS->Rs)
CLASS_DECI[101].AIA = '{IMM_K , CV_0, AS_REGB, EO_NONE};
CLASS_DECI[101].AIB = '{IMM_FS, CV_0, AS_IMM , EO_NONE};
CLASS_DECI[101].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[101].FT = '{FSI_F, 1'b0};
CLASS_DECI[101].RWB = '{RS_ALU, 1'b1};
CLASS_DECI[101].LST = 0;
end
STATE_OH[1]: begin //(Rd-FS->Rd,*Rs->BUF)
CLASS_DECI[101].AIA = '{IMM_K , CV_0, AS_REGA, EO_NONE};
CLASS_DECI[101].AIB = '{IMM_FS, CV_0, AS_IMM , EO_NONE};
CLASS_DECI[101].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[101].FT = '{FSI_F, 1'b0};
CLASS_DECI[101].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[101].MC = '{MAS_RB, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[101].LST = 0;
end
default: begin //(BUF->*Rd)
CLASS_DECI[101].FT = '{FSI_F, 1'b0};
CLASS_DECI[101].MC = '{MAS_RA, MDS_MEM, MA_WRITE, MT_DATA};
CLASS_DECI[101].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[101].R = CLASS_DECI[101].R | IC[4];
		CLASS_DECI[101].RD = CLASS_DECI[101].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[101].RS = CLASS_DECI[101].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[101].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 102.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[102].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[102].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[102].R = 0;
		CLASS_DECI[102].M = 0;
		CLASS_DECI[102].F = IC[9];
		CLASS_DECI[102].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[102].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[102].FT = '{FSI_32, 1'b0};
		CLASS_DECI[102].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[102].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[102].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[102].IWL = IW_NONE;
		CLASS_DECI[102].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[102].MMS = 0;
		CLASS_DECI[102].MMA = 0;
		CLASS_DECI[102].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[102].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[102].JC = JC_NONE;
		CLASS_DECI[102].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[102].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[102].PIXO = '{PATS_NULL};
		CLASS_DECI[102].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[102].PCS = PCS_NONE;
		CLASS_DECI[102].PCW = 1;
		CLASS_DECI[102].NST = STATE + 5'd1;
		CLASS_DECI[102].LST = 1;
		CLASS_DECI[102].ILI = 0;
		
begin

begin  //MOVB Rs,*Rd(offs)
unique case (1'b1)
STATE_OH[0]: begin //
CLASS_DECI[102].IWL = IW_WORD;
CLASS_DECI[102].LST = 0;
end
default: begin //(BUF->*(Rd+IW))
CLASS_DECI[102].FT = '{FSI_8, 1'b0};
CLASS_DECI[102].MC = '{MAS_RAIW, MDS_REGB, MA_WRITE, MT_DATA};
CLASS_DECI[102].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[102].R = CLASS_DECI[102].R | IC[4];
		CLASS_DECI[102].RD = CLASS_DECI[102].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[102].RS = CLASS_DECI[102].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[102].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 103.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[103].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[103].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[103].R = 0;
		CLASS_DECI[103].M = 0;
		CLASS_DECI[103].F = IC[9];
		CLASS_DECI[103].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[103].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[103].FT = '{FSI_32, 1'b0};
		CLASS_DECI[103].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[103].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[103].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[103].IWL = IW_NONE;
		CLASS_DECI[103].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[103].MMS = 0;
		CLASS_DECI[103].MMA = 0;
		CLASS_DECI[103].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[103].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[103].JC = JC_NONE;
		CLASS_DECI[103].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[103].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[103].PIXO = '{PATS_NULL};
		CLASS_DECI[103].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[103].PCS = PCS_NONE;
		CLASS_DECI[103].PCW = 1;
		CLASS_DECI[103].NST = STATE + 5'd1;
		CLASS_DECI[103].LST = 1;
		CLASS_DECI[103].ILI = 0;
		
begin

begin  //MOVB *Rs(offs),Rd
unique case (1'b1)
STATE_OH[0]: begin //
CLASS_DECI[103].IWL = IW_WORD;
CLASS_DECI[103].LST = 0;
end
STATE_OH[1]: begin //(*(Rs+IW)->BUF)
CLASS_DECI[103].FT = '{FSI_8, 1'b1};
CLASS_DECI[103].MC = '{MAS_RBIW, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[103].LST = 0;
end
STATE_OH[2]: begin //(BUF->Rd)
CLASS_DECI[103].FT = '{FSI_8, 1'b1};
CLASS_DECI[103].ALU = '{ALUOP_MOV, 4'b0000, 1'b0};
CLASS_DECI[103].RWA = '{RS_MEM, 1'b1};
CLASS_DECI[103].STW = {STU_ALU, AFU_NZ};
CLASS_DECI[103].LST = 0;
end
default: begin //(exts(Rd)+0->Rd)
CLASS_DECI[103].AIA = '{IMM_K, CV_0 , AS_REGA , EO_SIGN};
CLASS_DECI[103].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[103].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[103].FT = '{FSI_8, 1'b1};
CLASS_DECI[103].RWA = '{RS_ALU, 1'b1};/////////
CLASS_DECI[103].STW = {STU_ALU, AFU_NZ};
CLASS_DECI[103].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[103].R = CLASS_DECI[103].R | IC[4];
		CLASS_DECI[103].RD = CLASS_DECI[103].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[103].RS = CLASS_DECI[103].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[103].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 104.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[104].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[104].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[104].R = 0;
		CLASS_DECI[104].M = 0;
		CLASS_DECI[104].F = IC[9];
		CLASS_DECI[104].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[104].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[104].FT = '{FSI_32, 1'b0};
		CLASS_DECI[104].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[104].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[104].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[104].IWL = IW_NONE;
		CLASS_DECI[104].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[104].MMS = 0;
		CLASS_DECI[104].MMA = 0;
		CLASS_DECI[104].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[104].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[104].JC = JC_NONE;
		CLASS_DECI[104].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[104].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[104].PIXO = '{PATS_NULL};
		CLASS_DECI[104].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[104].PCS = PCS_NONE;
		CLASS_DECI[104].PCW = 1;
		CLASS_DECI[104].NST = STATE + 5'd1;
		CLASS_DECI[104].LST = 1;
		CLASS_DECI[104].ILI = 0;
		
begin

begin  //MOVE Rs,*Rd(offs),F
unique case (1'b1)
STATE_OH[0]: begin //
CLASS_DECI[104].IWL = IW_WORD;
CLASS_DECI[104].LST = 0;
end
default: begin //(BUF->*(Rd+IW))
CLASS_DECI[104].FT = '{FSI_F, 1'b0};
CLASS_DECI[104].MC = '{MAS_RAIW, MDS_REGB, MA_WRITE, MT_DATA};
CLASS_DECI[104].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[104].R = CLASS_DECI[104].R | IC[4];
		CLASS_DECI[104].RD = CLASS_DECI[104].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[104].RS = CLASS_DECI[104].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[104].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 105.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[105].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[105].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[105].R = 0;
		CLASS_DECI[105].M = 0;
		CLASS_DECI[105].F = IC[9];
		CLASS_DECI[105].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[105].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[105].FT = '{FSI_32, 1'b0};
		CLASS_DECI[105].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[105].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[105].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[105].IWL = IW_NONE;
		CLASS_DECI[105].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[105].MMS = 0;
		CLASS_DECI[105].MMA = 0;
		CLASS_DECI[105].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[105].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[105].JC = JC_NONE;
		CLASS_DECI[105].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[105].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[105].PIXO = '{PATS_NULL};
		CLASS_DECI[105].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[105].PCS = PCS_NONE;
		CLASS_DECI[105].PCW = 1;
		CLASS_DECI[105].NST = STATE + 5'd1;
		CLASS_DECI[105].LST = 1;
		CLASS_DECI[105].ILI = 0;
		
begin

begin  //MOVE *Rs(offs),Rd,F
unique case (1'b1)
STATE_OH[0]: begin //
CLASS_DECI[105].IWL = IW_WORD;
CLASS_DECI[105].LST = 0;
end
STATE_OH[1]: begin //(*(Rs+IW)->BUF)
CLASS_DECI[105].FT = '{FSI_F, 1'b0};
CLASS_DECI[105].MC = '{MAS_RBIW, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[105].LST = 0;
end
STATE_OH[2]: begin //(BUF->Rd)
CLASS_DECI[105].FT = '{FSI_F, 1'b0};
CLASS_DECI[105].ALU = '{ALUOP_MOV, 4'b0000, 1'b0};
CLASS_DECI[105].RWA = '{RS_MEM, 1'b1};
CLASS_DECI[105].STW = {STU_ALU, AFU_NZ};
CLASS_DECI[105].LST = !IC[9] ? ~FE0 : ~FE1;
end
default: begin //(exts(Rd)+0->Rd)
CLASS_DECI[105].AIA = '{IMM_K, CV_0 , AS_REGA , EO_SIGN};
CLASS_DECI[105].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[105].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[105].FT = '{FSI_F, 1'b0};
CLASS_DECI[105].RWA = '{RS_ALU, 1'b1};/////////
CLASS_DECI[105].STW = {STU_ALU, AFU_NZ};
CLASS_DECI[105].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[105].R = CLASS_DECI[105].R | IC[4];
		CLASS_DECI[105].RD = CLASS_DECI[105].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[105].RS = CLASS_DECI[105].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[105].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 106.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[106].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[106].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[106].R = 0;
		CLASS_DECI[106].M = 0;
		CLASS_DECI[106].F = IC[9];
		CLASS_DECI[106].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[106].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[106].FT = '{FSI_32, 1'b0};
		CLASS_DECI[106].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[106].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[106].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[106].IWL = IW_NONE;
		CLASS_DECI[106].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[106].MMS = 0;
		CLASS_DECI[106].MMA = 0;
		CLASS_DECI[106].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[106].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[106].JC = JC_NONE;
		CLASS_DECI[106].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[106].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[106].PIXO = '{PATS_NULL};
		CLASS_DECI[106].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[106].PCS = PCS_NONE;
		CLASS_DECI[106].PCW = 1;
		CLASS_DECI[106].NST = STATE + 5'd1;
		CLASS_DECI[106].LST = 1;
		CLASS_DECI[106].ILI = 0;
		
begin

begin  //MOVE *Rs(offs),*Rd(offs),F
unique case (1'b1)
STATE_OH[0]: begin //
CLASS_DECI[106].IWL = IW_WORD;
CLASS_DECI[106].LST = 0;
end
STATE_OH[1]: begin //(*(Rs+IW)->BUF)
CLASS_DECI[106].FT = '{FSI_F, 1'b0};
CLASS_DECI[106].MC = '{MAS_RBIW, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[106].LST = 0;
end
STATE_OH[2]: begin //
CLASS_DECI[106].IWL = IW_WORD;
CLASS_DECI[106].LST = 0;
end
default: begin //(BUF->*(Rd+IW))
CLASS_DECI[106].FT = '{FSI_F, 1'b0};
CLASS_DECI[106].MC = '{MAS_RAIW, MDS_MEM, MA_WRITE, MT_DATA};
CLASS_DECI[106].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[106].R = CLASS_DECI[106].R | IC[4];
		CLASS_DECI[106].RD = CLASS_DECI[106].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[106].RS = CLASS_DECI[106].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[106].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 107.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[107].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[107].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[107].R = 0;
		CLASS_DECI[107].M = 0;
		CLASS_DECI[107].F = IC[9];
		CLASS_DECI[107].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[107].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[107].FT = '{FSI_32, 1'b0};
		CLASS_DECI[107].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[107].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[107].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[107].IWL = IW_NONE;
		CLASS_DECI[107].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[107].MMS = 0;
		CLASS_DECI[107].MMA = 0;
		CLASS_DECI[107].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[107].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[107].JC = JC_NONE;
		CLASS_DECI[107].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[107].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[107].PIXO = '{PATS_NULL};
		CLASS_DECI[107].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[107].PCS = PCS_NONE;
		CLASS_DECI[107].PCW = 1;
		CLASS_DECI[107].NST = STATE + 5'd1;
		CLASS_DECI[107].LST = 1;
		CLASS_DECI[107].ILI = 0;
		
begin

begin  //MOVB *Rs(offs),*Rd(offs)
unique case (1'b1)
STATE_OH[0]: begin //
CLASS_DECI[107].IWL = IW_WORD;
CLASS_DECI[107].LST = 0;
end
STATE_OH[1]: begin //(*(Rs+IW)->BUF)
CLASS_DECI[107].FT = '{FSI_8, 1'b1};
CLASS_DECI[107].MC = '{MAS_RBIW, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[107].LST = 0;
end
STATE_OH[2]: begin //
CLASS_DECI[107].IWL = IW_WORD;
CLASS_DECI[107].LST = 0;
end
default: begin //(BUF->*(Rd+IW))
CLASS_DECI[107].FT = '{FSI_8, 1'b1};
CLASS_DECI[107].MC = '{MAS_RAIW, MDS_MEM, MA_WRITE, MT_DATA};
CLASS_DECI[107].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[107].R = CLASS_DECI[107].R | IC[4];
		CLASS_DECI[107].RD = CLASS_DECI[107].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[107].RS = CLASS_DECI[107].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[107].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 108.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[108].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[108].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[108].R = 0;
		CLASS_DECI[108].M = 0;
		CLASS_DECI[108].F = IC[9];
		CLASS_DECI[108].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[108].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[108].FT = '{FSI_32, 1'b0};
		CLASS_DECI[108].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[108].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[108].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[108].IWL = IW_NONE;
		CLASS_DECI[108].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[108].MMS = 0;
		CLASS_DECI[108].MMA = 0;
		CLASS_DECI[108].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[108].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[108].JC = JC_NONE;
		CLASS_DECI[108].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[108].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[108].PIXO = '{PATS_NULL};
		CLASS_DECI[108].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[108].PCS = PCS_NONE;
		CLASS_DECI[108].PCW = 1;
		CLASS_DECI[108].NST = STATE + 5'd1;
		CLASS_DECI[108].LST = 1;
		CLASS_DECI[108].ILI = 0;
		
begin  //JAcc Addr
casex (IC[7:0])
8'bx0000000: begin
unique case (1'b1)
STATE_OH[0]: begin
CLASS_DECI[108].IWL = IC[7] ? IW_LONG : IW_WORD;
CLASS_DECI[108].LST = 0;
end
STATE_OH[1]: begin
CLASS_DECI[108].JC = JC_COND;
CLASS_DECI[108].PCS = IC[7] ? PCS_IL : PCS_IW;
CLASS_DECI[108].LST = ~J_COND;
end
default: begin
CLASS_DECI[108].LST = 1;
end
endcase
end
default: begin
unique case (1'b1)
STATE_OH[0]: begin
CLASS_DECI[108].JC = JC_COND;
CLASS_DECI[108].PCS = PCS_IB;
CLASS_DECI[108].LST = ~J_COND;
end
default: begin
CLASS_DECI[108].LST = 1;
end
endcase
end
endcase
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[108].R = CLASS_DECI[108].R | IC[4];
		CLASS_DECI[108].RD = CLASS_DECI[108].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[108].RS = CLASS_DECI[108].RS | (IC_RS_STATIC & rs_low_keep) | (IC[8:5] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[108].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 109.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[109].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[109].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[109].R = 0;
		CLASS_DECI[109].M = 0;
		CLASS_DECI[109].F = IC[9];
		CLASS_DECI[109].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[109].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[109].FT = '{FSI_32, 1'b0};
		CLASS_DECI[109].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[109].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[109].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[109].IWL = IW_NONE;
		CLASS_DECI[109].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[109].MMS = 0;
		CLASS_DECI[109].MMA = 0;
		CLASS_DECI[109].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[109].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[109].JC = JC_NONE;
		CLASS_DECI[109].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[109].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[109].PIXO = '{PATS_NULL};
		CLASS_DECI[109].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[109].PCS = PCS_NONE;
		CLASS_DECI[109].PCW = 1;
		CLASS_DECI[109].NST = STATE + 5'd1;
		CLASS_DECI[109].LST = 1;
		CLASS_DECI[109].ILI = 0;
		
begin

begin  //MOVE *Rs(offs),*Rd+,F
unique case (1'b1)
STATE_OH[0]: begin //
CLASS_DECI[109].IWL = IW_WORD;
CLASS_DECI[109].LST = 0;
end
STATE_OH[1]: begin //(*(Rs+IW)->BUF)
CLASS_DECI[109].FT = '{FSI_F, 1'b0};
CLASS_DECI[109].MC = '{MAS_RBIW, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[109].LST = 0;
end
default: begin //(BUF->*Rd,Rd+FS->Rd)
CLASS_DECI[109].AIA = '{IMM_K , CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[109].AIB = '{IMM_FS, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[109].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[109].FT = '{FSI_F, 1'b0};
CLASS_DECI[109].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[109].MC = '{MAS_RA, MDS_MEM, MA_WRITE, MT_DATA};
CLASS_DECI[109].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[109].R = CLASS_DECI[109].R | IC[4];
		CLASS_DECI[109].RD = CLASS_DECI[109].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[109].RS = CLASS_DECI[109].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[109].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 110.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[110].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[110].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[110].R = 0;
		CLASS_DECI[110].M = 0;
		CLASS_DECI[110].F = IC[9];
		CLASS_DECI[110].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[110].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[110].FT = '{FSI_32, 1'b0};
		CLASS_DECI[110].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[110].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[110].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[110].IWL = IW_NONE;
		CLASS_DECI[110].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[110].MMS = 0;
		CLASS_DECI[110].MMA = 0;
		CLASS_DECI[110].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[110].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[110].JC = JC_NONE;
		CLASS_DECI[110].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[110].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[110].PIXO = '{PATS_NULL};
		CLASS_DECI[110].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[110].PCS = PCS_NONE;
		CLASS_DECI[110].PCW = 1;
		CLASS_DECI[110].NST = STATE + 5'd1;
		CLASS_DECI[110].LST = 1;
		CLASS_DECI[110].ILI = 0;
		
begin

begin  //MOVE @SAddr,*Rd+,F
unique case (1'b1)
STATE_OH[0]: begin //
CLASS_DECI[110].IWL = IW_LONG;
CLASS_DECI[110].LST = 0;
end
STATE_OH[1]: begin //(*IL->BUF)
CLASS_DECI[110].FT = '{FSI_F, 1'b0};
CLASS_DECI[110].MC = '{MAS_IL, MDS_REGA, MA_READ, MT_DATA};
CLASS_DECI[110].LST = 0;
end
default: begin //(BUF->*Rd,Rd+FS->Rd)
CLASS_DECI[110].AIA = '{IMM_K , CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[110].AIB = '{IMM_FS, CV_0 , AS_IMM , EO_NONE};
CLASS_DECI[110].FT = '{FSI_F, 1'b0};
CLASS_DECI[110].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[110].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[110].MC = '{MAS_RA, MDS_MEM, MA_WRITE, MT_DATA};
CLASS_DECI[110].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[110].R = CLASS_DECI[110].R | IC[4];
		CLASS_DECI[110].RD = CLASS_DECI[110].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[110].RS = CLASS_DECI[110].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[110].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 111.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[111].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[111].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[111].R = 0;
		CLASS_DECI[111].M = 0;
		CLASS_DECI[111].F = IC[9];
		CLASS_DECI[111].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[111].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[111].FT = '{FSI_32, 1'b0};
		CLASS_DECI[111].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[111].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[111].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[111].IWL = IW_NONE;
		CLASS_DECI[111].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[111].MMS = 0;
		CLASS_DECI[111].MMA = 0;
		CLASS_DECI[111].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[111].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[111].JC = JC_NONE;
		CLASS_DECI[111].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[111].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[111].PIXO = '{PATS_NULL};
		CLASS_DECI[111].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[111].PCS = PCS_NONE;
		CLASS_DECI[111].PCW = 1;
		CLASS_DECI[111].NST = STATE + 5'd1;
		CLASS_DECI[111].LST = 1;
		CLASS_DECI[111].ILI = 0;
		
begin

begin  //EXGF Rd,F
unique case (1'b1)
default: begin //[ST.FEx,ST.FSx]->Rd, Rd->[ST.FEx,ST.FSx]
CLASS_DECI[111].AIA = '{IMM_K, CV_0 , AS_STF  , EO_NONE};
CLASS_DECI[111].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[111].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[111].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[111].STW = {STU_EXFS, 4'b0000};
CLASS_DECI[111].LST = 1;
end
endcase
end
//					4'b0111:	begin  //EXGF Rd,1
//						case (STATE)
//							5'd0: begin //[ST.FE1,ST.FS1]->Rd, Rd->[ST.FE1,ST.FS1]
//								CLASS_DECI[111].AIA = '{IMM_K, CV_0 , AS_STF1 , EO_NONE};
//								CLASS_DECI[111].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
//								CLASS_DECI[111].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
//								CLASS_DECI[111].RWA = '{RS_ALU, 1'b1};
//								CLASS_DECI[111].STW = {STU_EXFS, 4'b0000};
//								CLASS_DECI[111].LST = 0;
//							end
//							default: begin
//								CLASS_DECI[111].LST = 1;
//							end
//						endcase
//					end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[111].R = CLASS_DECI[111].R | IC[4];
		CLASS_DECI[111].RD = CLASS_DECI[111].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[111].RS = CLASS_DECI[111].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[111].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 112.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[112].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[112].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[112].R = 0;
		CLASS_DECI[112].M = 0;
		CLASS_DECI[112].F = IC[9];
		CLASS_DECI[112].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[112].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[112].FT = '{FSI_32, 1'b0};
		CLASS_DECI[112].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[112].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[112].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[112].IWL = IW_NONE;
		CLASS_DECI[112].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[112].MMS = 0;
		CLASS_DECI[112].MMA = 0;
		CLASS_DECI[112].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[112].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[112].JC = JC_NONE;
		CLASS_DECI[112].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[112].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[112].PIXO = '{PATS_NULL};
		CLASS_DECI[112].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[112].PCS = PCS_NONE;
		CLASS_DECI[112].PCW = 1;
		CLASS_DECI[112].NST = STATE + 5'd1;
		CLASS_DECI[112].LST = 1;
		CLASS_DECI[112].ILI = 0;
		
begin

begin  //LINE 0/1
unique case (1'b1)
STATE_OH[0]: begin //B7+0->PIX_DYDX
CLASS_DECI[112].RD = 4'd7; rd_keep = 0;
CLASS_DECI[112].RS = 4'd7; rs_high_keep = 0; rs_low_keep = 0;
CLASS_DECI[112].R = 1;
CLASS_DECI[112].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[112].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[112].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[112].PF = '{PBLT_NONE, POFFS_NONE, WIN_INIT, PLN_NONE};
CLASS_DECI[112].LST = 0;
end
STATE_OH[1]: begin //B2.XY->B14.XY, PATTERN->PIX_BIT
CLASS_DECI[112].RD = 4'd14; rd_keep = 0;
CLASS_DECI[112].RS = 4'd2; rs_high_keep = 0; rs_low_keep = 0;
CLASS_DECI[112].R = 1;
CLASS_DECI[112].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[112].AIB = '{IMM_K, CV_0 , AS_REGB , EO_NONE};
CLASS_DECI[112].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[112].PALU = '{PIXOP_NOP, PIXAS_REGB, CNVS_SP};
CLASS_DECI[112].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[112].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_INIT};
CLASS_DECI[112].LST = 0;
end
STATE_OH[2]: begin  //XYToL(B2.XY)->B2
CLASS_DECI[112].RD = 4'd2; rd_keep = 0;
CLASS_DECI[112].RS = 4'd2; rs_high_keep = 0; rs_low_keep = 0;
CLASS_DECI[112].R = 1;
CLASS_DECI[112].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[112].AIB = '{IMM_K, CV_0 , AS_PIX  , EO_NONE};
CLASS_DECI[112].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[112].PALU = '{PIXOP_XYL, PIXAS_REGB, CNVS_DP};
CLASS_DECI[112].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[112].LST = 0;
end
STATE_OH[3]: begin //B2+B4->B2
CLASS_DECI[112].RD = 4'd2; rd_keep = 0;
CLASS_DECI[112].RS = 4'd4; rs_high_keep = 0; rs_low_keep = 0;
CLASS_DECI[112].R = 1;
CLASS_DECI[112].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[112].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[112].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[112].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[112].LST = 0;
end
STATE_OH[4]: begin //B0+0, N,Z
CLASS_DECI[112].RD = 4'd0; rd_keep = 0;
CLASS_DECI[112].RS = 4'd0; rs_high_keep = 0; rs_low_keep = 0;
CLASS_DECI[112].R = 1;
CLASS_DECI[112].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[112].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[112].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[112].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_COND};
CLASS_DECI[112].LST = 0;
end
STATE_OH[5]: begin	//B10-1->B10, Z
CLASS_DECI[112].RD = 4'd10; rd_keep = 0;
CLASS_DECI[112].RS = 'd10; rs_high_keep = 0; rs_low_keep = 0;
CLASS_DECI[112].R = 1;
CLASS_DECI[112].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[112].AIB = '{IMM_K, CV_1 , AS_CONST, EO_NONE};
CLASS_DECI[112].ALU = '{ALUOP_ADD, 4'b0001, 1'b1};
CLASS_DECI[112].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[112].LST = 0;
end
STATE_OH[6]: begin	//B14.XY+B11/B12->B14.XY
CLASS_DECI[112].RD = 4'd14; rd_keep = 0;
CLASS_DECI[112].RS = LINE_GZ ? 4'd11 : 4'd12; rs_high_keep = 0; rs_low_keep = 0;
CLASS_DECI[112].R = 1;
CLASS_DECI[112].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[112].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[112].ALU = '{ALUOP_ADDXY, 4'b0000, 1'b0};
//								CLASS_DECI[112].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
CLASS_DECI[112].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[112].NST = 5'd8;
CLASS_DECI[112].LST = LINE_COND;
end
STATE_OH[7]: begin	//
CLASS_DECI[112].LST = 0;
end
STATE_OH[8]: begin	//PIX->*B2
CLASS_DECI[112].RD = 4'd2; rd_keep = 0;
CLASS_DECI[112].R = 1;
CLASS_DECI[112].AIA = '{IMM_K, CV_0 , AS_REGA , EO_NONE};
CLASS_DECI[112].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[112].FT = '{FSI_PS, 1'b0};
CLASS_DECI[112].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[112].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_STEP};
//								CLASS_DECI[112].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[112].PIXO = '{PATS_LN};
CLASS_DECI[112].MC = '{MAS_RA, MDS_PIX, MA_WRITE, MT_PIX};
CLASS_DECI[112].LST = 0;
end
STATE_OH[9]: begin	//B2+XYToL(B11/B12)->B2
CLASS_DECI[112].RD = 4'd2; rd_keep = 0;
CLASS_DECI[112].RS = LINE_GZ ? 4'd11 : 4'd12; rs_high_keep = 0; rs_low_keep = 0;
CLASS_DECI[112].R = 1;
CLASS_DECI[112].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[112].AIB = '{IMM_K, CV_0 , AS_PIX , EO_NONE};
CLASS_DECI[112].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[112].PALU = '{PIXOP_XYL, PIXAS_REGB, CNVS_DP};
//								CLASS_DECI[112].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
CLASS_DECI[112].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[112].LST = 0;
end
default: begin	//B0+LineStep()->B0, N,Z
CLASS_DECI[112].RD = 4'd0; rd_keep = 0;
CLASS_DECI[112].RS = 4'd0; rs_high_keep = 0; rs_low_keep = 0;
CLASS_DECI[112].R = 1;
CLASS_DECI[112].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[112].AIB = '{IMM_K, CV_0 , AS_PIX , EO_NONE};
CLASS_DECI[112].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[112].PALU = '{PIXOP_LNS, PIXAS_REGB, CNVS_NO};
CLASS_DECI[112].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_COND};
CLASS_DECI[112].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[112].NST = 5'd5;
CLASS_DECI[112].LST = 0;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[112].R = CLASS_DECI[112].R | IC[4];
		CLASS_DECI[112].RD = CLASS_DECI[112].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[112].RS = CLASS_DECI[112].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[112].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 113.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[113].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[113].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[113].R = 0;
		CLASS_DECI[113].M = 0;
		CLASS_DECI[113].F = IC[9];
		CLASS_DECI[113].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[113].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[113].FT = '{FSI_32, 1'b0};
		CLASS_DECI[113].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[113].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[113].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[113].IWL = IW_NONE;
		CLASS_DECI[113].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[113].MMS = 0;
		CLASS_DECI[113].MMA = 0;
		CLASS_DECI[113].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[113].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[113].JC = JC_NONE;
		CLASS_DECI[113].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[113].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[113].PIXO = '{PATS_NULL};
		CLASS_DECI[113].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[113].PCS = PCS_NONE;
		CLASS_DECI[113].PCW = 1;
		CLASS_DECI[113].NST = STATE + 5'd1;
		CLASS_DECI[113].LST = 1;
		CLASS_DECI[113].ILI = 0;
		
begin

begin //CMPXY Rs,Rd
unique case (1'b1)
default: begin //(Rd+Rs->Rd)
CLASS_DECI[113].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[113].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[113].ALU = '{ALUOP_ADDXY, {3'b000,|IC[10:9]}, |IC[10:9]};
CLASS_DECI[113].RWA = '{RS_ALU, ~IC[10]};
CLASS_DECI[113].STW = {STU_ALU, AFU_NCZV};
end
endcase
end
//					4'b010x:	begin  //CMPXY Rs,Rd
//						case (STATE)
//							default: begin //(Rd-Rs)
//								CLASS_DECI[113].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
//								CLASS_DECI[113].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
//								CLASS_DECI[113].ALU = '{ALUOP_ADDXY, 4'b0001, 1'b1};
//								CLASS_DECI[113].STW = {STU_ALU, AFU_NCZV};
//							end
//						endcase
//					end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[113].R = CLASS_DECI[113].R | IC[4];
		CLASS_DECI[113].RD = CLASS_DECI[113].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[113].RS = CLASS_DECI[113].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[113].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 114.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[114].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[114].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[114].R = 0;
		CLASS_DECI[114].M = 0;
		CLASS_DECI[114].F = IC[9];
		CLASS_DECI[114].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[114].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[114].FT = '{FSI_32, 1'b0};
		CLASS_DECI[114].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[114].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[114].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[114].IWL = IW_NONE;
		CLASS_DECI[114].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[114].MMS = 0;
		CLASS_DECI[114].MMA = 0;
		CLASS_DECI[114].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[114].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[114].JC = JC_NONE;
		CLASS_DECI[114].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[114].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[114].PIXO = '{PATS_NULL};
		CLASS_DECI[114].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[114].PCS = PCS_NONE;
		CLASS_DECI[114].PCW = 1;
		CLASS_DECI[114].NST = STATE + 5'd1;
		CLASS_DECI[114].LST = 1;
		CLASS_DECI[114].ILI = 0;
		
begin

begin  //CPW Rs,Rd
unique case (1'b1)
default: begin //(WSTART>Rs>WEND->Rd)
CLASS_DECI[114].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[114].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[114].ALU = '{ALUOP_CPW, 4'b0000, 1'b0};
CLASS_DECI[114].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[114].STW = {STU_ALU, AFU_V};
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[114].R = CLASS_DECI[114].R | IC[4];
		CLASS_DECI[114].RD = CLASS_DECI[114].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[114].RS = CLASS_DECI[114].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[114].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 115.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[115].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[115].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[115].R = 0;
		CLASS_DECI[115].M = 0;
		CLASS_DECI[115].F = IC[9];
		CLASS_DECI[115].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[115].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[115].FT = '{FSI_32, 1'b0};
		CLASS_DECI[115].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[115].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[115].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[115].IWL = IW_NONE;
		CLASS_DECI[115].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[115].MMS = 0;
		CLASS_DECI[115].MMA = 0;
		CLASS_DECI[115].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[115].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[115].JC = JC_NONE;
		CLASS_DECI[115].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[115].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[115].PIXO = '{PATS_NULL};
		CLASS_DECI[115].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[115].PCS = PCS_NONE;
		CLASS_DECI[115].PCW = 1;
		CLASS_DECI[115].NST = STATE + 5'd1;
		CLASS_DECI[115].LST = 1;
		CLASS_DECI[115].ILI = 0;
		
begin

begin //CVXYL Rs,Rd
unique case (1'b1)
STATE_OH[0]: begin //(Rs->Rd)
CLASS_DECI[115].RWA = '{RS_REGB, 1'b1};
CLASS_DECI[115].LST = 0;
end
STATE_OH[1]: begin //XYToL(Rd.XY)->Rd
CLASS_DECI[115].AIA = '{IMM_K, CV_0 , AS_PIX  , EO_NONE};
CLASS_DECI[115].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[115].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[115].PALU = '{PIXOP_XYL, PIXAS_REGA, CNVS_DP};
CLASS_DECI[115].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[115].LST = 0;
end
default: begin //(Rd+B4->Rd)//TODO: if Rd in A file
CLASS_DECI[115].RS = 4'd4; rs_high_keep = 0; rs_low_keep = 0;
CLASS_DECI[115].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[115].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[115].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[115].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[115].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[115].R = CLASS_DECI[115].R | IC[4];
		CLASS_DECI[115].RD = CLASS_DECI[115].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[115].RS = CLASS_DECI[115].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[115].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 116.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[116].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[116].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[116].R = 0;
		CLASS_DECI[116].M = 0;
		CLASS_DECI[116].F = IC[9];
		CLASS_DECI[116].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[116].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[116].FT = '{FSI_32, 1'b0};
		CLASS_DECI[116].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[116].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[116].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[116].IWL = IW_NONE;
		CLASS_DECI[116].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[116].MMS = 0;
		CLASS_DECI[116].MMA = 0;
		CLASS_DECI[116].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[116].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[116].JC = JC_NONE;
		CLASS_DECI[116].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[116].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[116].PIXO = '{PATS_NULL};
		CLASS_DECI[116].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[116].PCS = PCS_NONE;
		CLASS_DECI[116].PCW = 1;
		CLASS_DECI[116].NST = STATE + 5'd1;
		CLASS_DECI[116].LST = 1;
		CLASS_DECI[116].ILI = 0;
		
begin

begin  //CVSXYL Rs,Rd
unique case (1'b1)
STATE_OH[0]: begin //XYToL(Rd.XY)->Rd
CLASS_DECI[116].RS = 0; rs_high_keep = 4'hf; rs_low_keep = 0;
CLASS_DECI[116].AIA = '{IMM_K, CV_0 , AS_PIX  , EO_NONE};
CLASS_DECI[116].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[116].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[116].PALU = '{PIXOP_XYL, PIXAS_REGA, CNVS_SP};
CLASS_DECI[116].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[116].LST = 0;
end
default: begin //(Rd+Rs->Rd)
CLASS_DECI[116].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[116].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[116].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[116].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[116].LST = 0;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[116].R = CLASS_DECI[116].R | IC[4];
		CLASS_DECI[116].RD = CLASS_DECI[116].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[116].RS = CLASS_DECI[116].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[116].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 117.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[117].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[117].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[117].R = 0;
		CLASS_DECI[117].M = 0;
		CLASS_DECI[117].F = IC[9];
		CLASS_DECI[117].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[117].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[117].FT = '{FSI_32, 1'b0};
		CLASS_DECI[117].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[117].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[117].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[117].IWL = IW_NONE;
		CLASS_DECI[117].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[117].MMS = 0;
		CLASS_DECI[117].MMA = 0;
		CLASS_DECI[117].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[117].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[117].JC = JC_NONE;
		CLASS_DECI[117].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[117].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[117].PIXO = '{PATS_NULL};
		CLASS_DECI[117].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[117].PCS = PCS_NONE;
		CLASS_DECI[117].PCW = 1;
		CLASS_DECI[117].NST = STATE + 5'd1;
		CLASS_DECI[117].LST = 1;
		CLASS_DECI[117].ILI = 0;
		
begin

begin	//MOVY Rs,Rd
unique case (1'b1)
default: begin //(Rs&h0000FFFF | Rd&hFFFF0000->Rd)
CLASS_DECI[117].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[117].AIB = '{IMM_K, CV_0 , AS_PIX, EO_NONE};
CLASS_DECI[117].ALU = '{ALUOP_LOG, 4'b0010, 1'b0};
CLASS_DECI[117].PALU = '{!IC[9] ? PIXOP_MOVX : PIXOP_MOVY, PIXAS_REGB, CNVS_NO};
CLASS_DECI[117].RWA = '{RS_ALU, 1'b1};
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[117].R = CLASS_DECI[117].R | IC[4];
		CLASS_DECI[117].RD = CLASS_DECI[117].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[117].RS = CLASS_DECI[117].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[117].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 118.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[118].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[118].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[118].R = 0;
		CLASS_DECI[118].M = 0;
		CLASS_DECI[118].F = IC[9];
		CLASS_DECI[118].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[118].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[118].FT = '{FSI_32, 1'b0};
		CLASS_DECI[118].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[118].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[118].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[118].IWL = IW_NONE;
		CLASS_DECI[118].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[118].MMS = 0;
		CLASS_DECI[118].MMA = 0;
		CLASS_DECI[118].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[118].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[118].JC = JC_NONE;
		CLASS_DECI[118].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[118].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[118].PIXO = '{PATS_NULL};
		CLASS_DECI[118].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[118].PCS = PCS_NONE;
		CLASS_DECI[118].PCW = 1;
		CLASS_DECI[118].NST = STATE + 5'd1;
		CLASS_DECI[118].LST = 1;
		CLASS_DECI[118].ILI = 0;
		
begin

begin  //PIXT Rs,*Rd.XY
unique case (1'b1)
STATE_OH[0]: begin //XYToL(Rd.XY)->Rd
CLASS_DECI[118].AIA = '{IMM_K, CV_0 , AS_PIX  , EO_NONE};
CLASS_DECI[118].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[118].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[118].PALU = '{PIXOP_XYL, PIXAS_REGA, CNVS_DP};
CLASS_DECI[118].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[118].LST = 0;
end
STATE_OH[1]: begin //(Rd+R4->Rd)
CLASS_DECI[118].RS = 4'd4; rs_high_keep = 0; rs_low_keep = 0;
CLASS_DECI[118].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[118].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[118].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[118].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[118].LST = 0;
end
default: begin //(Rs->*Rd)
CLASS_DECI[118].FT = '{FSI_PS, 1'b0};
CLASS_DECI[118].PIXO = '{PATS_REG};
CLASS_DECI[118].MC = '{MAS_RA, MDS_PIX, MA_WRITE, MT_PIX};
CLASS_DECI[118].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[118].R = CLASS_DECI[118].R | IC[4];
		CLASS_DECI[118].RD = CLASS_DECI[118].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[118].RS = CLASS_DECI[118].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[118].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 119.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[119].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[119].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[119].R = 0;
		CLASS_DECI[119].M = 0;
		CLASS_DECI[119].F = IC[9];
		CLASS_DECI[119].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[119].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[119].FT = '{FSI_32, 1'b0};
		CLASS_DECI[119].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[119].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[119].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[119].IWL = IW_NONE;
		CLASS_DECI[119].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[119].MMS = 0;
		CLASS_DECI[119].MMA = 0;
		CLASS_DECI[119].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[119].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[119].JC = JC_NONE;
		CLASS_DECI[119].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[119].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[119].PIXO = '{PATS_NULL};
		CLASS_DECI[119].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[119].PCS = PCS_NONE;
		CLASS_DECI[119].PCW = 1;
		CLASS_DECI[119].NST = STATE + 5'd1;
		CLASS_DECI[119].LST = 1;
		CLASS_DECI[119].ILI = 0;
		
begin

begin  //PIXT *Rs.XY,Rd
unique case (1'b1)
STATE_OH[0]: begin //XYToL(Rs.XY)->Rs
CLASS_DECI[119].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[119].AIB = '{IMM_K, CV_0 , AS_PIX  , EO_NONE};
CLASS_DECI[119].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[119].PALU = '{PIXOP_XYL, PIXAS_REGB, CNVS_SP};
CLASS_DECI[119].RWB = '{RS_ALU, 1'b1};
CLASS_DECI[119].LST = 0;
end
STATE_OH[1]: begin //(Rs+R4->Rd)
CLASS_DECI[119].RD = 4'd4; rd_keep = 0;
CLASS_DECI[119].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[119].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[119].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[119].RWB = '{RS_ALU, 1'b1};
CLASS_DECI[119].LST = 0;
end
STATE_OH[2]: begin //(*Rs->BUF)
CLASS_DECI[119].FT = '{FSI_PS, 1'b0};
CLASS_DECI[119].MC = '{MAS_RB, MDS_REGA, MA_READ, MT_PIX};
CLASS_DECI[119].LST = 0;
end
default: begin //(BUF->Rd)
CLASS_DECI[119].FT = '{FSI_PS, 1'b0};
CLASS_DECI[119].ALU = '{ALUOP_MOV, 4'b0000, 1'b0};
CLASS_DECI[119].RWA = '{RS_MEM, 1'b1};
CLASS_DECI[119].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[119].R = CLASS_DECI[119].R | IC[4];
		CLASS_DECI[119].RD = CLASS_DECI[119].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[119].RS = CLASS_DECI[119].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[119].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 120.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[120].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[120].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[120].R = 0;
		CLASS_DECI[120].M = 0;
		CLASS_DECI[120].F = IC[9];
		CLASS_DECI[120].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[120].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[120].FT = '{FSI_32, 1'b0};
		CLASS_DECI[120].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[120].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[120].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[120].IWL = IW_NONE;
		CLASS_DECI[120].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[120].MMS = 0;
		CLASS_DECI[120].MMA = 0;
		CLASS_DECI[120].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[120].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[120].JC = JC_NONE;
		CLASS_DECI[120].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[120].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[120].PIXO = '{PATS_NULL};
		CLASS_DECI[120].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[120].PCS = PCS_NONE;
		CLASS_DECI[120].PCW = 1;
		CLASS_DECI[120].NST = STATE + 5'd1;
		CLASS_DECI[120].LST = 1;
		CLASS_DECI[120].ILI = 0;
		
begin

begin  //PIXT *Rs.XY,*Rd.XY
unique case (1'b1)
STATE_OH[0]: begin //XYToL(Rs.XY)->Rs
CLASS_DECI[120].AIA = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[120].AIB = '{IMM_K, CV_0 , AS_PIX  , EO_NONE};
CLASS_DECI[120].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[120].PALU = '{PIXOP_XYL, PIXAS_REGB, CNVS_SP};
CLASS_DECI[120].RWB = '{RS_ALU, 1'b1};
CLASS_DECI[120].LST = 0;
end
STATE_OH[1]: begin //(Rs+R4->Rd)
CLASS_DECI[120].RD = 4'd4; rd_keep = 0;
CLASS_DECI[120].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[120].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[120].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[120].RWB = '{RS_ALU, 1'b1};
CLASS_DECI[120].LST = 0;
end
STATE_OH[2]: begin //XYToL(Rd.XY)->Rd
CLASS_DECI[120].AIA = '{IMM_K, CV_0 , AS_PIX  , EO_NONE};
CLASS_DECI[120].AIB = '{IMM_K, CV_0 , AS_CONST, EO_NONE};
CLASS_DECI[120].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[120].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[120].PALU = '{PIXOP_XYL, PIXAS_REGA, CNVS_DP};
CLASS_DECI[120].LST = 0;
end
STATE_OH[3]: begin //(Rd+R4->Rd)
CLASS_DECI[120].RS = 4'd4; rs_high_keep = 0; rs_low_keep = 0;
CLASS_DECI[120].AIA = '{IMM_K, CV_0 , AS_REGA, EO_NONE};
CLASS_DECI[120].AIB = '{IMM_K, CV_0 , AS_REGB, EO_NONE};
CLASS_DECI[120].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
CLASS_DECI[120].RWA = '{RS_ALU, 1'b1};
CLASS_DECI[120].LST = 0;
end
STATE_OH[4]: begin //(*Rs->BUF)
CLASS_DECI[120].FT = '{FSI_PS, 1'b0};
CLASS_DECI[120].MC = '{MAS_RB, MDS_REGA, MA_READ, MT_PIX};
CLASS_DECI[120].LST = 0;
end
default: begin //(BUF->*Rd)
CLASS_DECI[120].FT = '{FSI_PS, 1'b0};
CLASS_DECI[120].PIXO = '{PATS_MEM};
CLASS_DECI[120].MC = '{MAS_RA, MDS_PIX, MA_WRITE, MT_PIX};
CLASS_DECI[120].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[120].R = CLASS_DECI[120].R | IC[4];
		CLASS_DECI[120].RD = CLASS_DECI[120].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[120].RS = CLASS_DECI[120].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[120].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 121.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[121].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[121].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[121].R = 0;
		CLASS_DECI[121].M = 0;
		CLASS_DECI[121].F = IC[9];
		CLASS_DECI[121].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[121].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[121].FT = '{FSI_32, 1'b0};
		CLASS_DECI[121].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[121].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[121].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[121].IWL = IW_NONE;
		CLASS_DECI[121].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[121].MMS = 0;
		CLASS_DECI[121].MMA = 0;
		CLASS_DECI[121].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[121].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[121].JC = JC_NONE;
		CLASS_DECI[121].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[121].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[121].PIXO = '{PATS_NULL};
		CLASS_DECI[121].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[121].PCS = PCS_NONE;
		CLASS_DECI[121].PCW = 1;
		CLASS_DECI[121].NST = STATE + 5'd1;
		CLASS_DECI[121].LST = 1;
		CLASS_DECI[121].ILI = 0;
		
begin

begin  //PIXT Rs,*Rd
unique case (1'b1)
default: begin //(Rs->*Rd)
CLASS_DECI[121].FT = '{FSI_PS, 1'b0};
CLASS_DECI[121].PIXO = '{PATS_REG};
CLASS_DECI[121].MC = '{MAS_RA, MDS_PIX, MA_WRITE, MT_PIX};
CLASS_DECI[121].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[121].R = CLASS_DECI[121].R | IC[4];
		CLASS_DECI[121].RD = CLASS_DECI[121].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[121].RS = CLASS_DECI[121].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[121].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 122.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[122].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[122].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[122].R = 0;
		CLASS_DECI[122].M = 0;
		CLASS_DECI[122].F = IC[9];
		CLASS_DECI[122].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[122].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[122].FT = '{FSI_32, 1'b0};
		CLASS_DECI[122].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[122].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[122].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[122].IWL = IW_NONE;
		CLASS_DECI[122].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[122].MMS = 0;
		CLASS_DECI[122].MMA = 0;
		CLASS_DECI[122].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[122].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[122].JC = JC_NONE;
		CLASS_DECI[122].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[122].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[122].PIXO = '{PATS_NULL};
		CLASS_DECI[122].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[122].PCS = PCS_NONE;
		CLASS_DECI[122].PCW = 1;
		CLASS_DECI[122].NST = STATE + 5'd1;
		CLASS_DECI[122].LST = 1;
		CLASS_DECI[122].ILI = 0;
		
begin

begin  //PIXT *Rs,Rd
unique case (1'b1)
STATE_OH[0]: begin //(*Rs->BUF)
CLASS_DECI[122].FT = '{FSI_PS, 1'b0};
CLASS_DECI[122].MC = '{MAS_RB, MDS_REGA, MA_READ, MT_PIX};
CLASS_DECI[122].LST = 0;
end
default: begin //(BUF->Rd)
CLASS_DECI[122].FT = '{FSI_PS, 1'b0};
CLASS_DECI[122].ALU = '{ALUOP_MOV, 4'b0000, 1'b0};
CLASS_DECI[122].RWA = '{RS_MEM, 1'b1};
CLASS_DECI[122].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[122].R = CLASS_DECI[122].R | IC[4];
		CLASS_DECI[122].RD = CLASS_DECI[122].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[122].RS = CLASS_DECI[122].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[122].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// Parallel opcode class 123.
	always_comb begin
		bit [3:0] rd_keep, rs_low_keep, rs_high_keep;
		rd_keep = 4'hf; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[123].RD = 0; rd_keep = 4'hf;
		CLASS_DECI[123].RS = 0; rs_low_keep = 4'hf; rs_high_keep = 0;
		CLASS_DECI[123].R = 0;
		CLASS_DECI[123].M = 0;
		CLASS_DECI[123].F = IC[9];
		CLASS_DECI[123].AIA = '{IMM_K, CV_0, AS_REGA, EO_NONE};
		CLASS_DECI[123].AIB = '{IMM_K, CV_0, AS_REGB, EO_NONE};
		CLASS_DECI[123].FT = '{FSI_32, 1'b0};
		CLASS_DECI[123].ALU = '{ALUOP_ADD, 4'b0000, 1'b0};
		CLASS_DECI[123].SHC = '{SS_NONE, 3'b000};
		CLASS_DECI[123].MDC = '{MDO_NOP, MDA_NOP, MDSH_NOP};
		CLASS_DECI[123].IWL = IW_NONE;
		CLASS_DECI[123].MC = '{MAS_RA, MDS_REGA, MA_NONE, MT_DATA};
		CLASS_DECI[123].MMS = 0;
		CLASS_DECI[123].MMA = 0;
		CLASS_DECI[123].RWA = '{RS_REGA, 1'b0};
		CLASS_DECI[123].RWB = '{RS_REGA, 1'b0};
		CLASS_DECI[123].JC = JC_NONE;
		CLASS_DECI[123].PALU = '{PIXOP_NOP, PIXAS_REGA, CNVS_NO};
		CLASS_DECI[123].PF = '{PBLT_NONE, POFFS_NONE, WIN_NONE, PLN_NONE};
		CLASS_DECI[123].PIXO = '{PATS_NULL};
		CLASS_DECI[123].STW = {STU_NONE, 4'b0000};
		CLASS_DECI[123].PCS = PCS_NONE;
		CLASS_DECI[123].PCW = 1;
		CLASS_DECI[123].NST = STATE + 5'd1;
		CLASS_DECI[123].LST = 1;
		CLASS_DECI[123].ILI = 0;
		
begin

begin  //PIXT *Rs,*Rd
unique case (1'b1)
STATE_OH[0]: begin //(*Rs->BUF)
CLASS_DECI[123].FT = '{FSI_PS, 1'b0};
CLASS_DECI[123].MC = '{MAS_RB, MDS_REGA, MA_READ, MT_PIX};
CLASS_DECI[123].LST = 0;
end
default: begin //(BUF->*Rd)
CLASS_DECI[123].FT = '{FSI_PS, 1'b0};
CLASS_DECI[123].PIXO = '{PATS_MEM};
CLASS_DECI[123].MC = '{MAS_RA, MDS_PIX, MA_WRITE, MT_PIX};
CLASS_DECI[123].LST = 1;
end
endcase
end
end

		// Keep instruction operand bits out of the microcode priority muxes.
		CLASS_DECI[123].R = CLASS_DECI[123].R | IC[4];
		CLASS_DECI[123].RD = CLASS_DECI[123].RD | (IC[3:0] & rd_keep);
		CLASS_DECI[123].RS = CLASS_DECI[123].RS | (IC_RS_STATIC & rs_low_keep) | (IC[3:0] & rs_high_keep);
		// Only MMTM/MMFM use the multiple-register cursor after their first
		// three states. Decode it directly instead of through nested muxes.
		CLASS_DECI[123].MMA = IC[15:8] == 8'h09 && IC[7:6] == 2'b10 && !(|STATE_OH[2:0]);
	end
	



	// IC_MATCHES is the complete one-hot opcode partition.
	always_comb begin
		CLASS_DELTA = '0;
		for (int c=0; c<124; c++)
			CLASS_DELTA |= (CLASS_DECI[c] ^ BASE_DECI) & {$bits(DecInstr_t){IC_MATCHES[c]}};
		DECI = BASE_DECI ^ CLASS_DELTA;
		DECI_AT_PRE = DECI.MC.AT;
		OPSEL_COMB = {DECI.AIA,DECI.AIB,DECI.SHC,DECI.F,DECI.MC.AS,DECI.MC.DS};
		// Registered predecode of the same (IC,STATE)-only fields.
		if (OPSEL_REG) {DECI.AIA,DECI.AIB,DECI.SHC,DECI.F,DECI.MC.AS,DECI.MC.DS} = OPSEL;
		// Class 52 state 18 (PATS_B pixel write) writes only when PIX_WE.
		if (IC_MATCHES[52] && STATE_OH[18] && !PIX_WE) DECI.MC.AT = MA_NONE;
		DECI.MMA = LINE_GZ ? IC_RF_ADDR_POS[9] : IC_RF_ADDR[9];
		DECI.R = LINE_GZ ? IC_RF_ADDR_POS[8] : IC_RF_ADDR[8];
		DECI.RD = LINE_GZ ? IC_RF_ADDR_POS[7:4] : IC_RF_ADDR[7:4];
		DECI.RS = LINE_GZ ? IC_RF_ADDR_POS[3:0] : IC_RF_ADDR[3:0];
	end

endmodule
