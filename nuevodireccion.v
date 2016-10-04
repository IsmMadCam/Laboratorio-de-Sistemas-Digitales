`timescale 1ns / 10ps

module nuevodireccion(
	input wire clk,
	input wire reset,
	input wire resetcounterdireccion,
	input wire raa, rab, rac, rad, rae, raf, rag, rah,
	output reg fkaa, fkab, fkac, fkad, fkae, fkaf, fkag, fkah,
	output reg [5:0] counterdireccion,
	output reg listodireccion,
	output reg acs, ard, awr, aad //variables de control del rtc.
    );

localparam STATE_Initial = 3'b000,
	STATE_1 = 3'b001, 
	STATE_2 = 3'b010,
	STATE_3 = 3'b011,
	STATE_4 = 3'b100,
	STATE_5 = 3'b101,
	STATE_6 = 3'b110,
	STATE_7 = 3'b111;

reg[2:0] CurrentState;
reg[2:0] NextState;

initial counterdireccion = 0;
initial listodireccion = 0;

always @(posedge clk or negedge resetcounterdireccion) begin
	if (!resetcounterdireccion)
		counterdireccion = 0;
	else
		counterdireccion = counterdireccion + 1'b1;
end

always @(posedge clk) begin
	if (reset) CurrentState <= STATE_Initial;
	else CurrentState <= NextState;
end

always @(*) begin
	NextState = CurrentState;
	case (CurrentState)
		STATE_Initial: begin
			if (counterdireccion == 1) NextState = STATE_1;
			
			acs <= 1;
			ard <= 1;
			awr <= 1;
			aad <= 1;
			fkaa <= 0;
			fkab <= 0;
			fkac <= 0;
			fkad <= 0;
			fkae <= 0;
			fkaf <= 0;
			fkag <= 0;
			fkah <= 0;
		end
		
		STATE_1: begin
			if (counterdireccion == 11) NextState = STATE_2;
			
			acs <= 1;
			ard <= 1;
			awr <= 1;
			aad <= 0;
			fkaa <= 0;
			fkab <= 0;
			fkac <= 0;
			fkad <= 0;
			fkae <= 0;
			fkaf <= 0;
			fkag <= 0;
			fkah <= 0;
		end
		
		STATE_2: begin
			if (counterdireccion == 21) NextState = STATE_3;
			
			acs <= 0;
			ard <= 1;
			awr <= 0;
			aad <= 0;
			fkaa <= 0;
			fkab <= 0;
			fkac <= 0;
			fkad <= 0;
			fkae <= 0;
			fkaf <= 0;
			fkag <= 0;
			fkah <= 0;
		end
		
		STATE_3: begin
			if (counterdireccion == 23) NextState = STATE_4;
			
			acs <= 0;
			ard <= 1;
			awr <= 0;
			aad <= 0;
			fkaa <= 0;
			fkab <= 0;
			fkac <= 0;
			fkad <= 0;
			fkae <= 0;
			fkaf <= 0;
			fkag <= 0;
			fkah <= 0;
		end
		
		STATE_4: begin //en este estado debe mandarse la direccion.
			if (counterdireccion == 26) NextState = STATE_5;
		
			acs <= 0;
			ard <= 1;
			awr <= 0;
			aad <= 0;
			fkaa <= raa;
			fkab <= rab;
			fkac <= rac;
			fkad <= rad;
			fkae <= rae;
			fkaf <= raf;
			fkag <= rag;
			fkah <= rah;
		end
		
		STATE_5: begin
			if (counterdireccion == 36) NextState = STATE_6;
			
			acs <= 1;
			ard <= 1;
			awr <= 1;
			aad <= 0;
			fkaa <= 0;
			fkab <= 0;
			fkac <= 0;
			fkad <= 0;
			fkae <= 0;
			fkaf <= 0;
			fkag <= 0;
			fkah <= 0; 
		end
		
		STATE_6: begin
			if (counterdireccion == 46) NextState = STATE_7;
			
			acs <= 1;
			ard <= 1;
			awr <= 1;
			aad <= 1;
			fkaa <= 0;
			fkab <= 0;
			fkac <= 0;
			fkad <= 0;
			fkae <= 0;
			fkaf <= 0;
			fkag <= 0;
			fkah <= 0;
		end
		
		STATE_7: begin
			listodireccion = 1;
		end
	endcase
	
end


endmodule
