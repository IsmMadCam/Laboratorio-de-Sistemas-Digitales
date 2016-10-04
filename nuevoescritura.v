`timescale 1ns / 10ps

module nuevoescritura(
	input wire clk,
	input wire reset,
	input wire resetcountere,
	input wire rda, rdb, rdc, rdd, rde, rdf, rdg, rdh,
	output reg [4:0] countere,
	output reg ecs, erd, ewr, ead,
	output reg listoescritura,
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

reg[2:0] CurrentState;
reg[2:0] NextState;

initial countere = 0;
initial listoescritura = 0;

always @(*) begin
	NextState = CurrentState;
	case (CurrentState)
		STATE_Initial: begin
			if (countere == 1) NextState = STATE_1;
			
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
		
		STATE_2: begin
			if (countere == 13) NextState = STATE_3;
			
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
			if (countere == 16) NextState = STATE_4;
			
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
			if (countere == 26) NextState = STATE_5;
			
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
			
		STATE_5: begin
			if (countere == 27) NextState = STATE_6;
			
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
			listoescritura = 1;
		end
		
		STATE_7_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		
	endcase
	
end

endmodule
