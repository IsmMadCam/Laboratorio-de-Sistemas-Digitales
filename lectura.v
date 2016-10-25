`timescale 1ns / 10ps

module lectura(
    input wire clk,
    input wire reset,
	 input wire ensec, enmin, enhour, enday, enmonth, enyear,
    input wire resetcounterl,
	 input wire lrda, lrdb, lrdc, lrdd, lrde, lrdf, lrdg, lrdh, 
    output reg [7:0] counterl,
    output reg lcs, lrd, lwr, lad,
	 output reg listolectura,
	 output reg listo,
	 output reg lfkda, lfkdb, lfkdc, lfkdd, lfkde, lfkdf, lfkdg, lfkdh
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

initial counterl = 0;
initial lcs = 0;
initial lrd = 0;
initial lwr = 0;
initial lad = 0;

// Se reinicia en contador o se aumenta en uno el contador     
always @(posedge clk or negedge resetcounterl) begin
    if (!resetcounterl)
        counterl = 0;
    else
        counterl = counterl + 1'b1;
    end
          
//Logica de Estado siguiente          
always @(posedge clk) begin
    if (reset) CurrentState <= STATE_Initial;
    else CurrentState <= NextState;
end

always @(*) begin
    NextState = CurrentState;
    case (CurrentState)
        STATE_Initial: begin
            if (counterl == 1) NextState = STATE_1;
            
				listo <= 0;
				listolectura <= 0;
            lcs <= 1;
            lrd <= 1;
            lwr <= 1;
            lad <= 1;
				lfkda <= 0;
				lfkdb <= 0;
				lfkdc <= 0;
				lfkdd <= 0;
				lfkde <= 0;
				lfkdf <= 0;
				lfkdg <= 0;
				lfkdh <= 0;
        end
        
        STATE_1: begin
            if (counterl == 11) NextState = STATE_2;
            
				listo <= 0;
				listolectura <= 0;
            lcs <= 0;
            lrd <= 1;
            lwr <= 1;
            lad <= 1;
				lfkda <= 0;
				lfkdb <= 0;
				lfkdc <= 0;
				lfkdd <= 0;
				lfkde <= 0;
				lfkdf <= 0;
				lfkdg <= 0;
				lfkdh <= 0;
        end
          
        STATE_2: begin
            if (counterl == 21) NextState = STATE_3;
            
				listo <= 0;
				listolectura <= 0;
            lcs <= 0;
            lrd <= 0;
            lwr <= 1;
            lad <= 1;
				lfkda <= 0;
				lfkdb <= 0;
				lfkdc <= 0;
				lfkdd <= 0;
				lfkde <= 0;
				lfkdf <= 0;
				lfkdg <= 0;
				lfkdh <= 0;
        end
          
        STATE_3: begin //Aqui se manda la direccion.
            if (counterl == 26) NextState = STATE_4;
            
				listo <= 1;
				listolectura <= 0;
            lcs <= 0;
            lrd <= 0;
            lwr <= 1;
            lad <= 1;
				lfkda <= lrda;
				lfkdb <= lrdb;
				lfkdc <= lrdc;
				lfkdd <= lrdd;
				lfkde <= lrde;
				lfkdf <= lrdf;
				lfkdg <= lrdg;
				lfkdh <= lrdh;
        end
          
        STATE_4: begin 
            if (counterl == 36) NextState = STATE_5;
            
				listo <= 0;
				listolectura <= 0;
            lcs <= 0;
            lrd <= 1;
            lwr <= 1;
            lad <= 1;
				lfkda <= 0;
				lfkdb <= 0;
				lfkdc <= 0;
				lfkdd <= 0;
				lfkde <= 0;
				lfkdf <= 0;
				lfkdg <= 0;
				lfkdh <= 0;
        end
          
        STATE_5: begin
            if (counterl == 46) begin
					listolectura <= 1;
					NextState = STATE_6;
            end
				
				listo <= 0;
            lcs <= 1;
            lrd <= 1;
            lwr <= 1;
            lad <= 1;
				lfkda <= 0;
				lfkdb <= 0;
				lfkdc <= 0;
				lfkdd <= 0;
				lfkde <= 0;
				lfkdf <= 0;
				lfkdg <= 0;
				lfkdh <= 0;
        end
          
        STATE_6: begin
				NextState = STATE_Initial;
        end
		 
        STATE_7_PlaceHolder: begin
           	NextState = STATE_Initial;
        end
       
    endcase

end


endmodule
