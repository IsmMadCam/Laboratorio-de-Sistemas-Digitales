`timescale 1ns / 10ps

module controlregistros(
		input wire clk, reset,
		input wire ensec, enmin, enhour, enday, enmonth, enyear,
		input wire listo,
		input wire escribir,
		input wire lees, leem, leeh, leed, leems, leea,
		input wire listoescritura, listolectura,
		output reg leerdays, escribirdays, leersecs, escribirsecs, leerhours, escribirhours,
		output reg leermins, escribirmins, leermonths, escribirmonths, leeryears, escribiryears
    );

localparam STATE_Initial = 4'b0000,
	STATE_1 = 4'b0001,
	STATE_2 = 4'b0010,
	STATE_3 = 4'b0011,
	STATE_4 = 4'b0100,
	STATE_5 = 4'b0101,
	STATE_6 = 4'b0110,
	STATE_7 = 4'b0111,
	STATE_8 = 4'b1000,
	STATE_9 = 4'b1000,
	STATE_10 = 4'b1000,
	STATE_11 = 4'b1000,
	STATE_12 = 4'b1000,
	STATE_13_PlaceHolder = 4'b1000,
	STATE_14_PlaceHolder = 4'b1000,
	STATE_15_PlaceHolder = 4'b1000;

reg[3:0] CurrentState;
reg[3:0] NextState;

always @(posedge clk) begin
	if (reset) CurrentState <= STATE_Initial;
	else CurrentState <= NextState;
end

always @(*) begin
	NextState = CurrentState;
	case (CurrentState)
		STATE_Initial: begin
			if ((escribir)&(ensec)) NextState = STATE_1;
			if ((escribir)&(enmin)) NextState = STATE_2;
			if ((escribir)&(enhour)) NextState = STATE_3;
			if ((escribir)&(enday)) NextState = STATE_4;
			if ((escribir)&(enmonth)) NextState = STATE_5;
			if ((escribir)&(enyear)) NextState = STATE_6;
			if ((listo)&(lees)) NextState = STATE_7;
			if ((listo)&(leem)) NextState = STATE_8;
			if ((listo)&(leeh)) NextState = STATE_9;
			if ((listo)&(leed)) NextState = STATE_10;
			if ((listo)&(leems)) NextState = STATE_11;
			if ((listo)&(leea)) NextState = STATE_12;
			
			leerdays <= 0;
			escribirdays <= 0;
			leersecs <= 0;
			escribirsecs <= 0;
			leermonths <= 0;
			escribirmonths <= 0;
			leeryears <= 0;
			escribiryears <= 0;
			leermins <= 0;
			escribirmins <= 0;
			leerhours <= 0;
			escribirhours <= 0;
		end
		STATE_1: begin
			leerdays <= 0;
			escribirdays <= 0;
			leersecs <= 0;
			escribirsecs <= 1;
			leermonths <= 0;
			escribirmonths <= 0;
			leeryears <= 0;
			escribiryears <= 0;
			leermins <= 0;
			escribirmins <= 0;
			leerhours <= 0;
			escribirhours <= 0;
		end
		STATE_2: begin
			leerdays <= 0;
			escribirdays <= 0;
			leersecs <= 0;
			escribirsecs <= 0;
			leermonths <= 0;
			escribirmonths <= 0;
			leeryears <= 0;
			escribiryears <= 0;
			leermins <= 0;
			escribirmins <= 1;
			leerhours <= 0;
			escribirhours <= 0;		
		end
		STATE_3: begin
			leerdays <= 0;
			escribirdays <= 0;
			leersecs <= 0;
			escribirsecs <= 0;
			leermonths <= 0;
			escribirmonths <= 0;
			leeryears <= 0;
			escribiryears <= 0;
			leermins <= 0;
			escribirmins <= 0;
			leerhours <= 0;
			escribirhours <= 1;		
		end
		STATE_4: begin
			leerdays <= 0;
			escribirdays <= 1;
			leersecs <= 0;
			escribirsecs <= 0;
			leermonths <= 0;
			escribirmonths <= 0;
			leeryears <= 0;
			escribiryears <= 0;
			leermins <= 0;
			escribirmins <= 0;
			leerhours <= 0;
			escribirhours <= 0;		
		end
		STATE_5: begin
			leerdays <= 0;
			escribirdays <= 0;
			leersecs <= 0;
			escribirsecs <= 0;
			leermonths <= 0;
			escribirmonths <= 1;
			leeryears <= 0;
			escribiryears <= 0;
			leermins <= 0;
			escribirmins <= 0;
			leerhours <= 0;
			escribirhours <= 0;		
		end
		STATE_6: begin
			leerdays <= 0;
			escribirdays <= 0;
			leersecs <= 0;
			escribirsecs <= 0;
			leermonths <= 0;
			escribirmonths <= 0;
			leeryears <= 0;
			escribiryears <= 1;
			leermins <= 0;
			escribirmins <= 0;
			leerhours <= 0;
			escribirhours <= 0;		
		end
		STATE_7: begin
			leerdays <= 0;
			escribirdays <= 0;
			leersecs <= 1;
			escribirsecs <= 0;
			leermonths <= 0;
			escribirmonths <= 0;
			leeryears <= 0;
			escribiryears <= 0;
			leermins <= 0;
			escribirmins <= 0;
			leerhours <= 0;
			escribirhours <= 0;		
		end
		STATE_8: begin
			leerdays <= 0;
			escribirdays <= 0;
			leersecs <= 0;
			escribirsecs <= 0;
			leermonths <= 0;
			escribirmonths <= 0;
			leeryears <= 0;
			escribiryears <= 0;
			leermins <= 1;
			escribirmins <= 0;
			leerhours <= 0;
			escribirhours <= 0;		
		end
		STATE_9: begin
			leerdays <= 0;
			escribirdays <= 0;
			leersecs <= 0;
			escribirsecs <= 0;
			leermonths <= 0;
			escribirmonths <= 0;
			leeryears <= 0;
			escribiryears <= 0;
			leermins <= 0;
			escribirmins <= 0;
			leerhours <= 1;
			escribirhours <= 0;		
		end
		STATE_10: begin
			leerdays <= 1;
			escribirdays <= 0;
			leersecs <= 0;
			escribirsecs <= 0;
			leermonths <= 0;
			escribirmonths <= 0;
			leeryears <= 0;
			escribiryears <= 0;
			leermins <= 0;
			escribirmins <= 0;
			leerhours <= 0;
			escribirhours <= 0;		
		end
		STATE_11: begin
			leerdays <= 0;
			escribirdays <= 0;
			leersecs <= 0;
			escribirsecs <= 0;
			leermonths <= 1;
			escribirmonths <= 0;
			leeryears <= 0;
			escribiryears <= 0;
			leermins <= 0;
			escribirmins <= 0;
			leerhours <= 0;
			escribirhours <= 0;		
		end
		STATE_12: begin
		
			leerdays <= 0;
			escribirdays <= 0;
			leersecs <= 0;
			escribirsecs <= 0;
			leermonths <= 0;
			escribirmonths <= 0;
			leeryears <= 1;
			escribiryears <= 0;
			leermins <= 0;
			escribirmins <= 0;
			leerhours <= 0;
			escribirhours <= 0;		
		end
		STATE_13_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_14_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_15_PlaceHolder: begin
			NextState = STATE_Initial;
		end
	endcase
end


endmodule
