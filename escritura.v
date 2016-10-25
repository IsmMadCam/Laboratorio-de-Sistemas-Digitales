`timescale 1ns / 10ps

module escritura(
	input wire clk,
	input wire reset,
	input wire ensec, enmin, enhour, enday, enmonth, enyear,
	input wire resetcountere,
	input wire rda, rdb, rdc, rdd, rde, rdf, rdg, rdh,
	output reg [7:0] countere,
	output reg ecs, erd, ewr, ead,
	output reg listoescritura,
	output reg listoe,
	output reg fkda, fkdb, fkdc, fkdd, fkde, fkdf, fkdg, fkdh
    );

localparam STATE_Initial = 3'b000,
	STATE_1 = 3'b001,
	STATE_2 = 3'b010,
	STATE_3 = 3'b011,
	STATE_4 = 3'b100,
	STATE_5 = 3'b101,
	STATE_6 = 3'b110,
	STATE_7_PlaceHolder = 3'b111;

/*
reg[2:0] CurrentState;
reg[2:0] NextState;
*/

reg[2:0] CurrentState;
reg[2:0] NextState;

initial countere = 0;
initial ecs = 0;
initial erd = 0;
initial ewr = 0;
initial ead = 0;

always @(posedge clk or negedge resetcountere) begin
	if (!resetcountere)
		countere = 0;
	else
		countere = countere + 1'b1;
end

always @(posedge clk) begin
	if (reset) CurrentState <= STATE_Initial;
	else CurrentState <= NextState;
end

always @(*) begin
	NextState = CurrentState;
	case (CurrentState)
		STATE_Initial: begin
			if (countere == 1) NextState = STATE_1;
			
			listoescritura <= 0;
			listoe <= 0;
			ecs <= 1;
			erd <= 1;
			ewr <= 1;
			ead <= 1;
			fkda <= 0;
			fkdb <= 0;
			fkdc <= 0;
			fkdd <= 0;
			fkde <= 0;
			fkdf <= 0;
			fkdg <= 0;
			fkdh <= 0;
		end

		STATE_1: begin
			if (countere == 11) NextState = STATE_2;
			
			listoe <= 0;
			listoescritura <= 0;
			ecs <= 0;
			erd <= 1;
			ewr <= 1;
			ead <= 1;
			fkda <= 0;
			fkdb <= 0;
			fkdc <= 0;
			fkdd <= 0;
			fkde <= 0;
			fkdf <= 0;
			fkdg <= 0;
			fkdh <= 0; 
		end
		
		STATE_2: begin
			if (countere == 21) NextState = STATE_3;
			
			listoe <= 0;
			listoescritura <= 0;
			ecs <= 0;
			erd <= 1;
			ewr <= 0;
			ead <= 1;
			fkda <= 0;
			fkdb <= 0;
			fkdc <= 0;
			fkdd <= 0;
			fkde <= 0;
			fkdf <= 0;
			fkdg <= 0;
			fkdh <= 0; 
		end
		
		STATE_3: begin //en este estado debe mandarse el dato.
			if (countere == 26) NextState = STATE_4;
			
			listoe <= 1;
			listoescritura <= 0;
			ecs <= 0;
			erd <= 1;
			ewr <= 0;
			ead <= 1;
			fkda <= rda;
			fkdb <= rdb;
			fkdc <= rdc;
			fkdd <= rdd;
			fkde <= rde;
			fkdf <= rdf;
			fkdg <= rdg;
			fkdh <= rdh; 
		end
		
		STATE_4: begin
			if (countere == 36) NextState = STATE_5;
			
			listoe <= 0;
			listoescritura <= 0;
			ecs <= 0;
			erd <= 1;
			ewr <= 1;
			ead <= 1;
			fkda <= 0;
			fkdb <= 0;
			fkdc <= 0;
			fkdd <= 0;
			fkde <= 0;
			fkdf <= 0;
			fkdg <= 0;
			fkdh <= 0; 
		end
			
		STATE_5: begin
			if (countere == 46) NextState = STATE_6;

			listoe <= 0;
			listoescritura <= 0;
			ecs <= 1;
			erd <= 1; 
			ewr <= 1;
			ead <= 1;
			fkda <= 0;
			fkdb <= 0;
			fkdc <= 0;
			fkdd <= 0;
			fkde <= 0;
			fkdf <= 0;
			fkdg <= 0;
			fkdh <= 0; 
		end
		
		STATE_6: begin
			listoescritura <= 1;
			NextState = STATE_Initial;
		end
		
		STATE_7_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		
	endcase
	
end


endmodule
